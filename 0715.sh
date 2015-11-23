# 0715

# Variables:
# Today's date
today=$(date +%Y%m%d)
# Date of cvf
d=$(head -n 1 /home/pi/noticeboard/cvf)
# Files:
# wpf - WebPage Flag: no if today is not a webpage, otherwise holds url
# cvf - Current Video Flag: holds date of the current video

# - Webpage flag?
if [ ! "$(head -n 1 /home/pi/noticeboard/wpf)" = "no" ]; then
#   > Yes
#     - Display webpage
    midori --display=:0.0 $(head -n 1 /home/pi/noticeboard/wpf)
else
#   > No
#     - Play video based on video flag
    omxplayer --loop --display=:0.0 /home/pi/noticeboard/$d/$d.mp4
fi
