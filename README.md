# St. Maur Noticeboard

Controller program for the St. Maur Noticeboard

### Introduction

This is a collection of scripts to display images on a screen (in the form of a looping slideshow) from a Raspberry Pi. In theory it should work anywhere, but I made it for a Raspberry Pi connected to a 1920x1080 TV screen.

### Requirements

- Google Drive cli client: https://github.com/prasmussen/gdrive
- fbi

sudo is also used under the assumption that the password won't need to be entered.

### Installation

1. Set up the Google Drive cli client and initialize it to the Google Drive folder that will be used

2. Download or git clone this project directory

3. The directories that I set the scripts to use are `/home/pi/noticeboard` (this project directory) and `/home/pi/noticeboard-vid` (where all the images are downloaded to), so if you don't want to edit my scripts, `mkdir /home/pi/noticeboard-vid` and then `mv` this directory to `/home/pi/noticeboard`

4. `chmod +x 0100.sh` and `chmod +x run.sh` (within this project directory)

5. Since fbi can't be cronned (for some odd reason), my hacky solution is the run it from `.bash_profile`, so add the following to you `.bash_profile` (assuming the username is pi):

   `source /home/pi/.bashrc`

   `/home/pi/noticeboard/run.sh`

6. Add `/home/pi/noticeboard/0100.sh` to your crontab to run at whatever time you want. I set mine at 1 in the morning, with a sudo reboot 5 minutes before and after (5 minutes before since the internet randomly disconnects at my school and 5 minutes after to start the slideshow)

7. Enable auto-login to tty1 at user `pi`:

   1. `sudo nano /etc/inittab`
   2. Comment out `1:2345:respawn:/sbin/getty 115200 tty1`
   3. Add this below the commented out line in step 2: `1:2345:respawn:/bin/login -f pi tty1 </dev/tty1 >/dev/tty1 2>&1`
   4. Save, exit, reboot

### Usage

The Google Drive folder may be distributed however you wish. People who have editing access to that folder will be able to upload files that they want to be displayed.

The naming no longer matters and the process it much simpler.

1. Upload pictures to the Google Drive folder

Yeah that's pretty much it. The system picks up the files by date and by default appends any new pictures to the currently running slideshow. If you want to add a whole new batch (and get rid of the old pictures), just upload a file called "new". There must be no extension and the filetype and content do not matter.

If there are no files for a given day, then there will be no change in the slideshow.

### Future plans

I think this is pretty much frozen. The only things that I might want to do:

- Auto-delete old unused pictures
- Easier customization of work directory and file-saving directory

### Passing on

This project actually got decomissioned when the tech department at our school decided that they have a bigger budget than me and made something better and more expensive than me so this project is basically dead.

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
