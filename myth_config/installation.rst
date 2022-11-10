Installation
============

Background
----------

There's a lot to learn/know around the topic of installing non-Steam games on the Deck, and I won't begin to try to cover it all here. But I can go over some things specific to Myth.

First of all, you do need to own Myth 2 so that you can get a copy of the game data.

You also need the Linux patch from `Project Magma`_. I originally designed and tested this configuration using the 1.8.3 patch, and I've done a brief test with 1.8.4. Anything 1.8.3 or later should hopefully be fine.

One thing you could do with the Linux patch is unpack it and run the little installer program that it comes with. There are a couple of problems with that though when it comes to the Deck:

* The installer wants you to point it at either an existing Myth 2 installation to update, or a mounted Myth 2 CD.
* The installer requires a code library (libgtk) that is not natively present on the Deck, and which would be a hassle to install correctly.

So the better thing to do IMO is just to yank the necessary files out of the installer manually. You can do this directly on the Deck itself. Or, you can do this on some other Linux system, and then transfer all your files to the Deck when you have a working Myth 2 installation.

In either case you will need to know how to transfer files to the Deck and how to run shell commands on the Deck. I *very strongly recommend against* trying to do the procedure below using the Deck's onscreen virtual keyboard! If you want to do the entire procedure on the Deck, you should have some other means of entering commands. You can connect a keyboard directly to the Deck, or use other methods (personally I run an ssh server on my Deck so that I can log in remotely to type commands from another computer).

Necessary Files
---------------

As mentioned above, you will need the Linux patch for Myth 2 from `Project Magma`_. For version 1.8.4 the patch filename is this:

* Myth2_184_Linux.tar.gz

For other future versions the filename will probably be similar. The instructions below assume that only those numbers in the middle will change for different versions of this patch.

You also need the game data for Myth 2, which comes in the form of five "tags" files with these names:

* international large install
* large install
* medium install
* international small install
* small install

If you already have an existing Myth 2 installation somewhere (or can create one), you can find these in the "tags" folder where the game is installed. Depending on what kind of Myth 2 CD you have you may also be able to easily find and copy them directly from the CD. In any case, you need to have these files on hand.

With these files you can create a fully patched-up Myth 2 installation, either on the Deck itself or on some other Linux system.

Game Install
------------

You're going to need to enter several commands in a shell, working in a filesystem where you have those six "necessary files" available. If you're working on some other Linux system or logging into the Deck remotely, you already have a shell you prefer to use. If you're just connecting a keyboard directly to the Deck, you need to put the Deck into desktop mode and you can start the Konsole app to get a shell.

The instructions below assume that the five tags files are located in the /home/deck/Downloads directory. They can be initially stashed wherever you like, just substitute in the correct directory name when setting the value for TAGSDIR below.

The instructions below also assume that you want to install Myth 2 at /home/deck/Games/Myth2, but again you can change that if you like (in the value for MYTHDIR). Note that if you're doing this on the Deck, you do normally need to limit yourself to putting things somewhere under /home/deck (unless you've made some other power-user changes to your Deck system).

You will need to begin work in whatever directory contains the Project Magma file, i.e. if that file is in /home/deck/Downloads then you should execute this:

.. code-block:: shell

    cd /home/deck/Downloads

Once you have gotten into the correct directory, execute the following commands. You can skip any line that begins with "#"; that's just a comment to tell you what is going on.

.. code-block:: shell

    # Define the directories we're going to use.
    # Change these values if you need to.
    TMPDIR=/tmp/projectmagma
    TAGSDIR=/home/deck/Downloads
    MYTHDIR=/home/deck/Games/Myth2
    # Unpack the installer in our temp directory.
    mkdir -p $TMPDIR
    mv Myth2*Linux.tar.gz $TMPDIR
    cd $TMPDIR
    tar xzf Myth2*Linux.tar.gz
    # Unpack the files needed to run Myth 2, and remove unused stuff.
    cd files
    rm *png
    7z x required.zip.7z
    unzip required.zip
    rm required.zip*
    rm Myth2_32bit
    # Move the installation to the desired location.
    cd ..
    mkdir -p $MYTHDIR
    mv files/* $MYTHDIR/
    # Move the tags files into the installation.
    cd $MYTHDIR
    mkdir tags
    mv $TAGSDIR/'international large install' tags/
    mv $TAGSDIR/'large install' tags/
    mv $TAGSDIR/'medium install' tags/
    mv $TAGSDIR/'international small install' tags/
    mv $TAGSDIR/'small install' tags/
    # Remove our temp directory.
    rm -rf $TMPDIR

At this point, if you want to do a sanity check, you should be able to run the Myth2_64bit executable. Note that if you were logging into the Deck remotely to do the above work, at this point you do need to switch over to the Deck in desktop mode and run a Konsole shell there. "cd" into your Myth 2 game directory if necessary, and then just enter

.. code-block:: shell

    ./Myth2_64bit

Myth 2 should start up and run correctly. Once you get to the main menu, go ahead and quit out of it for now.

Other Addons
------------

To take advantage of community work on Myth 2 you may want to add a few other modifications. `The Tain`_ is one good place to get Myth stuff. FYI my Myth 2 installation always includes:

* `Detail Texture Megapack`_
* `Myth II QuickTime Cutscenes`_

And also, support for playing the entire Myth\:TFL campaign and multiplayer in the Myth 2 engine:

* `The Fallen Levels v2`_
* `Myth TFL Quicktime Cutscenes`_
* `Myth TFL Multiplayer Mappack`_

Installing Myth addons is generally just a matter of extracting files into the right location as per their READMEs. In these cases, the end result will be:

* For the two "Cutscenes" patches: a bunch of ".mov" files that go into a "cutscenes" subdirectory in your Myth 2 installation. Create that subdirectory if needed.
* For the other three downloads: three large files that go into the "plugins" subdirectory.

Adding to Steam
---------------

Once you have your complete working Myth 2 installation in some location on the Deck's filesystem, you can add it to Steam as a shortcut to a non-Steam game. If you're not familiar with that process, here's a quick rundown:

* In desktop mode on the Deck, open Steam and click the "Games" menu on the top of the window.
* Choose "Add a Non-Steam Game to My Library".
* In the resulting dialog, click "Browse", and change the "File type" at the bottom of the file chooser to "All Files".
* Navigate to find and select the "Myth2_64bit" file in your Myth installation.
* Once you have double-clicked on that (or selected it and clicked "Open"), the final step is to click "ADD SELECTED PROGRAMS".

Renaming
--------

Regardless of whether you are already an expert at adding non-Steam games, pay attention to this next step. **You need to use a specific name for this game.** Otherwise the MythDeck configuration won't be available.

If you search around in your Steam games library you should see an entry for "Myth2_64bit". Select that, click on the little "gear" symbol to manage the game, and click on "Properties". In the resulting dialog you must change the name of this shortcut. Instead of "Myth2_64bit" you must use the name "Myth II: Soulblighter". It really does need to be exactly that, with the space after the colon and everything. I had to pick some name to associate the config with, so I decided I might as well use the official one.

At this point you could also add custom library art for the game but that's a topic outside of what I can cover here. Basically, Myth 2 is now installed and ready to configure!

Selecting MythDeck
------------------

Switch your Steam Deck back to gaming mode (where hopefully we can now remain). Find "Myth II: Soulblighter" in your library and select it.

Select the little controller icon to manage your input settings, then go to the top of that page and choose to "Browse Community Layouts". This will take you to a window that shows both "TEMPLATES" and "COMMUNITY LAYOUTS"; move right or hit the right bumper to switch to showing the community layouts. Hopefully you can find and select the MythDeck configuration there!

Among other things, the MythDeck config provides mouse support:

  |rtrack| to move the cursor.

  |r2| or click |rtrack| to do a mouseclick.

You can use that to navigate the game menus during initial configuration.


.. _Project Magma: https://projectmagma.net/downloads/myth2_updates/
.. _The Tain: https://tain.totalcodex.net/
.. _Detail Texture Megapack: https://tain.totalcodex.net/items/show/detail-texture-megapack
.. _Myth II QuickTime Cutscenes: https://tain.totalcodex.net/items/show/myth-ii-quicktime-cutscenes
.. _The Fallen Levels v2: https://tain.totalcodex.net/items/show/the-fallen-levels-v2
.. _Myth TFL Quicktime Cutscenes: https://tain.totalcodex.net/items/show/myth-tfl-quicktime-cutscenes
.. _Myth TFL Multiplayer Mappack: https://tain.totalcodex.net/items/show/myth-tfl-multiplayer-mappack
