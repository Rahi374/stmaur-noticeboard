# 0100

# Variables:
# Today's date
today=$(date +%Y-%m-%d)

cd /home/pi/noticeboard-vid/

# Download the list of files so that we don't
# have to query Google Drive so many times
drive list > ./list

# If there were any files uploaded today
if [[ -n $(cat list | grep $today) ]]; then

    # If there is a file called new
    if [[ -n $(cat list | grep $today | grep new) ]]; then
        # - Make a new directory for today
        mkdir $today
	# - And set the current video flag to today
	echo $today > /home/pi/noticeboard/cvf
    fi

    # cd in to the dir given by cvf
    # either set just right now or unchanged from before
    cd /home/pi/noticeboard-vid/$(echo /home/pi//noticeboard/cvf)
    
    # Now download all the files
    # - Download files (if they exist)
    for i in $(cat ../list | grep $today | awk '{ print $1 }')
    do drive download -i $i
    done
    
    # And remove the new file flag
    rm new
fi

echo script run on $today >> /home/pi/log-0100
