#!/bin/sh
#---------------#
# Download-Sort	#
# v0.3   	#
#---------------#

#Var
dloadFolder="/Downloads/jDownloader"
showsFolder="/NAS/Serien"

#Read Folder/File Name
cd "$dloadFolder"
for sdir in *; 
do

	#Check if Folder older than 5 Min (Prevent moveing in use folders)
	if [ $(find $sdir -type f -mmin +5 | wc -l) -gt 0 ]; then
		
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
					echo "Match for:" $tvShow
			
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
					#echo "No matching Show"
					;;
			esac
		done
	
	else
		echo "Time if"	
	
	fi
done
