#!/usr/bin/env python3
"""A module of Christmas utilities.

Please consider giving to cancer research this holiday season.

To start the module from the REPL, import using:
    >>> from christmas import get_days
    >>> help(get_days)
    >>> get_days()
    >>> get_days("1900-01-31")
    >>> get_days("1900-01-31", 16)

MIT License

Copyright (c) 2022 TigerPointe Software, LLC

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

If you enjoy this software, please do something kind for free.

History:
01.00 2022-Dec-16 Scott S. Initial release.

Links:
https://en.wikipedia.org/wiki/ASCII_art
https://braintumor.org/
https://www.cancer.org/
"""

from datetime import date, datetime, timedelta

# Define the ascii artwork
# (escapes backslashes and double-quotes)
ascii = """
          _/^\\_
         <     >
          /.^.\\
          '/\"\\'
         (  o  )
        ./'\"'\"'\\.
       ( o  o  o )
      ./\"'\"'\"'\"'\"\\.
     ( o  o   o  o )
    ./'\"'\"'\"'\"'\"'\"'\\.
   ( O  O   O   O  O )
  /\"'\"'\"'\"'\"'\"'\"'\"'\"'\"\\
 // O   O   O   O   O \\\\
 '\"=\"==\"==,...,==\"==\"=\"'
    ..--..]###[..--..    (\\|)
          '\"\"\"'           \\'_
                       ,--' ')
     HAPPY HOLIDAYS  O( )_ -\\
                       '\"\"\"' \"'
"""
# Define a set of digits with identical heights and widths
# (uses a modified roman figlet font)
digits = """
  .oooo.
 d8P 'Y8b.
888    888
888    888
888    888
'88b  d88
 'Y8bd8P'
     .o
   o888
    888
    888
    888
    888
   o888o
  .oooo.
.dP""Y88b
      ]8P'
    .d8P'
  .dP'
.oP     .o
8888888888
  .oooo.
.dP""Y88b
      ]8P'
    {88b.
     '88b.
o.   .88P
'8bd88P'
      .o
    .d88
  .d'888
.d'  888
88ooo888oo
     888
    o888o
  oooooooo
 dP'''''''
d88888b.
    'Y88b
      ]88
o.   .88P
'8bd88P'
    .ooo
  .88'
 d88'
d888P"Ybo.
Y88[   ]88
'Y88   88P
 '88bod8'
 ooooooooo
d'''''''8'
      .8'
     .8'
    .8'
   .8'
  .8'
 .ooooo.
d88'   '8.
Y88..  .8'
 '88888b.
.8'  ''88b
'8.   .88P
 'boood8'
 .ooooo.
888' 'Y88.
888    888
 'Vbood888
      888'
    .88P'
  .oP
"""


def get_days(start=None, indent=4):
    """Gets a count of the days remaining until Christmas.
    Returns the days remaining until Christmas as ASCII art.
    Parameters
    start  : str
            Specifies the calculation starting date ("1900-01-31")
            The count reflects Christmas for that same year
    indent : int
            Specifies the number of characters to indent
    """
    
    # Define the input date format
    input_date = "%Y-%m-%d" # 1900-01-31
    
    # Sanity check (start date)
    try:
        if start == None:
            start_date = date.today()
        else:
            start_date = (datetime.strptime(start, input_date)).date()
    except:
        start_date = date.today()
    
    # Calculate the padding indentation
    pad = " " * indent

    # Print the ASCII art (indents each line)
    lines = ascii.splitlines()
    for line in lines:
        print(pad + line)

    # Define the structure of the digits data
    height = 7
    width = 11
    lines = digits.splitlines()
    label = "-- Days to Wait Until Christmas --"

    # Calculate the days remaining value
    target_date = (datetime(start_date.year, 12, 25)).date()
    days = (target_date - start_date).days

    # Sanity check (date has already passed for the current year)
    if days < 0:
        days = 0

    # Display the days remaining value as large digits
    chars = list(str(days).zfill(3))
    d0 = int(chars[0]) # first digit
    d1 = int(chars[1]) # second digit
    d2 = int(chars[2]) # third digit
    for idx in range(height):
        s0 = lines[(d0 * height) + idx + 1]
        s1 = lines[(d1 * height) + idx + 1]
        s2 = lines[(d2 * height) + idx + 1]
        print(pad + s0.ljust(width) + s1.ljust(width) + s2.ljust(width))

    # Print the days remaining label
    print()
    print(pad + label)


# Start the module interactively (double-clicking the .py file)
if __name__ == "__main__":
    indent = 4
    get_days(indent=indent)
    print()
    input((" " * indent) + "Press the ENTER key to continue ...")
