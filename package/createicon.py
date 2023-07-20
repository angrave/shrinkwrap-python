#!/usr/bin/env python3
import sys
from pathlib import Path
from PIL import Image

if len(sys.argv) != 2:
  print( f"Exampleusage: python3 {sys.argv[0]} image.png\n  Creates image.ico in the same directory as jpg or png file" )
  sys.exit(1)

infile = Path( sys.argv[1] )
outfile = infile.with_suffix('.ico')
assert infile.is_file(), f"Expected {infile} is not a file"
assert infile != outfile, f"Expected png or jpg file as input, not {infile}"

print( f"Saving {infile} as {outfile}" )

logo = Image.open(infile)

#Save as Windows Application Icon
logo.save(outfile, format='ICO',sizes=[(256, 256)])

print("Finished")
