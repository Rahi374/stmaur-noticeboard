# St. Maur Noticeboard

Controller program for the St. Maur Noticeboard

### Introduction

This is a collection of scripts to display images on a screen (in the form of a looping slideshow) from a Raspberry Pi. In theory it should work anywhere, but I made it for a Raspberry Pi connected to a 1920x1080 TV screen.

### Usage

I know it's unusual to have the usage item so high up, but it seems like the user documentation is in higher demand than the technical documentation is so I'm putting this first. I'll put a more technical user documentation below.

A Google Drive folder will be set up for users to upload content to. (This folder is set up during the Installation phase -- see below) This folder obviously must be shared with editing rights to all the users.

Each day, the user may upload pictures which will be appended to the currently running slideshow, or the user may upload pictures which will overwrite the currently running slideshow and will instead start a new slideshow.

1. Create a new folder (if it doesn't already exist) with today's date in the form yyyy-mm-dd (eg. 2016-05-29)

2. Inside that folder, upload the pictures that the user wants to either append to the current slideshow or to start a new slideshow. The naming of the pictures will determine the order that the pictures are shown. In the case that the pictures will be appended to the current slideshow, the pictures must not have the same name as any picture in the current slideshow.

3. If the user wishes to create a new slideshow out of the pictures uploaded today, then create a new Google Doc in the same folder, and name it "new" (all lowercase). If the user wishes to append the pictures to the current slideshow, then this step must be skipped.

4. That's it! Wait 'till tomorrow morning to see your uploaded pictures now being displayed!

Here is an example of the Google Drive main folder:

```
Noticeboard (Main folder)
|
+-> 2016-05-29
|   |
|   +-> 1.jpg
|	+-> 2.jpg
|	+-> 3.jpg
|	+-> new
|
+-> 2016-05-30
    |
    +-> 4.jpg
	+-> 5.jpg
```

In this example, pictures `1.jpg`, `2.jpg`, and `3.jpg` were all uploaded on 2016 May 29th, and the (empty) Google Doc called `new` was also created on the same day. The system then created a looping slideshow of these three pictures. On the next day, on 2016 May 30th, `4.jpg` and `5.jpg` were also uploaded, but since they were unaccompanied by a Google Doc called `new`, these two pictures were simply appended to the slideshow of `1.jpg`, `2.jpg`, and `3.jpg`.

Things to keep in mind:
- The system downloads all the images at 23:30, so that is when "today" ends. That also means that any pictures uploaded between 23:30 and 23:59 will not be picked up, so do not upload any pictures during this time.
- Keep the file extension, whatever it is (eg. .jpg, .png, etc)
- If the day when you are uploading the file is not the same day as the folder of the day, then do not put the file in the folder and instead make a new one for today (eg. if it is May 30th 2016, do NOT put your pictures in the 2016-05-29 folder)
- The pictures will actually be shown in alphabetical order, not numberical order. This means that `10.jpg` will be displayed before `2.jpg`, but `02.jpg` will be before `10.jpg`. Kee this in mind when naming your pictures.
- Each picture will be displayed for 6 seconds. Keep this in mind when designing your pictures, or upload the same picture twice to have it be displayed for longer (but make sure they have different names (eg. `10-1.jpg` and `10-2.jpg`)).

If something goes wrong, from my experience, it's 99% the user's fault for not following instructions. (ie. if you come complaining to me why doesn't it work, it's very, very likely to be your fault, not mine)

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

```bash
source /home/pi/.bashrc
/home/pi/noticeboard/run.sh
```

6. Add `/home/pi/noticeboard/0100.sh` to your crontab to run at whatever time you want. I set mine at 1 in the morning, with a sudo reboot 5 minutes before and after (5 minutes before since the internet randomly disconnects at my school and 5 minutes after to start the slideshow)

7. Enable auto-login to tty1 at user `pi`:

   1. `sudo nano /etc/inittab`
   2. Comment out `1:2345:respawn:/sbin/getty 115200 tty1`
   3. Add this below the commented out line in step 2: `1:2345:respawn:/bin/login -f pi tty1 </dev/tty1 >/dev/tty1 2>&1`
   4. Save, exit, reboot

### Usage (more technical)

I learned the hard way that when you give your users options, they screw everything up. Here's a list of options that I made requirements up there and some extra information (if you are not a technical/power user, either don't read this or just ignore this)

- The date folders don't actually matter. Their names don't matter, and even their existence doesn't matter. It just makes the whole thing more organized.
- The empty Google Doc named `new` doesn't have to be a Google Doc. It can be any file. Only its existence is checked up and it's deleted immediately anyway.
- The file extensions of the pictures won't affect if they're downloaded or not. The system downloads all pictures uploaded to the Google Docs during the day and tries to display it.
- All of the times that I wrote up there are dependent on the implementation of the system (ie. what times were decided in the crontab)

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
