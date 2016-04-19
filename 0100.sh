# 0100

# Variables:
# Today's date
today=$(date +%Y%m%d)
# Files:
# wpf - WebPage Flag: no if today is not a webpage, otherwise holds url
# cvf - Current Video Flag: holds date of the current video

cd /home/pi/noticeboard/

# - Reset webpage flag
echo "no" > wpf

# - Download files (if they exist)
for i in $(drive list | grep $today | awk '{ print $1 }')
do drive download -i $i
done

# - Assuming the files exist, is the file a webpage?
if [ -f $today.txt ]; then
#   > Yes
#     - Set the webpage flag with the url
    head -n 1 $today.txt > wpf
else
    if [[ -n $(ls | grep $today) ]]; then
#   > No
#     - Create today's directory
	mkdir $today
	cd $today
	mv ../$today* ./
#     - Compile video
	# Turn images into videos (mpg)
	for i in $(ls | grep $today | egrep 'jpg|JPG|png|PNG|jpeg|JPEG')
	do
	    w=$(mediainfo --Inform="Image;%Width%" $i)
	    h=$(mediainfo --Inform="Image;%Height%" $i)
	    if [[ w/16 < h/9 ]]; then x=1920 ; else x=-1 ; fi
	    if [[ w/16 > h/9 ]]; then y=1080 ; else y=-1 ; fi
	    ffmpeg -loop 1 -i $i -r 30 -t 3 -vf scale=$x:$y $i.mpg
	done
	# Turn videos into mpg
	for i in $(ls | grep $today | egrep 'mp4|MP4|m4a|M4A|wmv|WMV|avi|AVI')
	do
	    w=$(mediainfo --Inform="Video;%Width%" $i)
	    h=$(mediainfo --Inform="Video;%Height%" $i)
	    if [[ w/16 < h/9 ]]; then x=1920 ; else x=-1 ; fi
	    if [[ w/16 > h/9 ]]; then y=1080 ; else y=-1 ; fi
	    ffmpeg -i $i -vf scale=$x:$y $i.mpg
	done
	
	# Concatenate all mpgs into a final mpg
	cat $(ls | grep $today | grep mpg) > $today.mpg
	# Convert to mp4
	ffmpeg -i $today.mpg $today.mp4
#     - Set current video flag to today
	cd ..
	echo $today > cvf
    fi
fi
