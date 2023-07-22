#!/usr/bin/env python3
import sys
import os
import glob 
from pathlib import Path

import PyInstaller.__main__

if sys.platform.startswith('linux'):  # could be 'linux', 'linux2', 'linux3', ...
    platform = 'linux'
elif sys.platform == 'darwin':
    platform = 'osx'
elif os.name == 'nt':
    platform = 'win'

pathsep = os.pathsep
    
def osx_site_package():
    packages = list( glob.glob('./venv/lib/python3.*/site-packages') )
    assert len(packages) == 1, "Expected one site-package in venv. Found {len(packages)}.\n{packages}"
    return packages[0]

def main():
    assert Path("src").is_dir(),'Run this from the repo root'
    
    sitepackages =  './venv/Lib/site-packages' if platform == 'win' else osx_site_package()

    assert Path(sitepackages).is_dir(), f'{sitepackages} does not exist'
    
    # Todo: OSX code signing, [--codesign-identity IDENTITY] [--osx-entitlements-file FILENAME]
    
    # OSX: Don't use '--argv-emulation' with (Tk) UI
    # See Tk Warning here https://pyinstaller.org/en/stable/feature-notes.html#macos-event-forwarding-and-argv-emulation
    # In practice, an app installed into Applications will crash or freeze when first run due to a race condition.
    # It is more likely to crash  when the app was created non-locally
    
    platform_options = {
        'osx': [],
        'win': [],
        'linux': []}
    
    common_options = [
        '--clean', 
        '--windowed',
        '--noconfirm',
        '--paths',sitepackages,
        f'--add-data=./media/{pathsep}media',
        '--icon','./media/Saint_Helens.icns',
        '--name','Saint_Helens'] 

    options = ['src/main.py'] + common_options + platform_options[platform] 
    print(options)

    PyInstaller.__main__.run(options)

    print()
    print('Contents of dist:',  ','.join(os.listdir('dist')) )
    for f in glob.glob('dist/**/*.txt', recursive=True):
        print(f)

if __name__ == "__main__": 
    main()
