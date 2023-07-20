import sys
from pathlib import Path
from PIL import Image

if len(sys.argv) != 2,:
  print( f"Exampleusage: python3 {sys.argv[0]} image.png\n  Creates image.ico in the same directory as jpg or png file" )

infile = sys.argv[1]
outfile = infile.with_suffix('.ico')
assert infile != outfile, f"Expected png or jpg file as input, not {infile}"

print( f"{infile} -> {outfile}"
logo = Image.open(infile) 
logo.save(outfile, format='ICO',sizes=[(256, 256)])
