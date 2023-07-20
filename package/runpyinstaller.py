#!/usr/bin/env python3
import sys
import os
from pathlib import Path

import PyInstaller.__main__

if sys.platform.startswith('linux'):  # could be 'linux', 'linux2', 'linux3', ...
    platform = 'linux'
elif sys.platform == 'darwin':
    platform = 'osx'
elif os.name == 'nt':
    platform = 'win'

pathsep = os.pathsep

def main():
    assert Path("src").is_dir(),'Run this from the repo root'
    
    sitepackages =  './venv/Lib/site-packages' if platform == 'win' else './venv/lib/python3.11/site-packages'

    assert Path(sitepackages).is_dir(), f'{sitepackages} does not exist'
    
    # Todo: OSX code signing, [--codesign-identity IDENTITY] [--osx-entitlements-file FILENAME]
    platform_options = {
        'osx': ['--argv-emulation'],
        'win': [],
        'linux': []}
    
    common_options = [
        '--clean', 
        '--windowed',
        '--noconfirm',
        '--paths',sitepackages,
        f'--add-data=./media/{pathsep}media',
        '--icon','./media/Saint_Helens.png',
        '--name','Saint_Helens'] 

    options = ['src/main.py'] + common_options + platform_options[platform] 
    print(options)

    PyInstaller.__main__.run(options)

    print('Contents of dist:',  ','.join(os.listdir('dist')) )

if __name__ == "__main__": 
    main()