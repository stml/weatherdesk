#!/bin/bash
wget -O source.png 'https://view.eumetsat.int/geoserver/ows?service=WMS&request=GetMap&version=1.3.0&layers=msg_fes:rgb_naturalenhncd&styles=&format=image/jpeg&crs=EPSG:4326&bbox=-77,-77,77,77&width=4000&height=4000'
convert source.png -crop 1276x768+1736+624 cropped_source.png
dconf write "/org/gnome/desktop/background/picture-uri" "'file:///home/james/Dropbox/Code/weatherdesk/cropped_source.png'"
exit 0
