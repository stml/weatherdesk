#!/bin/bash
wget -O source.png 'https://view.eumetsat.int/geoserver/ows?service=WMS&request=GetMap&version=1.3.0&layers=msg_fes:rgb_naturalenhncd&styles=&format=image/png&transparent=true&crs=EPSG:4326&bbox=-77,-77,77,77&width=4000&height=4000'
convert source.png -crop 638x384+2290+842 cropped_source.png
convert -size 1276x768 cropped_source.png -magnify -unsharp 0x1 cropped_source.png
composite cropped_source.png black.jpg satellite.jpg
dconf write "/org/gnome/desktop/background/picture-uri" "'file:///home/james/Dropbox/Code/weatherdesk/satellite.jpg'"
exit 0
