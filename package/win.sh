# Bash script

mkdir dist
# echo hello > dist/Saint_Helens/Saint_Helens_install.exe

# pyinstaller uses Pillow to convert png into platform-specific icon format
# argv-emulation is osx specific
pyinstaller \
   --clean \
   --windowed  \
   --noconfirm \ 
   --paths ./venv/lib/python3.11/site-packages \
   --icon ./Saint_Helens.png \
   --name Saint_Helens \
   src/main.py

ls -R dist/


