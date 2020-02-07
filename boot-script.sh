#!/bin/sh

FEL=sunxi-fel

# Ported from:
# https://github.com/Project-Lunar/Project-Lunar-Desktop-App/blob/750ba0f809581fe181904be9532f8a5439556e4c/MdMiniGameManager/frmInstallRestore.cs#L932-L946

echo Transfering FES
$FEL write 0x2000 resources/fes1.bin
echo Executing FES
$FEL exe 0x2000
echo Transferring uImage
$FEL write 0x43800000 resources/uImage
echo Transferring uInitrd
$FEL write 0x48000000 resources/uInitrd
echo Transferring custom uBoot
$FEL write 0x47000000 resources/u-boot-sun8iw5p1-memboot.bin
echo Transferring env.bin
$FEL write 0x4700D5BC resources/env_initrd.img

echo Executing custom uBoot
$FEL exe 0x47000000

echo Wait about 30 seconds for reboot...

# https://github.com/Project-Lunar/Project-Lunar-Desktop-App/blob/750ba0f809581fe181904be9532f8a5439556e4c/MdMiniGameManager/frmInstallRestore.cs#L165
echo You should now be able to ssh in as root:
echo   $ ssh root@169.254.215.100
echo The password is 5A7213
