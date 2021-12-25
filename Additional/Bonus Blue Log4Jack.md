<h1 id="bonus-blue-log4jack">Bonus Blue Log4Jack</h1>
<p><strong>Location: North Pole</strong><br>
<strong>Elf: Bow Ninecandle</strong></p>
<p>This guided exercise introduces Log4J and it’s purpose, to have a consistent exception handling and logging method, being used in many Java applications.<br>
It focuses on the prevention and detection side.<br>
Log4J has lookup features (like <code>${java.version}</code>, <code>env:APISECRET</code> or <code>${jndi:ldap://127.0.0.1:1389/Exploit}</code>), which can be misused to retrieve information from the application environment or even to run arbitrary code using JNDI.<br>
These lookup features are disabled in the newer patched Log4J version. This sample code is used to demonstrate how the lookup features work:</p>
<pre><code>import java.io.*;
import org.apache.logging.log4j.Logger;
import org.apache.logging.log4j.LogManager;

public class DisplayFilev2 {
    static Logger logger = LogManager.getLogger(DisplayFilev2.class);
    public static void main(String[] args) throws Exception {
        String st;
        try {
            File file = new File(args[0]);
            BufferedReader br = new BufferedReader(new FileReader(file));

            while ((st = br.readLine()) != null)
                System.out.println(st);
        }
        catch (Exception e) {
            logger.error("Unable to read file " + args[0] + " (make sure you specify a valid file name).");
        }
    }
}
</code></pre>
<p>Furthermore, the vulnerability scanner  <code>log4j2-scan</code> is introduced, which detects the use of vulnerable Log4J versions.<br>
In addition, the script <code>logshell-search</code> is shown, which can be used to scan log files for possible attacks through Log4J based on specific patterns.</p>
<p><strong>Achievement: Log4J Blue Bonus</strong></p>

