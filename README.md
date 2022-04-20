# weatherdesk
A simple script for creating a desktop picture from a near-live satellite image

![EUMETSAT raw image](https://github.com/stml/weatherdesk/blob/main/source_aegean.png)

## Description

These are two example bash scripts for downloading the latest [EUMETSAT Natural Colour Enhanced RGB - MSG - 0 degree](https://data.eumetsat.int/product-navigator/product/EO:EUM:DAT:MSG:NCL_ENH) data - an image of Europe, Africa, and parts of Asia, updated by [Meteosat](https://en.wikipedia.org/wiki/Meteosat) every fifteen minutes - cropping it to an area, and setting it as a desktop image (on Linux systems).

**N.B.** The image will be black during local night time! At dawn and dusk, you will see the [terminator](https://en.wikipedia.org/wiki/Terminator_(solar)), as the sun's light arrives and then leaves the hemisphere.

The above image shows a raw EUMETSAT image, with the cropped area shaded. The images at the end of this file show examples of cropped areas.

## How it works

There are currently two example files, one which crops to the whole Mediterranean region (weatherdesk-2.0-mediterranean.sh) and one which crops (and enlarges) the Eastern Mediterranean, centred on Greece and the Aegean sea (weatherdesk-2.0-aegean.sh). The former works as follows:

`#!/bin/bash`

This line opens the script, and tells the computer that this is a [bash script](https://en.wikipedia.org/wiki/Bash_(Unix_shell)).

`wget -O source.png 'https://view.eumetsat.int/geoserver/ows?service=WMS&request=GetMap&version=1.3.0&layers=msg_fes:rgb_naturalenhncd&styles=&format=image/jpeg&crs=EPSG:4326&bbox=-77,-77,77,77&width=4000&height=4000'`

This line downloads the latest EUMETSAT image at 4000x4000 pixel resolution, and saves it to a file named `source.png`

`convert source.png -crop 1276x768+1736+624 cropped_source.png`

This line crops the source to a 1276x768 pixel image called `cropped_source.png`, offset 1736 pixels to the right, and 624 pixels down, which is the area of the image which includes the Mediterranean. Editing this line will change the area which is cropped. You also need to edit the cropping size if your desktop is a different size.

`dconf write "/org/gnome/desktop/background/picture-uri" "'file:///[PATH_TO_FILE]/cropped_source.png'"`

This line sets `cropped_source.png` to be the desktop image. The path needs to match the location of the file on your computer, and it needs to be the full path to work properly if the script is run automatically by a cron job (see below), e.g. something like: `/home/stml/Documents/weatherdesk/cropped_source.png`

`exit 0`

This line exits the file and closes the program.

In the second example, `weatherdesk-2.0-aegean.sh`, a smaller area is cropped with the line:

`convert source.png -crop 638x384+2290+842 cropped_source.png`

(This crops an area 638 pixels wide and 384 pixels high, offset 2290 pixels right and 842 pixels down)

`convert -size 1276x768 cropped_source.png -magnify -unsharp 0x1 cropped_source.png`

This line then enlarges the smaller cropped image to the full size, saving it with the same name.

## Running automatically

The file can be set to run automatically, and update the desktop with a more recent image, as often as you like. To do this on Linux, run `sudo crontab -e` in the terminal and add the following line to the cron file (a list of commands that is run automatically in the background):

0,30 * * * * cd [PATH_TO_DIRECTORY]/weatherdesk && ./weatherdesk.sh

The PATH_TO_DIRECTORY needs to be the full path to the folder containing the script, e.g. something like: `/home/stml/Documents/weatherdesk`

## Further work

It would be great to have versions of the script for different operating systems, if anyone wants to fork this repo...

## Inspiration

**weatherdesk** was inspired by [Satellite Eyes](https://satelliteeyes.tomtaylor.co.uk), a Mac app by Tom Taylor, and by the amazing work of remote sensing satellites and those who make them possible.

This is the script mentioned in James Bridle (@stml)'s book [Ways of Being](http://jamesbridle.com/books/ways-of-being), in the chapter *Seeing like a Planet*.

## Example Desktop Images

![Mediterranean cropped image](https://github.com/stml/weatherdesk/blob/main/cropped_source_mediterranean.png)
![Aegean cropped image](https://github.com/stml/weatherdesk/blob/main/cropped_source_aegean.png)
