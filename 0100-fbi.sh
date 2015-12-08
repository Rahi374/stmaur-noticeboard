# 0100

# Variables:
# Today's date
today=$(date +%Y%m%d)

cd /home/pi/noticeboard/

# - Download files (if they exist)
for i in $(drive list | grep $today | awk '{ print $1 }')
do drive download -i $i
done

if [[ -n $(ls | grep $today) ]]; then
    # - Create today's directory
    mkdir $today
    cd $today
    mv ../$today* ./
fi
