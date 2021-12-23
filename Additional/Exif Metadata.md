<h1 id="exif-metadata">Exif Metadata</h1>
<p><strong>Location: Courtyard, Santa’s Castle, , Ground Floor</strong><br>
<strong>Elf: Piney Sappington</strong></p>
<p>This objective is based on a Cranberry Pi terminal and is about obtaining information from file metadata.<br>
The terminal holds several .docx files. One of the files was modified by Jack Frost.<br>
The installed exiftool should be used to find which file is the one in question.</p>
<pre><code>for f in *; do echo $f; exiftool -LastModifiedBy $f; done
</code></pre>
<p>It turns out that all files were last modified by “Santa Claus” except file <strong>2021-12-21.docx</strong>, which was last modified by Jack Frost.</p>
<p><strong>Achievement "Document Analysis"</strong><br>
The Elf provides hints for <a href="https://github.com/joergschwarzwaelder/hhc2021/tree/master/Objective-2">objective 2</a>:<br>
<strong>Hint: Coordinate Systems</strong><br>
<strong>Hint: Flask Cookies</strong><br>
<strong>Hint: OSINT Talk</strong></p>

