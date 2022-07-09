# ddr-picker
ddr-picker is a [pegasus-fe](https://pegasus-frontend.org/)-based game frontend for Dance Dance Revolution cabinets.<br> it was created to be as fast, pretty, and seamless as possible.

https://user-images.githubusercontent.com/72628412/178119730-f949970a-1269-4377-9f61-493f88cf89aa.mp4

if you are looking for a plug-and-play solution, look elsewhere. this will require a lot of manual reworking for your exact system.<br>
this will NOT WORK on an original CRT without heavy reworking of all the graphics, and scripts.

ddr-picker was specifically optimized for the niche of DDR cabinets that feature a Windows 10 PC plugged into a Dell Ultrasharp U3014 LCD running in 2133 x 1600 resolution (4:3, maxing out the vertical resolution of the monitor) underneath the original display bezel.<br>
the DDR cabinet's control panel is handled using a [J-PAC](https://www.ultimarc.com/control-interfaces/j-pac-en/j-pac-c-control-only-version/), which makes the buttons on the cab function like a keyboard. the lighting is handled using a [LIT board](https://dinsfire.com/projects/lit-board/).

this was a personal project that i originally never intended to share, but i've put enough work into it at this point that i want to save other people the time of building something like this from the ground up.<br>
i'm a [graphic designer](https://clue.graphics), and not a coder -- so ddr-picker is bodged together in the only way i know how: [autohotkey](https://www.autohotkey.com/).

## features:

- custom version of [bemani-mame](https://github.com/987123879113/mame/wiki) that instantly loads 573 mixes at the title screen, with event mode enabled in every mix that supports it
- every game supports the original cab lighting, using a [LIT board](https://dinsfire.com/projects/lit-board/).
- hand-made graphics for every single DDR logo, including many custom square logos that fit better in each "tile"
- custom pegasus theme based on [pegasus-grid-micro](https://github.com/mmatyas/pegasus-theme-grid-micro), optimized for a high-resolution 4:3 display
- reset button to return to the menu after opening a game
- support for DDR Solo, if you have a stage that supports it

---
---

## installation:

#### first thing you're gonna need to do is get your cab modded with an LCD.
- acquire a 30" 16:10 display, such as the Dell Ultrasharp U3014.
- safely discharge and remove the original CRT, and store it in a safe place, or sell it to someone that will appreciate it more than you do.
- [build a display mount out of wood so that the 16:10 display lines up perfectly with the original bezel.](https://user-images.githubusercontent.com/72628412/178120376-47b18732-93ec-43bb-a496-6dd16dea765b.jpg)
- be sure to remove the plastic front bezel from the LCD. it reduces the distance between the display and the bezel, and makes it look really nice. this can be done easily with a standard spudger to separate the plastic clips.

---

#### next, we gotta get a PC in there.
- get a PC. maybe you have an old rig gathering dust -- you can use that. MAME and simulators aren't very demanding, they'll likely run fine on whatever you already have.
- if you removed the CRT from your DDR cab, you have a ton of room in the back of the monitor box to drop your PC into. that's where i have mine, and it fits very nicely in there.
- create a lightweight Windows 10 install, such as [LTSC](https://docs.microsoft.com/en-us/windows/whats-new/ltsc/), on an SSD with reasonably high capacity. the latest LTSC 2021 is probably fine, but i used LTSC 2019 for no reason in particular.

---

#### now, set up your cab stuff.
- install your [LIT board](https://dinsfire.com/projects/lit-board/) to make your cab lights work, and your [J-PAC](https://www.ultimarc.com/control-interfaces/j-pac-en/j-pac-c-control-only-version/), so your control panel buttons will work.
- i have my control panel set up like this:
![cp-mapping](https://user-images.githubusercontent.com/72628412/178121065-bd7bb1a5-8258-42e7-bedc-ac0ffc1999cd.png)
- i found that this was the best mapping for compatibility with games, and functionality within pegasus-fe's limitations.

---

#### at this point, we can finally get started on setting up pegasus.
- download the latest version of [pegasus-fe](https://pegasus-frontend.org/#downloads).
- place pegasus-fe.exe somewhere like `C:/pegasus/pegasus-fe`. don't run it yet.
- create a blank text document titled `portable.txt` and place it in your `C:/pegasus/pegasus-fe` directory next to pegasus-fe.exe
- download the [modified micro theme zip](https://github.com/evanclue/ddr-picker/raw/main/micro.zip).
- create a new directory in your pegasus folder just called `themes`, and extract the micro zip in there.
- the full path for the micro theme should be `C:/pegasus/themes/micro/`.
- download [settings.txt](https://github.com/evanclue/ddr-picker/raw/main/settings.txt). once you click the link, right click and do "save page as" to download it.
- create a new folder called 'config' in the pegasus directory.
- drop the settings.txt in there. full path should be `C:/pegasus/config/settings.txt`
- if you open pegasus now, it should give you an error saying there are no games installed. so let's get some games!

---

#### now, we can set up MAME for DDR.
i've assembled a ready-to-go pack to get MAME going on your DDR cabinet.<br>you can download it [here](https://drive.google.com/file/d/1MeW7KpsYcS2fmws7ZQG0OomuIFVHAcid/view?usp=sharing), or [here](https://mega.nz/file/ICVRFJwI#ksriX9qHzXEdDwwjsqYv84MN1V43CSedjK8lEosV_7Y). (12GB)<br><br>
it includes:
  - a custom build of [bemani-mame](https://github.com/987123879113/mame/wiki).
  - pre-built NVRAM for (almost) every game, negating the need to install each game manually.
  - save states that drop you right into the title screen of the game with event mode already enabled, skipping the lengthy boot process.
  - all the game data you need to get it going.

once you have the MAME pack downloaded, you should extract it to `C:/pegasus/games/ddr573-mame` for example.<br>
now that we have MAME, we can start writing scripts to get games to launch.

---

#### writing scripts to get games to launch.

you can do this a few different ways. you can do it using a mame.exe shortcut, you can do it as a batch script -- but i've had trouble getting pegasus to open .lnk and .bat files sometimes, and i couldn't really figure out why.<br>my solution was to use autohotkey, compile my scripts as .exe, and have pegasus open the .exe file.

by doing it this way, however, it seems to break pegasus's process watchdog feature, which causes the frontend to restart alongside the game, wasting resources. luckily, this is an easy fix, and just requires us to run a .bat file to kill pegasus before starting the game.

so let's do it.
- install [autohotkey](https://www.autohotkey.com/).
- download the [kill_pegasus script](https://github.com/evanclue/ddr-picker/raw/main/scripts/kill_pegasus.bat), and [this launcher script for DDR Extreme Pro Clarity](https://github.com/evanclue/ddr-picker/raw/main/scripts/launch_ddrexproc.ahk) by right-clicking the page, and doing 'save page as'.
- put both of the scripts next to the mame executable in the `ddr573-mame` folder.

let's take a look at what these scripts actually do.

`run kill_pegasus.bat`<br>
  this will end the pegasus process as soon as the game is opened. it must be a separate batch script, since autohotkey is not authorized to do system tasks like ending a process.<br>
`run mame2lit.exe`<br>
  this runs the mame support program that handles cab lights for a LIT board.<br>
`run mame.exe ddrexproc -state o`<br>
  this tells mame to load DDR Extreme Pro Clarity using a specific save state named 'o'.<br>
i made a save state right before the title screen of the game in event mode, and named them all 'o'. why 'o'? i don't know. whatever, shut up!

- go ahead and run the launcher script. it should drop you into the ddr extreme title screen, with light support. hooray!
- to exit mame, just press esc.
- you can now right click on the .ahk file you made, and click "compile script" to create an .exe of the script that pegasus can run later.

you can easily copy the launcher script, and edit it to point at different games.
to see what save states exist in the pack, you can view `C:\pegasus\games\ddr573-mame\sta`.
all you have to do is replace `ddrexproc` in the launcher script with the name of the games in the `sta` folder that you want to run.
for instance, if you replaced it with `ddr2m`, it would launch Dance Dance Revolution 2ndMIX.
feel free to repeat this for every game listed in the `sta` folder that you want to have in your pegasus setup.

**pro tip:** if you want to have increased visual clarity when booting a game, you can create a shortcut of `kill_pegasus.bat`, `mame2lit.exe`, and `mame.exe`, edit the properties of each shortcut so that they start 'minimized', and then point the autohotkey launcher script to their respective .lnk shortcut files.<br>they will start minimized, and it looks really clean. i prefer it, but whether or not you choose to do it yourself is up to you.

---

#### downloading assets for pegasus
- okay, so we have some game launchers written in autohotkey, and compiled to .exe.
- now, we can download the logos for each game you want to have in your launcher.
- you can download [individual logos](https://github.com/evanclue/ddr-picker/tree/main/assets), or you can just download [the whole pack](https://github.com/evanclue/ddr-picker/raw/main/assets.zip).
- there isn't really any reason why you shouldn't download the whole pack, considering it's only like 9MB of images. but the choice is yours.
- create a new folder inside of the 'config' folder of your pegasus setup, called `metafiles`.
- the full path should be `C:\pegasus\config\metafiles`. drag the assets folder in there, to make it `C:\pegasus\config\metafiles\assets`.
- you should now have a whole bunch of .png files of various ddr logos inside of `C:\pegasus\config\metafiles\assets`.

---

#### setting up the metadata files
- download this [ddr metadata template file](https://github.com/evanclue/ddr-picker/raw/main/scripts/ddr.metadata.pegasus.txt) by right-clicking and doing 'save page as', and place it in your `metafiles` folder, next to `assets`.
- the full path should be `C:\pegasus\config\metafiles\ddr.metadata.pegasus.txt`
- you should be able to boot up pegasus-fe finally, and scroll around! hooray! look how pretty it is!
- the only game you should be able to launch successfully is extreme pro clarity, since we set it up earlier.
- you will need to manually go through your ddr metadata file, remove the games you don't want, and add paths to the launchers of all the games you DO want.
- this is the tedious part, since you'll have to make an autohotkey launcher script for each game, and add the path of each launcher to the metadata file per-game. in the template, replace the `[insert path here]` with the path to your launcher for each game.
- i have also made metafile templates for [Dancing Stage](https://github.com/evanclue/ddr-picker/raw/main/scripts/dancingstage.metadata.pegasus.txt), [In The Groove](https://github.com/evanclue/ddr-picker/raw/main/scripts/itg.metadata.pegasus.txt), and [DDR Solo](https://github.com/evanclue/ddr-picker/raw/main/scripts/solo.metadata.pegasus.txt).
- drop these other template files into your metafiles directory, and you can scroll between each page with numpad 4 and numpad 6. they should have nice little collection logos on the top of the screen to match.

- once you've gone through and made scripts for every game, added them to the corresponding metadata file, and tested each and every game to make sure they launch fine through pegasus, you can start setting up your controls in MAME.

#### setting up controls in MAME.


---
