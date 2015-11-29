# St. Maur Noticeboard

Controller program for the St. Maur Noticeboard

### Introduction

This is a collection of scripts to display images and videos on a screen from a Raspberry Pi. In theory it should work anywhere, but I made it for a Raspberry Pi connected to a 1920x1080 TV screen.

### Requirements

- Google Drive cli client: https://github.com/prasmussen/gdrive
- mediainfo
- ffmpeg (I'm using the "fake" version that comes with the Raspberry Pi)
- egrep
- midori
- omxplayer
- fbi (In a future version)

sudo is also used under the assumption that the password won't need to be entered.

These scripts were also written in the absense of the mpeg codecs for the Raspberry Pi.

### Installation

Download or git clone this project directory, and then add cron entries however you wish. I set it so that the each script runs every weekday at the time it is named.

Also make sure the Google Drive cli client is initialized to the Google Drive folder that will be used. 

### Usage

The Google Drive folder may be distributed however you wish. People who have editing access to that folder will be able to upload files that they want to be displayed. Although the organization does not matter, there are a few naming rules that must be followed in order for the images/videos to be picked up by grep and egrep.

1. The name of the image/video must be "yyyymmdd-n.ext", where n is the number of the order that the image/video will be played and ext is the file extension. If this rule is ignored, grep and egrep will not pick up this file and it will not be downloaded.
2. The dimensions of the images/videos must be the same as the dimensions of the file whose n is 1. If this rule is ignored, the image/video will not show up in the final compiled video

If there are no files for a given day, then nothing will be done in terms of downloading and the most recent video will be played.

The webpage display functionality has not been thoroughly tested yet and usage is not advised.

### Flowchart

#### 0100

- cd to working directory
- Reset webpage flag
- Download all files from the shared Google Drive folder that have today's datestamp (in the filename)
- Is the file a webpage? (ie. a file containing a url)
  - Yes
    - Set the webpage flag with the url
  - No
    - Create a directory with today's datestamp. cd into it and copy all of the downloaded files here.
    - Compile video:
      - Turn images into mpg videos
      - Turn videos into mpg videos
      - cat all the mpg videos together into a final mpg
      - Convert the final mpg to mp4
- Set current video flag to today
    
#### 0715

- Does the webpage flag contain a url?
  - Yes
    - Display the webpage (in midori)
  - No
    - Play the video on a loop based on the current video flag

#### 1630

- Kill midori
- Kill omxplayer

### Future plans

I discovered fbi (Linux FrameBuffer Imageviewer) a few days ago and I'm going to try to implement that. The old system (as described above) will continue to work as I add files for fbi. The user will be free to choose which system to use simply by adding the corresponding system to the crontab.

Changes that will result from the fbi system:
- No file dimension restriction
- Only many images or one video can be shown each day, but not both. (The webpage display function will stay)

### Passing on

Eventually I'll graduate high school. In that event, the new maintainer of this project will fork this repository, and replace my local repository on the school Pi with their forked version, and any new work will be done on their forked version.

I hope this can be passed on for many years.

In that event, please add your name to contributors list and add your own license at the end.

### Contributors

Paul Elder

### License

The MIT License (MIT)

Copyright (c) 2015 Paul Elder

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
