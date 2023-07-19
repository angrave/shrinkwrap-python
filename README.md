# shrinkwrap-python

Demonstration of creating an installable OSX native app using 
* Github actions
* PyInstaller
* dmgbuild

Note the Mac OSX package is not signed by a developer ID, so will modern OSX versions will refuse to run this. Here's a workaround that worked for me on an M1 Mac (Ventura 13.4.1).

For testing: After installing, remove the quarantine attribute
xattr -dr com.apple.quarantine /Applications/Saint_Helens.app

I also allowed applications not from the App Store to run too, and gave this app an exception.
