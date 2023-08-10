# shrinkwrap-python

If you find this project useful please acknowledge or cite it! e.g. "L Angrave's Shrinkwrap-python project (https://github.com/angrave/shrinkwrap-python)" 

This repo creates a hello world app - Saint_Helens - as a proof of concept demonstratation of creating a cross platform installable Mac package and Windows installer using github actions. The main packagin tools used are  

* Github actions
* PyInstaller
* dmgbuild (for OSX)
* NSIS (to create a windows installer)


## Interesting stuff -

* The build script is [shrinkwrap.yml](https://github.com/angrave/shrinkwrap-python/blob/main/.github/workflows/shrinkwrap.yml).
* The application code is in [main.py](https://github.com/angrave/shrinkwrap-python/blob/main/src/main.py). The app uses python package PySimpleGUI (which uses TK) to display a simple GUI window.
* There is also an equivalent build shell script for developer testing on OSX [osx-local.sh](https://github.com/angrave/shrinkwrap-python/blob/main/package/osx-local.sh)

## Limitations

Neither OSX nor Windows packags are signed with a developer ID.

Modern OSX versions will refuse to run the application after it is installed. 
Here's a workaround that worked for me on an M1 Mac (Ventura 13.4.1). After installing the app into Applications, I removed the quarantine attribute
```sh
xattr -dr com.apple.quarantine /Applications/Saint_Helens.app
````

I had also used OSX Settings to allow applications from identified developers to run, and added this app as an exception.

