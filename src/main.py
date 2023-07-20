import PySimpleGUI as sg
from pathlib import Path
import os
import another

# Code based on example code from 
# https://www.pysimplegui.org/en/latest/

#In Mac OSX app MacOS, this python file is inside Saint_Helens.app/Contents/MacOS
# Saint_Helens.app/Contents/MacOS/Saint_Helens
thisfile = os.path.realpath( os.path.dirname(__file__) )

if thisfile.endswith("Contents/MacOS"):
    resources = os.path.realpath( thisfile + '/../Resources' )
else:
    resources = os.path.realpath( thisfile + '/..' )
    
mediadir =  os.path.realpath( resources + '/media' )
print(mediadir)

# or os.path.join(basedir, "icons", "one.png")

result = 0
try:
    result = another.sum(1,2)
    with open(mediadir + '/some_text.txt','r') as fh:
       data = fh.readlines()[0]
except:
    data = "No data file"

sg.theme('DarkAmber')   # Add a touch of color
# All the stuff inside your window.
layout = [  [sg.Text('Result:' + str(result))],
    [sg.Text('mediadir:' + mediadir)],
            [sg.Text('__file__ dir:' + thisfile )],
            [sg.Text('Some text on Row 1:' + data)],
            [sg.Text('Enter something on Row 2'), sg.InputText()],
            [sg.Button('Ok'), sg.Button('Cancel')] ]

# Create the Window
window = sg.Window('Window Title', layout)
# Event Loop to process "events" and get the "values" of the inputs
while True:
    event, values = window.read()
    if event == sg.WIN_CLOSED or event == 'Cancel': # if user closes window or clicks cancel
        break
    print('You entered ', values[0])

window.close()
