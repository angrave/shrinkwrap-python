import PySimpleGUI as sg

import os

# Code based on example code from 
# https://www.pysimplegui.org/en/latest/

basedir = os.path.dirname(__file__)
os.chdir(basedir)
# or os.path.join(basedir, "icons", "one.png")

with open('some_text.txt','r') as fh:
    data = fh.readlines()[0]

sg.theme('DarkAmber')   # Add a touch of color
# All the stuff inside your window.
layout = [  [sg.Text('Some text on Row 1:' + data)],
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
