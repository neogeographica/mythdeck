#!/usr/bin/env bash

# Myth 2 installer script for Steam Deck (or most Linuxes, really).

# ----------------------------------------------------------------------------

# MIT License

# Copyright (c) 2022 Joel Baxter

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

# ----------------------------------------------------------------------------

# This script makes use of the Project Magma patch for Myth 2. By default it
# will download the 1.8.4 Linux patch from the Project Magma website. If you
# want to change that behavior, there are two ways in which you can specify
# the local filepath or URL of the Project Magma patch to use:
#   * You can specify it as a command-line argument to this script.
#   * You can export it as a value for PM_MYTH2_INSTALLER before running this
#     script.

# This script must have access to the five "tags" files for Myth 2. They are
# assumed to be in the working directory. If you want to change that behavior,
# you can export a value for MYTH2_TAGSDIR before running this script, to
# specify the directory that contains all the tags files.


# Myth 2 will be installed in ~/Games/Myth2 by default. If you want to change
# that behavior, you can export a value for MYTH2_INSTALLDIR before running
# this script, to specify the directory where Myth 2 will be installed.

# ----------------------------------------------------------------------------

# And away we go...

# Keep track of whether the installer is a local file.
PM_MYTH2_INSTALLER_PATH=

# Define the directories we're going to use.
MYTH2_TMPDIR="/tmp/myth2-installer-$$"
: ${MYTH2_TAGSDIR:=$(pwd)}
: ${MYTH2_INSTALLDIR:=~/Games/Myth2}

# Define the location of the Project Magma installer.
if [[ "$1" != "" ]]
then
  PM_MYTH2_INSTALLER="$1"
fi
: ${PM_MYTH2_INSTALLER:=https://projectmagma.net/downloads/myth2_updates/1.8.4%20Final%20(Build%20462)/Myth2_184_Linux.tar.gz}

# Make sure the tags files are there.
function tagstest {
  if [[ ! -f "$MYTH2_TAGSDIR/$1" ]]
  then
    echo
    echo Tags file \"$1\" does not exist in: $MYTH2_TAGSDIR
    echo
    echo You must have these five Myth 2 \"tags\" files:
    echo "  international large install"
    echo "  large install"
    echo "  medium install"
    echo "  international small install"
    echo "  small install"
    echo
    echo Normally this script will look for them in the current directory.
    echo Or you can export a value for MYTH2_TAGSDIR to locate them.
    echo
    exit 1
  fi
}
tagstest "international large install"
tagstest "large install"
tagstest "medium install"
tagstest "international small install"
tagstest "small install"

# Put the file:// protocol on the installer if needed.
# Also if local file, check for file existence and remember its path.
if [[ "$PM_MYTH2_INSTALLER" != http://* ]] && [[ "$PM_MYTH2_INSTALLER" != https://* ]]
then
  if [[ "$PM_MYTH2_INSTALLER" == file://* ]]
  then
    PM_MYTH2_INSTALLER_PATH="${PM_MYTH2_INSTALLER/#file:\/\/}"
  else
    PM_MYTH2_INSTALLER_PATH=$(readlink -f "$PM_MYTH2_INSTALLER")
    PM_MYTH2_INSTALLER="file://$PM_MYTH2_INSTALLER_PATH"
  fi
  if [[ ! -f "$PM_MYTH2_INSTALLER_PATH" ]]
  then
    echo
    echo \"$PM_MYTH2_INSTALLER_PATH\" does not exist!
    echo
    exit 1
  fi
fi

# Bail out if MYTH2_INSTALLDIR exists.
if [[ -e "$MYTH2_INSTALLDIR" ]]
then
  echo Install directory already exists at: $MYTH2_INSTALLDIR
  echo
  echo To specify a different directory, export a value for MYTH2_INSTALLDIR.
  echo
  exit 1
fi

# Arguments seem OK; let's roll.
echo
echo == Installing Myth 2 ==

# Set up some cleanup.
set -e
SUCCESS=false
function cleanup {
  echo
  rm -rf "$MYTH2_TMPDIR"
  if [[ $SUCCESS == false ]]
  then
    echo "Install failed. :-("
    rm -rf "$MYTH2_INSTALLDIR"
  else
    echo "Myth 2 is installed in: $MYTH2_INSTALLDIR"
    if [[ "$PM_MYTH2_INSTALLER_PATH" != "" ]]
    then
      echo
      echo We could now delete this installer file: $PM_MYTH2_INSTALLER_PATH
      read -p "Delete it (y/n)? " -n 1 -r
      echo
      if [[ $REPLY =~ ^[Yy]$ ]]
      then
        rm -f "$PM_MYTH2_INSTALLER_PATH"
      fi
    fi
    echo
    echo The tags files originally were here: $MYTH2_TAGSDIR
    echo They have now been copied to the Myth 2 game directory.
    read -p "Delete the original tags file copies (y/n)? " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
      rm -f "$MYTH2_TAGSDIR/international large install"
      rm -f "$MYTH2_TAGSDIR/large install"
      rm -f "$MYTH2_TAGSDIR/medium install"
      rm -f "$MYTH2_TAGSDIR/international small install"
      rm -f "$MYTH2_TAGSDIR/small install"
    fi
    echo
    echo All done!
    echo
    echo Please see the MythDeck documentation for configuration info.
  fi
  echo
}
trap cleanup EXIT

# Unpack the installer in our temp directory.
echo
echo Copying/downloading installer...
mkdir -p "$MYTH2_TMPDIR"
cd "$MYTH2_TMPDIR"
curl --progress-bar -o installer.tar.gz "$PM_MYTH2_INSTALLER"
echo
echo Unpacking installer...
tar xzf installer.tar.gz

# Unpack the files needed to run Myth 2, and remove unused stuff.
echo
echo Extracting Myth 2 engine...
cd files
rm *png
7z x required.zip.7z > /dev/null
unzip -qq required.zip
rm required.zip*
rm Myth2_32bit

# Move the installation to the desired location.
echo
echo Moving Myth 2 engine to installation directory...
cd ..
mkdir -p "$MYTH2_INSTALLDIR"
mv files/* "$MYTH2_INSTALLDIR/"

# Move the tags files into the installation.
echo
echo Copying Myth 2 gamedata to installation directory...
cd "$MYTH2_INSTALLDIR"
mkdir tags
cp "$MYTH2_TAGSDIR/international large install" tags/
cp "$MYTH2_TAGSDIR/large install" tags/
cp "$MYTH2_TAGSDIR/medium install" tags/
cp "$MYTH2_TAGSDIR/international small install" tags/
cp "$MYTH2_TAGSDIR/small install" tags/

# All done!
SUCCESS=true