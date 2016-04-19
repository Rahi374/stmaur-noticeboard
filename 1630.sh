# 1630

# Variables:
# Today's date
#today=$(date +%Y%m%d)
# Files:
# wpf - WebPage Flag: no if today is not a webpage, otherwise holds url
# cvf - Current Video Flag: holds file name of the current video

# - Webpage flag?
#if [ ! "$(head -n 1 /home/pi/noticeboard/wpf)" = "no" ]; then
#   > Yes
#     - Kill browser
    sudo killall midori
#else
#   > No
#     - Kill video player
    sudo killall omxplayer
#fi
