# Exif Metadata
**Location: Courtyard, Santa's Castle, Ground Floor**
**Elf: Piney Sappington**

This objective is based on a Cranberry Pi terminal and is about obtaining information from file metadata.
The terminal holds several .docx files. One of the files was modified by Jack Frost.
The installed exiftool should be used to find which file is the one in question.

```
for f in *; do echo $f; exiftool -LastModifiedBy $f; done
```
It turns out that all files were last modified by "Santa Claus" except file **2021-12-21.docx**, which was last modified by Jack Frost.

**Achievement: Document Analysis**
The Elf provides hints for [objective 2](https://github.com/joergschwarzwaelder/hhc2021/tree/master/Objective-2):
**Hint: Coordinate Systems**
**Hint: Flask Cookies**
**Hint: OSINT Talk**
