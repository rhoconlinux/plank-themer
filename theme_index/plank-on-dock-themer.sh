#!/bin/bash


#VARIABLE DEFINITIONS AND DEFINITION CHECKS
#============================================
echo .starting with definitions....
cd ~/.config/plank/dock1/theme_index/
ls
_dest="$HOME/.config/plank/dock1/theme_index/"
_file="simple_desktop_creator.desktop"
_focus=$_dest$_file
 
echo "everything went ok."
echo
echo " Path Test......... "  
echo ...full focus:
echo "$_focus"
echo ...directory:
echo "$_dest"
echo ...filename:
echo "$_file"




#==============================================================================================
#====--------PLANK THEMER IS BUILDING ITEMS: LIST OF THEMES AND PER-THEME-APPLYER --------=====
#==============================================================================================


#VERSION CHECKER: list, items sh and desktop items
#=================================================
while IFS= read -r file
        do
		cd "$_dest"        	
		echo "Testing for previous installs...." #info on previous versions
		if [ -f "$file".desktop ]; then
			echo "Theme "$file".Desktop Detected! ...Automatically erasing that stuff"
			rm "$file".desktop
		else
		echo "...no launcher found:"
		echo "Creating a brand new one"
	fi
		done < "$HOME/.config/plank/dock1/theme_index/themes.list"

while IFS= read -r file
        do
		cd "$_dest"        	
		echo "Testing for previous installs...." #info on previous versions
		if [ -f "$_dest""$file".sh ]; then
			echo "Theme "$file".sh Detected! ...Automatically erasing that stuff"
			rm "$file".sh
		else
		echo "...no launcher found:"
		echo "Creating a brand new one"
	fi
		done < "$HOME/.config/plank/dock1/theme_index/themes.list"



#SEARCH FOR THEMES AND INDEX BUILD
#==================================
	#theme lists
	mkdir -p $HOME/.config/plank/dock1/theme_index/
	if [ -f $HOME/.config/plank/dock1/theme_index/themes.list  ]; then rm $HOME/.config/plank/dock1/theme_index/themes.list ; fi 
	#delete files if exist
	ls /usr/share/plank/themes > $HOME/.config/plank/dock1/theme_index/themes.list  
	echo
	echo
	echo "Yeah. I see. You have these themes installed:"
	cat $HOME/.config/plank/dock1/theme_index/themes.list
	echo
	echo
#construye el index de temas instalados



#DESKTOP FILES BUILDER
#=====================

##get the icon override (not necesary if using github)
#		loc="$HOME/.config/plank/dock1/theme_index/theme-icons"
#				echo "Testing for previous installs...." #info on previous versions
#				if [ -d "$loc" ]; then #-d check directories
#					echo "Previous icon FOLDER Detected! ...Automatically erasing that stuff"
#					rm -R "$HOME/.config/plank/dock1/theme_index/plank-themer-ondock"
#				else
#				echo "...no previous configs found:"
#				echo "Creating a new stuff"
#			fi
#		mkdir -p $HOME/.config/plank/dock1/theme_index/theme-icons
#wget  -O $HOME/.config/plank/dock1/theme_index/theme-icons/plank_theme.svg
#

while IFS= read -r file
        do
        echo ---------------------------------
		echo \[Desktop Entry\] >> "$file".desktop
		echo Type=Application >> "$file".desktop
		echo Terminal=true >> "$file".desktop
		echo Name="$file" >> "$file".desktop
		echo Icon="$HOME/.config/plank/dock1/theme_index/theme-icons/plank_theme.svg" >> "$file".desktop
		echo Exec="$_dest""$file".sh >> "$file".desktop
		echo "--------------------------------"
cat "$file".desktop
echo
ls "$_dest"
		done < "$HOME/.config/plank/dock1/theme_index/themes.list"
#crea un file .desktop para cada item del index creado en el punto anterior
#linkeado con los sh como ejecutables, también uno por cada item de la lista

#THEME APPLIER .SH
#=====================

while IFS= read -r file
        do
        NEWTHEME="Theme=""$file"
        OLDTHEME="s/Theme=.*$"""
echo $NEWTHEME
echo $OLDTHEME
echo 
		done < "$HOME/.config/plank/dock1/theme_index/themes.list"


while IFS= read -r file
        do
        echo ---------------------------------
		echo "#!/bin/bash" >> "$_dest""$file".sh
		echo sed -i \'s/Theme=.*$/Theme=$file/g\' ~/.config/plank/dock1/settings >> "$_dest""$file".sh
		echo "--------------------------------"
ls "$_dest"
cat "$_dest""$file".sh
echo
		done < "$HOME/.config/plank/dock1/theme_index/themes.list"
#crea los sh por item
#cada sh reemplaza la configuración del tema por el ítem en cuestión. 


#SETTING UP PERMISSIONS
#====================================
chmod +x $HOME/.config/plank/dock1/theme_index/*.desktop 
chmod +x $HOME/.config/plank/dock1/theme_index/*.sh

#MOVING THE .DESKTOP FILES TO THE PROPER TEMP LOCATION
#======================================================
rm -R $HOME/.config/plank/dock1/theme_index/plank-themer-ondock;
mkdir -p $HOME/.config/plank/dock1/theme_index/plank-themer-ondock
cp -a $HOME/.config/plank/dock1/theme_index/*.desktop $HOME/.config/plank/dock1/theme_index/plank-themer-ondock

#=END==========================================================================
#====--------BUILDING ITEMS: LIST OF THEMES AND PER-THEME-APPLYER --------=====
#==============================================================================









#=START==========================================================================
#====--------DOCK STUFF --------=====
#==============================================================================

#move to the place and delete if existed:
cd $HOME/.config/plank/dock1/theme_index/
rm -f -Update-theme-list.desktop

echo "creating the .desktop file to update the theme list..."
#theme-list updater DESKTOP
echo ---------------------------------
		echo \[Desktop Entry\] >> "-Update-theme-list.desktop"
		echo Type=Application >> "-Update-theme-list.desktop"
		echo Terminal=true >> "-Update-theme-list.desktop"
		echo Name="Update-theme-list" >> "-Update-theme-list.desktop"
		echo Icon="$HOME/.config/plank/dock1/theme_index/updater-icon/update-theme-list.svg" >> "-Update-theme-list.desktop"
		echo Exec="$HOME/.config/plank/dock1/theme_index/plank-on-dock-themer-update-theme-list".sh >> "-Update-theme-list.desktop"
		echo "--------------------------------"
cat -Update-theme-list.desktop
echo "creating the .desktop file to update the theme list... done"


#fix for the launcher instead of that above?
#mv myapp.desktop myapp.desktop-bak
#sed -e "s,Icon=.*,Icon=$PWD/app.svg,g" myapp.desktop-bak > myapp.desktop
#rm myapp.desktop-bak







#removing temp file
				if [ -d "$HOME/.temp-plank-themer" ]; then #-d check directories
					echo "Deleting temp FOLDER ...Automatically erasing that stuff"
					rm -R "~/.temp-plank-themer"
				else
				echo "...no temp folder found: weard but nothing to do."
			fi






#PUT THE STUFF IN PLANK
#=============================================


#=======================
#CREATING THE DOCK ITEM
#=======================
#CHECK INSTALL... final result on actual plank dockitems folder
		if [ -f "$HOME/.config/plank/dock1/launchers/plank-themer-ondock.dockitem" ]; then
			echo "old plank-themer-ondock.dockitem Detected! ...Automatically erasing that stuff"
			rm "$HOME/.config/plank/dock1/launchers/plank-themer-ondock.dockitem"
		else
		echo "plank-themer-ondock...no DOCK ITEM found:"
		echo "Creating a brand new one"
	fi

#creation of the dockitem
#check aux file created to be copied as dockitem
#		if [ -f "$HOME/.config/plank/dock1/theme_index/plank-themer-ondock.dockitem" ]; then
#			echo "old plank-themer-ondock.dockitem Detected! ...Automatically erasing that stuff"
#			rm "$HOME/.config/plank/dock1/theme_index/plank-themer-ondock.dockitem"
#		else
#		echo "plank-themer-ondock...no DOCK ITEM found:"
#		echo "Creating a brand new one"
#	fi

#Creating dockitem
echo "Creating plank themer dockitem..."
cd $HOME/.config/plank/dock1/theme_index/
touch $HOME/.config/plank/dock1/theme_index/plank-themer-ondock.dockitem
echo \[PlankItemsDockItemPreferences\] >> $HOME/.config/plank/dock1/theme_index/plank-themer-ondock.dockitem 
echo Launcher=file://$HOME/.config/plank/dock1/theme_index/plank-themer-ondock >> $HOME/.config/plank/dock1/theme_index/plank-themer-ondock.dockitem 

echo "Adding dockitem to the dock..."
#copying the aux file to the actual folder. Fixing result.
cp $HOME/.config/plank/dock1/theme_index/plank-themer-ondock.dockitem ~/.config/plank/dock1/launchers/ 
#FIX
#sed -i 's@Launcher=*@Launcher=file://$HOME/.config/plank/dock1/theme_index/plank-themer-ondock@' $HOME/.config/plank/dock1/launchers/plank-themer-ondock.dockitem 
#=======================
#DOCK ITEM CREATED
#=======================

#CREA EL ITEM QUE VA EN EL DOCK
#==================================
		#check install
cd $HOME/.config/plank/dock1/theme_index/
chmod +x plank-on-dock-themer-update-theme-list.sh




#.........................................

#=========================================
#DOCK ITEM *ON DOCK*: after plank anchor
#=========================================

#killall plank;

#fix timestamp on dock item
#touch -d date -d @1387748732 $HOME/.config/plank/dock1/launchers/plank-themer-ondock.dockitem 

const='plank-themer-ondock.dockitem'
if [ -e ~/.config/plank/dock1/settings ]; then
	  grep -q -e "$const" ~/.config/plank/dock1/settings
  echo "dockitem already there, nothing to do"
  if [ $? = 1 ]; then
    echo "$const  ; not found but will be inserted as first item!"
    sed -i 's@DockItems=plank.dockitem;;@DockItems=plank.dockitem;;plank-themer-ondock.dockitem;;@' ~/.config/plank/dock1/settings 
	sed -i 's@DockItems=plank.dockitem;;@DockItems=plank.dockitem;;plank-themer-ondock.dockitem;;@' ~/.config/plank/dock1/settings 
	sed -i 's@plank-themer-ondock.dockitem\n@\n@g' ~/.config/plank/dock1/settings 
  fi
fi


# Add '#' to beginning of line if it is not already there
# thanks! http://www.unix.com/red-hat/184711-how-use-if-condition-sed-command-bash.html
# Adding the button then...
#sed -i 's@DockItems=plank.dockitem;;*@DockItems=plank.dockitem;;plank-themer-ondock.dockitem;;@' ~/.config/plank/dock1/settings 
echo "last step: putting the themes as entries on the dock window"
cd $HOME/.config/plank/dock1/theme_index/plank-themer-ondock
cp $HOME/.config/plank/dock1/theme_index/*.desktop $HOME/.config/plank/dock1/theme_index/plank-themer-ondock
cd $HOME/.config/plank/dock1/theme_index/plank-themer-ondock
chmod u+x **/*.sh
#read -p  "Updating themes... Do you want to continue? " goon
cd $HOME/.config/plank/dock1/theme_index/
sh plank-on-dock-themer-update-theme-list.sh
cd $HOME
clear

#LAST STEP:
#Copying the items, filling up the list

echo "Everithing went OK so far!"
echo ""
echo "Now, do you want to INSTALL THE THEMES of the repository?"  
echo " (They will be writen in your plank folder /usr/share/plank/themes/)"
echo "The process requires root pemissions."  
echo ""
#read -r -p "INSTALL THE THEMES? Press [y] to install [n] to Continue " response
confirm () {
    # call with a prompt string or use a default
    read -r -p "${1:-Are you sure? [y/N]} " response
    case $response in
        [yY][eE][sS]|[yY]) 
            true
            ;;
        *)
            false
            ;;
    esac
}
confirm "Install the themes (y/Y) or finish the installation (n/N)"&& cd $HOME/.config/plank/dock1/themes-repo/Themes && sudo cp -v -a . /usr/share/plank/themes
#http://stackoverflow.com/questions/3231804/in-bash-how-to-add-are-you-sure-y-n-to-any-command-or-alias


#if [[ $response =~ ^(yes|y|Y|YES|Yes)$ ]];then
#    echo "copying"
#    cd $HOME/.config/plank/dock1/themes-repo/Themes && sudo cp -v -a . /usr/share/plank/themes
#fi

cd $HOME/.config/plank/dock1/theme_index/
sh plank-on-dock-themer-update-theme-list.sh
echo "... Done! :)" 
cd $HOME
clear

# credits: http://stackoverflow.com/questions/226703/how-do-i-prompt-for-input-in-a-linux-shell-script?newreg=00988c8ac8f347f3b777f811aab675c8



#CLOSING
clear
echo "Success!"
echo "Thanks for trying Plank-Themer v.02!!!"
echo ""
echo "How to use:"
echo "-----------"
echo "1) Click on the NEW DARK ICON you now see on Plank"
echo "2) Select your theme to change to look of the Dock"
echo ""
echo "...And remember to comment if you experience anything odd ^_^"
echo "https://rhoconlinux.wordpress.com/?s=plank+themer"
echo ""
echo ""
#plank &
#kill && 
#thank you Crusty! http://ubuntuforums.org/showthread.php?t=1685823


# #OLD VERSION CHECKER
# echo 
# echo "Testing for previous installs...." #info on previous versions
# if [ -f $_focus ]; then
# echo "Detected! ...Automatically erasing previous installs to continue"
# else
# echo ""
# echo "...no history found:"
# echo "Creating a brand new config file"
# fi
# if [ -f "$_focus" ]; then rm "$_focus" ; fi #check & delete previous tries

#sed 's/room\(MAX\|MIN\)\(\[[^]]*\]\)/room\2.\1/' inputfile
#input.output.roomMAX[0]        to   input.output.room[0].MAX
# s/\(.*\) \(..*\)/\2 \1/
#sed '/^all:/ s/$/ anotherthing/' file
