#!/bin/bash
setSetting () {
	local var=$1
	local new_val=$2	
	local file="$HOME/emudeck/settings.sh"
	local settingExists=$(grep -rnw "$file" -e "$var")
	if [[ $settingExists == '' ]]; then
		#insert setting to end
		sed -i -e '$a\'"$var=$new_val" "$FILE"
	elif [[ ! $settingExists == '' ]]; then
		echo "Old value $settingExists"
		#update setting
		sed -i "s|^$var *= *.*|$var=$new_val|; s|^$var [^=]*$|$var $new_val|" "$file"
	fi
	#Update values
	echo "$var changed to $new_val"
	source "$HOME/emudeck/settings.sh"
}