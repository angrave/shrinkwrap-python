# shrinkwrap-python

If you find this project useful please acknowledge or cite it! e.g. "L Angrave's Shrinkwrap-python project (https://github.com/angrave/shrinkwrap-python)" 

This repo creates a hello world app - Saint_Helens - as a proof of concept demonstratation of creating a cross platform installable Mac package and Windows installer using github actions. The main packaging tools used are  

* [Github actions](https://docs.github.com/en/actions)
* [PyInstaller](https://pypi.org/project/pyinstaller/)
* [dmgbuild](https://github.com/dmgbuild/dmgbuild) (for OSX)
* [NSIS](https://sourceforge.net/projects/nsis/) (to create a windows installer)

Python's [Pillow](https://pypi.org/project/Pillow/) library is used to convert an app image into ico and icn image formats. Virtual environemt module `venv` is used to isolate libraries used by the application and libraries used by the packaging scripts.

## Interesting stuff -

* The build script is [shrinkwrap.yml](https://github.com/angrave/shrinkwrap-python/blob/main/.github/workflows/shrinkwrap.yml).
* The application code is in [main.py](https://github.com/angrave/shrinkwrap-python/blob/main/src/main.py). The app uses python package PySimpleGUI (which uses TK) to display a simple GUI window. See the source code to find out how to reference media items in a cross-platform manner.
* There is also an equivalent build shell script for developer testing on OSX [osx-local.sh](https://github.com/angrave/shrinkwrap-python/blob/main/package/osx-local.sh)
* The App source code is in `src/` directory but all of the packaging stuff is in `package/` directory.
* To build a release, fork this project, then click on Actions menu item, select "Shrinkwrap" action and "Run workflow" Enter a n.n.n version number e.g. "0.0.1"
* For sufficient clicking through github's interface you can watch the output of the github actions as they complete (it will take several minutes). If it completes successfully then a new "Release" are will appear in your github repo home on the right hand side.

## Limitations

Neither OSX nor Windows packags are signed with a developer ID.

Modern OSX platforms will refuse to run the application when it is created on GitHub after it is installed. 
Here's a workaround that worked for me on an M1 Mac (Ventura 13.4.1). After installing the app into Applications, I removed the quarantine attribute
```sh
xattr -dr com.apple.quarantine /Applications/Saint_Helens.app
````

I had also used OSX Settings to allow applications from identified developers to run, and added this app as an exception.

Similarly Windows will not run unsigned external applications by default, but with some right clicking in the right places it is still possible to run the installer.

## License

The build files are provided under the MIT open source license. However you are free to relicense these under any open-source license approved by the [OSI](https://opensource.org/licenses/).

The example license displayed in the installer and bundled with the application is [media/License.txt](https://github.com/angrave/shrinkwrap-python/blob/main/media/License.txt)

## Limitations

There is no Linux script.
