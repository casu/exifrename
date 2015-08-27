# exifrename
Renames images and videos regarding their EXIF timestamp.

Usage: exifrename.sh [-safe] description
Renames all jpg|JPG|avi|AVI|mov|MOV to YYYY-MM-DD-HH-MM-SS-[SU-]description.[jpg|avi|mov].
If option -safe is used a directory .original will be created where the files will be copied before renaming.
If the EXIF tag subseconds is found -SU will be added to the filename between seconds (SS) and description.
