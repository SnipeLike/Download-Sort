#!/bin/sh

#---------------#
# Download-Sort #
# v0.8          #
#---------------#

#Env-Var
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin

#Var
dloadFolder1="/jDownloader/Downloads/extracted"
showsFolder1="/NAS/Shows"
showsFolder2="/NAS/Shows-English"
newShowDir=""

#Read Folder/File Name
cd "$dloadFolder1"

#For every folder in Directory
for sdir in *;
do

	#Read Folder/File Name
	cd "$dloadFolder1"

        #Check if Folder/File older than 5 Min (Prevent moveing in use folders)
        if [ $(find $sdir -mmin +5 | wc -l) -gt 0 ]; then
		sourceName=$(basename $sdir)

		#Check if object is not a Folder
		if [ ! -d $sdir ]; then

			#Create new Folder and move Show into it
			newShowDir=$(echo "$sourceName" | sed -r 's/.{4}$//')
			mkdir $newShowDir
			mv $sourceName $newShowDir
			#sdir="$newShowDir"
		fi

		#Set destPath English or German depending on sourceName
		case  "$sourceName" in
			*.GERMAN.*)
				destPath="$showsFolder1"
				echo "German"
				;;

			*.German.*)
				destPath="$showsFolder1"
				echo "German"
				;;

			*)
				destPath="$showsFolder2"
				echo "English"
				;;
		esac


		#Get TV Show
                cd $destPath

                for ddir in *;
                do
                        tvShow="$ddir"

                        #Replace Spaces with "." in Destination Folders
                        tvShowRepl=$( echo "$tvShow" | tr '[ ]' '.')

                        #Search matching Show
                        case "$sourceName" in
                                *"$tvShowRepl"*)

                                        #Debug
                                        echo "Match for:" "\033[1;33m"$tvShow"\033[0m"

                                        #Get Season Number
                                        case "$sourceName" in
                                                *"S01"*)
                                                        season="Staffel 01"
                                                        ;;

                                                *"S02"*)
                                                        season="Staffel 02"
                                                        ;;

                                                *"S03"*)
                                                        season="Staffel 03"
                                                        ;;

                                                *"S04"*)
                                                        season="Staffel 04"
                                                        ;;

                                                *"S05"*)
                                                        season="Staffel 05"
                                                        ;;

                                                *"S06"*)
                                                        season="Staffel 06"
                                                        ;;

                                                *"S07"*)
                                                        season="Staffel 07"
                                                        ;;

                                                *"S08"*)
                                                        season="Staffel 08"
                                                        ;;

                                                *"S09"*)
                                                        season="Staffel 09"
                                                        ;;

                                                *"S10"*)
                                                        season="Staffel 10"
                                                        ;;

                                                *"S11"*)
                                                        season="Staffel 11"
                                                        ;;

                                                *"S12"*)
                                                        season="Staffel 12"
                                                        ;;

                                                *)
                                                        echo "No matching Season found for" $sourceName
                                                        ;;
                                        esac

                                        #Copy downloaded Episode into target folder
                                        source="$dloadFolder1"/"$sourceName"
                                        dest="$destPath"/"$tvShow"/"$season"/

                                        mv "$source" "$dest"
					if [ $? -eq 0 ]; then
                                        	echo "Moved:""\033[1;32m" $sourceName "\033[0m""to""\033[34m" $dest"\033[0m"
					else
						echo "Failed to move" "\033[31m"$sourceName"\033[0m"
					fi

                                        ;;

                        esac
                done

        fi

done
