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
	echo $today > ../noticeboard/cvf
	# - Also cd into it
	cd $today

    # And if all the files are old
    else
	# cd into the dir determined by the current video flag
	cd $(echo ../noticeboard/cvf)
    fi

    # Now download all the files
    # - Download files (if they exist)
    for i in $(cat list | grep $today | awk '{ print $1 }')
    do drive download -i $i
    done
    
    # And remove the new file flag
    rm new
fi

echo script run on $today >> /home/pi/log-0100
