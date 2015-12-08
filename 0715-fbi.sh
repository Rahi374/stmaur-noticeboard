# 0715

# Variables:
# Today's date
today=$(date +%Y%m%d)
# Date of cvf
d=$(head -n 1 /home/pi/noticeboard/cvf)

cd /home/pi/noticeboard/$d/
fbi -m 1920x1080 -a -t 3 --noverbose ./*
