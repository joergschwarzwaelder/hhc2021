# Bonus Blue Log4Jack
**Location: North Pole**  
**Elf: Bow Ninecandle**

This exercise runs in a Cranberry Pi terminal.
It is a guided exercise introducing Log4J and it's purpose, to have a consistent exception handling and logging method, being used in many Java applications.
It focuses on the prevention and detection side.
Log4J has lookup features (like `${java.version}`, `env:APISECRET` or `${jndi:ldap://127.0.0.1:1389/Exploit}`), which can be misused to retrieve information from the application environment or even to run arbitrary code using JNDI.
These lookup features are disabled in the newer patched Log4J version. This sample code is used to demonstrate how the lookup features work:
```java
import java.io.*;
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
```

Furthermore, the vulnerability scanner  `log4j2-scan` is introduced, which detects the use of vulnerable Log4J versions.
In addition, the script `logshell-search` is shown, which can be used to scan log files for possible attacks through Log4J based on specific patterns.

**Achievement: Log4J Blue Bonus**
