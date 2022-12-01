<#

.SYNOPSIS
Gets a count of the days remaining until Christmas.

.DESCRIPTION
Returns the days remaining until Christmas as ASCII art.

Right-click this script and select the "Run with PowerShell" menu item.

Please consider giving to cancer research this holiday season.

.PARAMETER from
Specifies a particular from-date to use for the calculation.
The count reflects the number of days until Christmas for that same year.

.PARAMETER indent
Specifies the number of characters to indent.

.PARAMETER days
Forces a display value for the number of days remaining.

.PARAMETER noclear
Specifies NOT to clear the screen during initialization.
Clearing is enabled by default for "Run with PowerShell" compatibility.

.PARAMETER nowait
Specifies NOT to wait for the ENTER keypress.
Waiting is enabled by default for "Run with PowerShell" compatibility.

.PARAMETER debug
Debugging displays the character indexes and color assignments.

.INPUTS
None.

.OUTPUTS
A colorful holiday display in the console window.

.EXAMPLE
.\Get-DaysUntilChristmas.ps1
Starts the program with the default options.

.EXAMPLE
.\Get-DaysUntilChristmas.ps1 -from (Get-Date -Year 1969 -Month 7 -Day 16)
Starts the program with a specific from-date.

.EXAMPLE
.\Get-DaysUntilChristmas.ps1 -indent 16
Starts the program with a specific left-hand indentation value.

.EXAMPLE
.\Get-DaysUntilChristmas.ps1 -days 123
Starts the program with a specific number of days to display.

.EXAMPLE
.\Get-DaysUntilChristmas.ps1 -noclear
Starts the program without clearing the screen.

.EXAMPLE
.\Get-DaysUntilChristmas.ps1 -nowait
Ends the program without waiting for the ENTER keypress.

.EXAMPLE
.\Get-DaysUntilChristmas.ps1 -debug
Shows the character indexes and color assignments.

.NOTES
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
01.00 2022-Nov-25 Scott S. Initial release.
01.01 2022-Nov-28 Scott S. Added a missing color index and a no-wait option.
01.02 2022-Nov-29 Scott S. Added a from-date option.
01.03 2022-Nov-30 Scott S. Added a no-clear option.

.LINK
https://en.wikipedia.org/wiki/ASCII_art

.LINK
https://braintumor.org/

.LINK
https://www.cancer.org/

#>

# define the default options
param
(
    [DateTime]$from = (Get-Date)
  , [int]$indent    = 4
  , [int]$days      = (-1)
  , [switch]$noclear
  , [switch]$nowait
  , [switch]$debug
)

# define the ascii artwork
$ascii = @"

          _/^\_
         <     >
          /.^.\
          '/"\'
         (  o  )
        ./'"'"'\.
       ( o  o  o )
      ./"'"'"'"'"\.
     ( o  o   o  o )
    ./'"'"'"'"'"'"'\.
   ( O  O   O   O  O )
  /"'"'"'"'"'"'"'"'"'"\
 // O   O   O   O   O \\
 '"="=="==,...,=="=="="'
    ..--..]###[..--..    (\|)
          '"""'           \'_
                       ,--' ')
     HAPPY HOLIDAYS  O( )_ -\
                       '"""' "'

"@;

# define a set of digits with identical heights and widths
# (uses a modified roman figlet font)
$digits = @"
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
 dP"""""""
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
d"""""""8'
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
"@;

# define the structure of the digits data
$height = 7;
$width  = 11;
$lines  = $digits.Split("`n");
$label  = "-- Days to Wait Until Christmas --";

# define a default color and all index replacement colors
$default = [System.ConsoleColor]::Green;
$colors  = @{

  # tree (star)
  12  = [System.ConsoleColor]::Yellow
  13  = [System.ConsoleColor]::Yellow
  14  = [System.ConsoleColor]::Yellow
  15  = [System.ConsoleColor]::Yellow
  16  = [System.ConsoleColor]::Yellow

  28  = [System.ConsoleColor]::Yellow
  29  = [System.ConsoleColor]::Yellow
  30  = [System.ConsoleColor]::Yellow
  31  = [System.ConsoleColor]::Yellow
  32  = [System.ConsoleColor]::Yellow
  33  = [System.ConsoleColor]::Yellow
  34  = [System.ConsoleColor]::Yellow

  47  = [System.ConsoleColor]::Yellow
  48  = [System.ConsoleColor]::Yellow
  49  = [System.ConsoleColor]::Yellow
  50  = [System.ConsoleColor]::Yellow
  51  = [System.ConsoleColor]::Yellow

  64  = [System.ConsoleColor]::Yellow
  68  = [System.ConsoleColor]::Yellow

  # tree (ornaments)
  83  = [System.ConsoleColor]::Red

  117 = [System.ConsoleColor]::Red
  120 = [System.ConsoleColor]::Cyan
  123 = [System.ConsoleColor]::Red

  156 = [System.ConsoleColor]::Cyan
  159 = [System.ConsoleColor]::Red
  163 = [System.ConsoleColor]::Red
  166 = [System.ConsoleColor]::Cyan

  199 = [System.ConsoleColor]::Red
  202 = [System.ConsoleColor]::Cyan
  206 = [System.ConsoleColor]::Red
  210 = [System.ConsoleColor]::Cyan
  213 = [System.ConsoleColor]::Red

  247 = [System.ConsoleColor]::Cyan
  251 = [System.ConsoleColor]::Red
  255 = [System.ConsoleColor]::Cyan
  259 = [System.ConsoleColor]::Red
  263 = [System.ConsoleColor]::Cyan

  # tree (base)
  299 = [System.ConsoleColor]::White
  300 = [System.ConsoleColor]::White
  301 = [System.ConsoleColor]::White
  302 = [System.ConsoleColor]::White
  303 = [System.ConsoleColor]::White
  304 = [System.ConsoleColor]::White

  305 = [System.ConsoleColor]::DarkGray
  306 = [System.ConsoleColor]::DarkGray
  307 = [System.ConsoleColor]::DarkGray
  308 = [System.ConsoleColor]::DarkGray
  309 = [System.ConsoleColor]::DarkGray

  310 = [System.ConsoleColor]::White
  311 = [System.ConsoleColor]::White
  312 = [System.ConsoleColor]::White
  313 = [System.ConsoleColor]::White
  314 = [System.ConsoleColor]::White
  315 = [System.ConsoleColor]::White

  336 = [System.ConsoleColor]::White
  337 = [System.ConsoleColor]::White
  338 = [System.ConsoleColor]::White
  339 = [System.ConsoleColor]::White
  340 = [System.ConsoleColor]::White

  # text label
  394 = [System.ConsoleColor]::Red
  396 = [System.ConsoleColor]::Red
  398 = [System.ConsoleColor]::Red
  401 = [System.ConsoleColor]::Red
  403 = [System.ConsoleColor]::Red
  405 = [System.ConsoleColor]::Red
  407 = [System.ConsoleColor]::Red

  # fluffy bunny
  320 = [System.ConsoleColor]::White
  321 = [System.ConsoleColor]::White
  322 = [System.ConsoleColor]::White
  323 = [System.ConsoleColor]::White

  352 = [System.ConsoleColor]::White
  353 = [System.ConsoleColor]::White
  354 = [System.ConsoleColor]::White

  380 = [System.ConsoleColor]::White
  381 = [System.ConsoleColor]::White
  382 = [System.ConsoleColor]::White
  383 = [System.ConsoleColor]::White
  384 = [System.ConsoleColor]::White
  385 = [System.ConsoleColor]::White
  386 = [System.ConsoleColor]::White

  410 = [System.ConsoleColor]::White
  411 = [System.ConsoleColor]::White
  412 = [System.ConsoleColor]::White
  413 = [System.ConsoleColor]::White
  414 = [System.ConsoleColor]::White
  415 = [System.ConsoleColor]::White
  416 = [System.ConsoleColor]::White
  417 = [System.ConsoleColor]::White

  443 = [System.ConsoleColor]::White
  444 = [System.ConsoleColor]::White
  445 = [System.ConsoleColor]::White
  446 = [System.ConsoleColor]::White
  447 = [System.ConsoleColor]::White
  448 = [System.ConsoleColor]::White
  449 = [System.ConsoleColor]::White
  450 = [System.ConsoleColor]::White

}

# clear the console (optional)
if (-not $noclear.IsPresent)
{
  Clear-Host;
}

# loop through each of the ascii art characters
for ($idx = 0; $idx -lt $ascii.Length; $idx++)
{

  # use the default color unless a replacement color is defined
  $color = $default;
  if ($colors[$idx] -ne $null)
  {
    $color = $colors[$idx];
  }

  # write the current ascii art character in color to the host
  Write-Host -Object $ascii[$idx] `
             -ForegroundColor $color `
             -NoNewline;

  # indent after each end-of-line character is detected
  if ((-not $debug.IsPresent) -and ($ascii[$idx] -eq "`n"))
  {
    Write-Host -Object (" " * $indent) `
               -NoNewline;
  }

  # use debug to show the ascii art character indexes
  if ($debug.IsPresent)
  {
    Write-Host -Object " : $idx : $($color.ToString())" `
               -ForegroundColor $color;
  }

}
Write-Host;

# calculate the days remaining value
if ($days -lt 0)
{
  $target = (Get-Date -Year $from.Year `
                      -Month 12 `
                      -Day 25);
  $days   = (New-TimeSpan -Start $from.Date `
                          -End $target.Date).Days;
}

# sanity check (date has already passed for the current year)
if ($days -lt 0)
{
  $days = 0;
}

# display the days remaining value as large digits
$chars = $days.ToString().PadLeft(3, '0').ToCharArray();
$d0 = [int]($chars[0].ToString()); # first digit
$d1 = [int]($chars[1].ToString()); # second digit
$d2 = [int]($chars[2].ToString()); # third digit
for ($idx = 0; $idx -lt $height; $idx++)
{
  $s0 = $lines[($d0 * $height) + $idx].Replace("`r", "");
  $s1 = $lines[($d1 * $height) + $idx].Replace("`r", "");
  $s2 = $lines[($d2 * $height) + $idx].Replace("`r", "");
  Write-Host -Object (" " * $indent) `
             -NoNewline;
  Write-Host -Object $s0.PadRight($width, " ") `
             -ForegroundColor Green `
             -NoNewline;
  Write-Host -Object $s1.PadRight($width, " ") `
             -ForegroundColor Red `
             -NoNewline;
  Write-Host -Object $s2.PadRight($width, " ") `
             -ForegroundColor Green;
}
Write-Host;

# display the days remaining label with alternating colors
$chars = $label.ToCharArray();
Write-Host -Object (" " * $indent) `
           -NoNewline;
for ($idx = 0; $idx -lt $chars.Length; $idx++)
{
  $color = [System.ConsoleColor]::Red;
  if (($idx % 2) -ne 0) # modulus determines odd or even
  {
    $color = [System.ConsoleColor]::Green;
  }
  Write-Host -Object $chars[$idx] `
             -ForegroundColor $color `
             -NoNewline;
}
Write-Host -Object "`n";

# wait for the enter keypress before exiting (optional)
if (-not $nowait.IsPresent)
{
  Write-Host -Object (" " * $indent) `
             -NoNewline;
  Read-Host "Press the ENTER key to continue";
}
