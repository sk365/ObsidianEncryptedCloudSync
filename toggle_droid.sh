# no shebang when placing Android file in .shortcuts ! 

## Enter your path here
local_path=/storage/emulated/0/Obsidian_Local

## Define your devices here
this_device=android
other_device=mac

# these flags serve to test if vault is open and when it was opened
# NB. Unlike desktop version, path must be local here, as cloud sync is done by Folder Sync
flag_this_device="${local_path}/private_vault_is_open_"${this_device}".f"
flag_other_device="${local_path}/private_vault_is_open_"${other_device}".f"

cd $local_path

# test if vault is open on other device

if [ -f $flag_other_device ]; then 
echo "Vault is open on other device!" 
read -p "Risk of conflict. Proceed anyway? (y) " proceed
	if [ "$proceed" != "y" ]; then
	exit 0
	fi
fi

# test if vault is open on this device
if [  -f $flag_this_device ]; then 
	echo ----
	echo		
	echo "Vault is open on this device!" 
	pw=0
	pw1=1
	until [ "$pw" = "$pw1" ]
		do		
			read -p "Enter password to close vault (or exit: x)  " pw
			if [ "$pw" = "x" ]; then exit; fi	
			read -p "Re-enter password " pw1
		done
else
# open vault if closed on this device
	error=1
	until [ $error = 0 ]
	do
		echo
		read -p "Enter password to open vault (or exit: x)  " pw
		if [ "$pw" = "x" ]; then exit; fi
		rm -rf private_notes	
# 		dont copy on Android as this is done by Folder Sync
#		cp $cloud_path/private_notes.7z $local_path/
#		unzip and decrypt		 	
		7z x -p$pw private_notes.7z 
		error=$?
	done
	
	touch $flag_this_device
	echo ----
	echo		
	echo "Vault is open on this device!"	
	read -p "Close vault? (y / else: exit)  " close
	if [ "$close" != y ]; then exit; fi	
fi
	
# adapt creation dates for all files that have been modified since vault opening
# remove this find loop if ypu not care about creation date
	
find  ./private_notes -newer $flag_this_device -type f | while read filename
	do 
	head2=$(head -2 "${filename}")
	created=${head2:13:20}
	yyyy=${created:0:4}
	mm=${created:5:2}
	dd=${created:8:2}
	hh=${created:11:2}
	mn=${created:14:2}
	unix_date="${yyyy}${mm}${dd}${hh}${mn}"
	touch -m -t $unix_date "${filename}" 
done



# zip vault, close it, and move 7z file to cloud	
#	back up and remove old version to avoid conflict

cp 	private_notes.7z private_notes.7z.bak
rm -f private_notes.7z	

#	zip and encrypt private notes
7z a -mhe -t7z -p$pw private_notes.7z private_notes
	
# dont push to cloud on Android as this is done by folder sync
# mv private_notes.7z $cloud_path

rm -rf private_notes
rm -f $flag_this_device

exit


