#!/bin/bash
# Local build; should be close to the github action version

# Todo check we are being called from the root of the repo

set -e

quit() {
  echo "$*"
  exit 1
}

alias python=python3

python() { 
  python3 $* 
}

assertpython() {
   python --version 
  python --version | grep $1 || quit "Expected python 3.11"
}
assertreporoot() {
  [ -d '.git' ] || quit "Current directory shoule be root of the repo"
}


assertreporoot

assertpython 3.11

if [[ FILE1 -nt FILE2 ]]; then
  echo FILE1 is newer than FILE2
fi

if [[ ! -d 'package/venv' ]]; then
  python -m venv package/venv
  source package/venv/bin/activate
  python -m pip install --upgrade pip

  python -m pip install --upgrade setuptools
  pip install -r package/requirements.txt
fi

if [[ ! -d 'venv' ]]; then
  python -m venv venv
  source venv/bin/activate
  python -m pip install --upgrade pip
  pip install -r requirements.txt
fi

source package/venv/bin/activate
python package/runpyinstaller.py

python -m dmgbuild -s package/osxdmgbuild.py "Saint_Helens" Saint_Helens.dmg