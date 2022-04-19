# weatherdesk
A simple script for creating a desktop picture from a near-live satellite image

## Description

These are two example bash scripts for downloading the latest [EUMETSAT Natural Colour Enhanced RGB - MSG - 0 degree](https://data.eumetsat.int/product-navigator/product/EO:EUM:DAT:MSG:NCL_ENH) data - an image of Europe and Africa, updated by [Meteosat] every fifteen minutes - cropping it to an area, and setting it as a desktop image (on Linux systems).

## How it works

There are currently two example files, one which crops to the whole Mediterranean region (weatherdesk-2.0-mediterranean.sh) and one which crops (and enlarges) the Eastern Mediterranean, centred on Greece and the Aegean sea (weatherdesk-2.0-aegean.sh). The former works as follows:

`#!/bin/bash`
This line opens the script, and tells the computer that this is a [bash script](https://en.wikipedia.org/wiki/Bash_(Unix_shell)).
`wget -O source.png 'https://view.eumetsat.int/geoserver/ows?service=WMS&request=GetMap&version=1.3.0&layers=msg_fes:rgb_naturalenhncd&styles=&format=image/jpeg&crs=EPSG:4326&bbox=-77,-77,77,77&width=4000&height=4000'`
This line 
convert source.png -crop 1276x768+1736+624 cropped_source.png
#convert cropped_source.png -set colorspace Gray -separate -average cropped_source.png
# convert cropped_source.png -resize 1276x768  cropped_source.png
# convert cropped_source.png -filter Gaussian -resize 1276x768 cropped_source.png
#convert -size 1276x768 cropped_source.png -magnify -unsharp 0x1 cropped_source.png
#composite -gravity center cropped_source.png black.jpg satellite.jpg
dconf write "/org/gnome/desktop/background/picture-uri" "'file:///home/james/Dropbox/Code/weatherdesk/cropped_source.png'"
exit 0

## Further work

It would be great to have versions of the script for different operating systems, if anyone wants to fork this repo...

## Inspiration

**weatherdesk** was inspired by [Satellite Eyes](https://satelliteeyes.tomtaylor.co.uk), a Mac app by Tom Taylor, and by the amazing work of remote sensing satellites and those who make them possible.

This is the script mentioned in James Bridle (@stml)'s book [Ways of Being](http://jamesbridle.com/books/ways-of-being), in the chapter *Seeing like a Planet*.
