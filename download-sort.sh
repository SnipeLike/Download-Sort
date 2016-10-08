#!/bin/sh
#---------------#
# Download-Sort	#
# v0.2     	#
#---------------#

#Var
dloadFolder="/Downloads/jDownloader"
showsFolder="/NAS/Shows"

#Read Folder/File Name
cd "$dloadFolder"
for sdir in *; 
do
	sourceName=$(basename $sdir)
	
	cd $showsFolder
	for ddir in *;
	do
		tvShow="$ddir"
		#Replace Spaces with "." in Destination Folders
		tvShowRepl=$( echo "$tvShow" | tr '[ ]' '.')
		
		#Search matching Show
		case "$sourceName" in
			*"$tvShowRepl"*)
				#Debug
				#echo "Match"
				
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
				
				#Copy downloaded Episode into target folder$
				source="$dloadFolder"/"$sourceName"
				dest="$showsFolder"/"$tvShow"/"$season"/
				logOut=$(mv -v "$source" "$dest")
				
				#Debug
				#touch download-sort.log
				#mv -v "$source" "$dest">>download-sort.log
				#echo "Series Moved"
				;;
			*)
				#Show not found
				echo "No matching Show"
				;;
		esac
	done
done
