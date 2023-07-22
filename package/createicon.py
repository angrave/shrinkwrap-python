#!/usr/bin/env python3
import sys
from pathlib import Path
from PIL import Image

formats =  ['ico','icns','bmp']

if len(sys.argv) != 2:
  print( f"Exampleusage: python3 {sys.argv[0]} image.png\n  Creates {','.join(formats)} image formats in the same directory as jpg or png file" )
  sys.exit(1)


infile = Path( sys.argv[1] )

assert infile.is_file(), f"Expected {infile} is not a file"


logo = Image.open(infile)

for form in formats:
    
    outfile = infile.with_suffix(f'.{form}')
    if outfile == infile:
        continue

    print( f"Saving {infile} as {outfile}" )

    logo.save(outfile)

print("Finished")
