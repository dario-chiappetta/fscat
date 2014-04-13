fscat - Hardlink-based media catalogue system
=============================================
Fscat is a small Python script that allows you to keep a catalogue of 
your media collections (movies, series, pictures, etc...) using Unix
hardlinks to generate multiple taxonomies for each set of files.

**Note**: right now the script is just a stub, it works ok for films but 
many features are still to be added, code to be polished, documentation 
to be written etc...

How does it work
----------------
Let's setup a movie collection: to do that, you need to:

0. Place all your movie files, in no particular order in a directory
named _data/
1. Initialise the metafiles (i.e. set title, language, genre etc.) for 
your movies.
2. Configure the indices (e.g. define an index "by genre" and one "by 
language")
3. Build the collection

Fscat will crawl your metafiles and replicate the movie files, as 
hardlinks, in every index you have defined.

For example...
--------------
...if you have a movie file

'''
title: The Matrix
year: 1999
genre: sci-fi
language: EN
files: ["_data/matrix.avi", "_data/covers/thematrix.png"]
'''

And the two indices

'''
by_genre: $GENRE/$YEAR - $TITLE/
by_language: $LANG/$GENRE/$YEAR - $TITLE/
'''

fscat will replicate the files as:

'''
by_genre/sci-fi/1999 - The Matrix/matrix.avi
by_genre/sci-fi/1999 - The Matrix/thematrix.png

by_language/EN/sci-fi/1999 - The Matrix/matrix.avi
by_language/EN/sci-fi/1999 - The Matrix/thematrix.png
'''

Of course, since it's using hardlinks no extra disk space will be 
occupied.

Installation
------------
Just copy the script into one of your PATH's directories, e.g.

'''bash
sudo cp fscat /usr/bin/fscat
'''

Initialise the collection
-------------------------
Move in the directory that contains your "_data/" folder and run the 
init command:

'''bash
cd /home/dario/film
fscat init
'''

A procedure will guide you through the creation of the metafiles, trying 
to guess as much as possible from the filenames. Note that the procedure 
works well when every movie has its own directory. When this is not the 
case, you'll have to edit the XML metafiles (.meta) manually.

Configure the indices
---------------------
In the same directory that contains the "_data/" folder, create a ".fscat"
file. This is an XML file that contains the collection's configuration.

You can use the following as an example:
'''
<collection>
	<name>Film</name>

	<index>
		<name>Alphabetical</name>
		<root>by_name/</root>
		<path>$INITIAL/$TITLE/</path>
	</index>
	
	<index>
		<name>By Genre</name>
		<root>by_genre/</root>
		<path>$GENRE/$YEAR - $TITLE/</path>
	</index>
	
	<index>
		<name>By Language</name>
		<root>by_language/</root>
		<path>$LANG/$GENRE/$YEAR - $TITLE/</path>
	</index>
	
</collection>
'''

Build the collection
--------------------
Once you have the metafiles and the collection's configuration, you can 
build your indices launching the "build" command in the same directory 
that contains the "_data/" folder:

'''bash
fscat build
'''

Enjoy your movies :)
