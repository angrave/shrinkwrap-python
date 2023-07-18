# pyinstaller uses Pillow to convert png into platform-specific icon format
# argv-emulation is osx specific
pyinstaller \
   --clean \
   --windowed  \
   --noconfirm \
   --argv-emulation \
   --paths ./venv/lib/python3.11/site-packages \
   --icon ./Koko.png \
   --name Koko
   src/main.py

dmgbuild -s package/osxdmgbuild.py "Koko" Koko.dmg
