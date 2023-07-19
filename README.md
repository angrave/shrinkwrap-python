# shrinkwrap-python

Saint_Helens is a demonstration of creating an installable OSX application using 
* Github actions
* PyInstaller
* dmgbuild

Note the Mac OSX package is not signed by a developer ID, so will modern OSX versions will refuse to run the application after it is installed. 
Here's a workaround that worked for me on an M1 Mac (Ventura 13.4.1). After installing the app into Applications, I removed the quarantine attribute
```sh
xattr -dr com.apple.quarantine /Applications/Saint_Helens.app
````

I had also used OSX Settings to allow applications from identified developers to run, and added this app as an exception.
