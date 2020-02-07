# Project Simplunar

This project was created to document a way to get all the game ROMs
from a Mega Drive/Genesis Mini, to feed it to desktop emulators, or
real hardware using an Everdrive.

The instructions here are based on the code in [Project Lunar](https://modmyclassic.com/project-lunar/)
and its [desktop application](https://github.com/Project-Lunar/Project-Lunar-Desktop-App),
and for Linux systems.

## Prepare the console

Note that you will need to use a micro-USB cable with data lines so that the
computer can communicate with the console. The bundled SEGA micro-USB cable does
not have those data lines.

1. Unplug all the cables from the console.
1. Plug the micro-USB cable into your computer
1. Ensure the Power switch is in the ON position
1. Hold down the RESET button
1. Plug in the USB cable into the back of your console
1. Keep holding RESET, the LED will flash off and back on. Once the LED has
   flashed back on you can let go of RESET after a second or so.

You can verify that this worked by checking for a device with IDs `1f3a:efe8` in
the `lsusb` output.

## 1. Software

You will need to have the `fel` sunxi tool install. The binary is called
`sunxi-fel` in some distributions, and is usually packaged under the name
`sunxi-tools` (in Fedora and Ubuntu at least).

## 2. Boot 

We're now going to make the console boot using a slightly modified kernel and
initrd which has an ssh server running.

Launch `sudo ./boot-script.sh`, you should see something like:

```
$ sudo ./boot-script.sh
Transfering FES
Executing FES
Transferring uImage
Transferring uInitrd
Transferring custom uBoot
Transferring env.bin
Executing custom uBoot
Wait about 30 seconds for boot...
```

## 3. Setting up the network

Now that the console has rebooted using the new software, we need to make some
changes to the network setup. Depending on the underlying OS, things might work
slightly differently, but the gist of it is that the console will show up as a
new network device. You should disable IPv6 on it, and set the IPv4
configuration as “Link-Local Only“.

You should then be able to access the device through ssh:

```sh
$ ssh root@169.254.215.100
```

## 4. Get the data files

Copy the data files that contain the ROMs, and the binary for the emulator.

```sh
$ scp root@169.254.215.100:/tmp/mount/nandd/usr/game/alldata.* .
$ scp root@169.254.215.100:/tmp/mount/nandd/usr/game/m2engage .
```

We need to grab the encryption key from the emulator binary to unpack the
data files[[1](https://github.com/Project-Lunar/Project-Lunar-M2Engage-Library/blob/86c570cdb97516bcd0d3467a8e72d3b4ff463391/M2engage/m2engage.cs#L18-L33)].

```
$ strings m2engage | grep -A 1 getExistFileDirInMountArchive | tail -n 1
<encryption key>
```

## 5. Unpack the files

We now need to unpack the data files using MArchiveBatchTool.

We've provided binaries in this repository for x86-64 for convenience.
Instructions are available in the [bin/README.md](bin/README.md) if you
want to compile the tool yourself.

```sh
$ ./bin/MArchiveBatchTool/MArchiveBatchTool fullunpack --keep alldata.psb.m zstd <encryption key> 64
<snip>
Decompressing alldata.psb.m_extracted/system/roms/eu_jp_World_of_Illusion.bin.m
Decompressing alldata.psb.m_extracted/system/roms/eu_en_The_Story_of_Thor.bin.m
Decompressing alldata.psb.m_extracted/system/roms/eu_en_Vectorman.bin.m
...
```

If you get a warning about `Unable to load shared library 'libzstd' or
one of its dependencies.`, then install the `libzstd-devel` package (Fedora)
or `libzstd-dev` (Ubuntu).

## Conclusion

I'm happy that this allowed me to have legitimate copies of 2 never published
games (the new Tetris and Darius), and copies of a number of expensive games,
which I can now play on a real Mega Drive.

Thanks to Project Lunar for their work, and making their sources available for
me to learn from.