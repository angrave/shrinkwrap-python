# pyinstaller uses Pillow to convert png into platform-specific icon format
# argv-emulation is osx specific
# The pyinstaller line below could be converted into python code 
# (which could also have conditional os-specific options).
# see https://pyinstaller.org/en/stable/usage.html#running-pyinstaller-from-python-code

# Code signing-
# https://pyinstaller.org/en/stable/usage.html
# 

pyinstaller \
   --clean \
   --windowed  \
   --noconfirm \
   --argv-emulation \
   --paths ./venv/lib/python3.11/site-packages \
   --add-data=/src/Saint_Helens.png:.
   --icon ./Saint_Helens.png \
   --name Saint_Helens \
   src/main.py

dmgbuild -s package/osxdmgbuild.py "Saint_Helens" Saint_Helens.dmg
