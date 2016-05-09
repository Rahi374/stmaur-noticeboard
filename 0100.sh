# 0100

# Variables:
# Today's date
today=$(date +%Y-%m-%d)

cd /home/pi/noticeboard-vid/

# Download the list of files so that we don't
# have to query Google Drive so many times
drive list > ./list

# Logging
echo script run on $today >> /home/pi/log-0100

# If there were any files uploaded today
if [[ -n $(cat list | grep $today) ]]; then

    # Logging - files uploaded today
    echo Files uploaded today >> /home/pi/log-0100

    # If there is a file called new
    if [[ -n $(cat list | grep $today | grep new) ]]; then
        # - Make a new directory for today
        mkdir $today
	# - And set the current video flag to today
	echo $today > /home/pi/noticeboard/cvf

        # Logging - making new batch
        echo Making new batch >> /home/pi/log-0100

    else
        # Logging - appending
        echo Appending new files >> /home/pi/log-0100
    fi

    # cd in to the dir given by cvf
    # either set just right now or unchanged from before
    cd /home/pi/noticeboard-vid/$(cat /home/pi/noticeboard/cvf)
    
    # Now download all the files
    # - Download files (if they exist)
    for i in $(cat ../list | grep $today | awk '{ print $1 }')
    do drive download -i $i
    done
    
    # And remove the new file flag
    rm new
else

    # Logging - nothing uploaded today
    echo Nothing uploaded today >> /home/pi/log-0100

fi
