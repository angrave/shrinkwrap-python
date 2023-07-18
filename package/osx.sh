# pyinstaller uses Pillow to convert png into platform-specific icon format
# argv-emulation is osx specific
pyinstaller \
   --clean \
   --windowed  \
   --noconfirm \
   --argv-emulation \
   --paths ./venv/lib/python3.11/site-packages \
   --icon ./Saint_Helens.png \
   --name Saint_Helens \
   src/main.py

dmgbuild -s package/osxdmgbuild.py "Saint_Helens" Saint_Helens.dmg
