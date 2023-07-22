#!/bin/bash
# Local build; should be close to the github action version

# Todo check we are being called from the root of the repo

set -e

quit() {
  echo "$*"
  exit 1
}

python() { 
  python3 $* 
}

assertpython() {
  python --version | grep $1 || quit "Expected python $1"
}
assertreporoot() {
  [ -d '.git' ] || quit "Current directory shoule be root of the repo"
}

installrequirements() {
  reqfile="$1"
  subdir="$2"
  extras="$3"
  if [[ ! -d "$subdir" || "$reqfile" -nt "${subdir}/.uptodate" ]] ; then
    echo Adding requirements $reqfile to $subdir
    rm -rf "$subdir"
    python -m venv "${subdir}"
    source "${subdir}/bin/activate"
    for pkg in $extras ; do
      echo Upgrading $pkg
      python -m pip install --upgrade $pkg
    done
    pip install -r "$reqfile"
    touch "${subdir}/.uptodate"
  fi
}

assertreporoot

assertpython 3.11

# Fresh install of all packages needed to build the installer
# This is a no-op if package/requirements.txt has not been changed
installrequirements "package/requirements.txt" "package/venv" "pip setuptools"

# Fresh install of all packages needed to build the application
# This is a no-op if package/requirements.txt has not been changed
installrequirements "./requirements.txt" "./venv" "pip"

# Build the application (dist/Saint_Helens.app)
source package/venv/bin/activate
python package/runpyinstaller.py


# You could test the application-
# open package/Saint_Helens.app


# Build the disk image and open it.
python -m dmgbuild -s package/osxdmgbuild.py "Saint_Helens" Saint_Helens.dmg
open Saint_Helens.dmg
