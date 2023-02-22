#!/bin/bash

#variables
Slippi_emuName="Slippi"
Slippi_emuType="AppImage"
Slippi_emuPath="$HOME/Applications/Slippi.AppImage"
releaseURL=""

#cleanupOlderThings
Slippi_cleanup(){
 echo "NYI"
}

#Install
PCSX2QT_install(){
	echo "Begin Slippi Install"
	installEmuAI "slippi" "$(getReleaseURLGH "project-slippi/slippi" "Slippi.AppImage")" #pcsx2-Qt.AppImage
}

#ApplyInitialSettings
Slippi_init() {
	echo "Begin Slippi Init"
    
    Slippi_migrate
    
    configEmuAI "slippi" "config" "$HOME/.config/slippi" "$EMUDECKGIT/configs/org.slippi_emu.slippi/config/slippi" "true"
    configEmuAI "slippi" "data" "$HOME/.local/share/slippi" "$EMUDECKGIT/configs/org.github.project-slippi.slippi/data/slippi" "true"
    
    Slippi_setEmulationFolder
    Slippi_setupStorage
    Slippi_setupSaves
    Slippi_finalize
}

#update
Slippi_update() {
	configEmuFP "${Slippi_emuName}" "${Slippi_emuPath}"
	Slippi_setupStorage
	Slippi_setEmulationFolder
	Slippi_setupSaves
}

#ConfigurePaths
Slippi_setEmulationFolder() {
	configFile="$HOME/.var/app/${Slippi_emuPath}/config/dolphin-emu/Dolphin.ini"
	gameDirOpt='ISOPath0 = '
	newGameDirOpt='ISOPath0 = '"${romsPath}/Slippis"
	sed -i "/${gameDirOpt}/c\\${newGameDirOpt}" "$configFile"
}

#SetupSaves
Slippi_setupSaves(){
	unlink "$savesPath/Slippi/states"
	linkToSaveFolder Slippi GC "$HOME/.var/app/io.github.project-slippi.Slippi/data/dolphin-emu/GC"
	linkToSaveFolder Slippi Wii "$HOME/.var/app/io.github.project-slippi.Slippi/data/dolphin-emu/Wii"
	linkToSaveFolder Slippi StateSaves "$HOME/.var/app/io.github.project-slippi.Slippi/data/dolphin-emu/StateSaves/"
}


#SetupStorage
Slippi_setupStorage(){
   	echo "NYI"
}


#WipeSettings
Slippi_wipe() {
	rm -rf "$HOME/.var/app/${Slippi_emuPath}"
}


#Uninstall
Slippi_uninstall() {
	flatpak uninstall "${Slippi_emuPath}" -y
}

#setABXYstyle
Slippi_setABXYstyle(){
    	echo "NYI"
}

#Migrate
Slippi_migrate(){
	migrateDolphinStates "Slippi" "io.github.project-slippi.Slippi"
}

#WideScreenOn
Slippi_wideScreenOn(){
	echo "NYI"
}

#WideScreenOff
Slippi_wideScreenOff(){
	echo "NYI"
}

#BezelOn
Slippi_bezelOn(){
echo "NYI"
}

#BezelOff
Slippi_BezelOff(){
echo "NYI"
}

Slippi_IsInstalled(){
	if [ "$(flatpak --columns=app list | grep "$Slippi_emuPath")" == "$Slippi_emuPath" ]; then
		echo "true"
	else
		echo "false"
	fi
}

Slippi_resetConfig(){
	Slippi_init &>/dev/null && echo "true" || echo "false"
}

#finalExec - Extra stuff
Slippi_finalize(){