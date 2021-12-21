<h1 id="objective-9-splunk">Objective 9: Splunk!</h1>
<p><strong>Location: Great Room</strong><br>
<strong>Elf: Angel Candysalt</strong></p>
<p>This objective is about getting familiar with the Splunk platform.</p>
<h3 id="task-1">Task 1:</h3>
<p>Capture the commands Eddie ran most often, starting with git. Looking only at his process launches as reported by Sysmon, record the most common git-related CommandLine that Eddie seemed to use.<br>
<code>index=main sourcetype=journald source=Journald:Microsoft-Windows-Sysmon/Operational EventCode=1 User=eddie | stats count by CommandLine | sort – count</code><br>
<strong>git status</strong></p>
<h3 id="task-2">Task 2:</h3>
<p>Looking through the git commands Eddie ran, determine the remote repository that he configured as the origin for the ‘partnerapi’ repo. The correct one!<br>
<code>index=main sourcetype=journald source=Journald:Microsoft-Windows-Sysmon/Operational EventCode=1 User=eddie CommandLine=*git* CommandLine=*partnerapi* | table CommandLine</code><br>
<strong><a href="mailto:git@github.com">git@github.com</a>:elfnp3/partnerapi.git</strong></p>
<h3 id="task-3">Task 3:</h3>
<p>Eddie was running Docker on his workstation. Gather the full command line that Eddie used to bring up a the partnerapi project on his workstation.</p>
<pre><code>index=main sourcetype=journald source=Journald:Microsoft-Windows-Sysmon/Operational EventCode=1 User=eddie CommandLine=*docker* | table CommandLine
</code></pre>
<p><strong>docker compose up</strong></p>
<h3 id="task-4">Task 4:</h3>
<p>Eddie had been testing automated static application security testing (SAST) in GitHub. Vulnerability reports have been coming into Splunk in JSON format via GitHub webhooks. Search all the events in the main index in Splunk and use the sourcetype field to locate these reports. Determine the URL of the vulnerable GitHub repository that the elves cloned for testing and document it here. You will need to search outside of Splunk (try GitHub) for the original name of the repository.</p>
<pre><code>index=main | stats count by sourcetype | table sourcetype

index=main sourcetype=github_json
</code></pre>
<p><strong><a href="https://github.com/snoopysecurity/dvws-node">https://github.com/snoopysecurity/dvws-node</a></strong></p>
<h3 id="task-5">Task 5:</h3>
<p>Santa asked Eddie to add a JavaScript library from NPM to the ‘partnerapi’ project. Determine the name of the library and record it here for our workshop documentation.</p>
<pre><code>index=main sourcetype=journald CommandLine="git commit*"
</code></pre>
<p><strong>holiday-utils-js</strong></p>
<h3 id="task-6">Task 6:</h3>
<p>Another elf started gathering a baseline of the network activity that Eddie generated. Start with <a href="https://hhc21.bossworkshops.io/en-US/app/SA-hhc/search?q=search%20index%3Dmain%20sourcetype%3Djournald%20source%3DJournald%3AMicrosoft-Windows-Sysmon%2FOperational%20EventCode%3D3%20user%3Deddie%20NOT%20dest_ip%20IN%20(127.0.0.*)%20NOT%20dest_port%20IN%20(22%2C53%2C80%2C443)%20%0A%7C%20stats%20count%20by%20dest_ip%20dest_port&amp;display.page.search.mode=smart&amp;dispatch.sample_ratio=1&amp;workload_pool=&amp;earliest=0&amp;latest=now">their search</a> and capture the full process_name field of anything that looks suspicious.</p>
<pre><code>index=main sourcetype=journald source=Journald:Microsoft-Windows-Sysmon/Operational EventCode=3 user=eddie NOT dest_ip IN (127.0.0.*) NOT dest_port IN (22,53,80,443)
</code></pre>
<p><strong>/usr/bin/nc.openbsd</strong></p>
<h3 id="task-7">Task 7:</h3>
<p>Uh oh. This documentation exercise just turned into an investigation. Starting with the process identified in the previous task, look for additional suspicious commands launched by the same parent process. One thing to know about these Sysmon events is that Network connection events don’t indicate the parent process ID, but Process creation events do! Determine the number of files that were accessed by a related process and record it here.</p>
<pre><code>index=main sourcetype=journald source=Journald:Microsoft-Windows-Sysmon/Operational EventCode=1 process_name="/usr/bin/nc.openbsd" | Table ParentProcessId
</code></pre>
<p>→ ParentProcessID 6788</p>
<pre><code>index=main sourcetype=journald source=Journald:Microsoft-Windows-Sysmon/Operational EventCode=1  ParentProcessId=6788 | Table CommandLine
</code></pre>
<p>These <strong>6</strong> files were accessed:<br>
<code>/home/eddie/.aws/credentials /home/eddie/.ssh/authorized_keys /home/eddie/.ssh/config /home/eddie/.ssh/eddie /home/eddie/.ssh/eddie.pub /home/eddie/.ssh/known_hosts</code></p>
<h3 id="task-8">Task 8:</h3>
<p>Use Splunk and Sysmon Process creation data to identify the name of the Bash script that accessed sensitive files and (likely) transmitted them to a remote IP address.</p>
<pre><code>index=main sourcetype=journald source=Journald:Microsoft-Windows-Sysmon/Operational EventCode=1 process_name="/usr/bin/nc.openbsd" | Table ParentProcessId
</code></pre>
<p>→ ParentProcessID 6788</p>
<pre><code>index=main sourcetype=journald source=Journald:Microsoft-Windows-Sysmon/Operational EventCode=1  ParentProcessId=6788 | Table ParentCommandLine
</code></pre>
<p>→ /bin/bash <strong><a href="http://preinstall.sh">preinstall.sh</a></strong></p>

