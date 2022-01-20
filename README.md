# ObsidianEncryptedCloudSync
Scripts to encrypt Obsidian Vaults and sync them over the cloud

A setup and shell scripts to use a public cloud service as Dropbox to sync encrypted Obsidian Vaults between Mac an/or Linux and/or Android devices. No root needed.

When closing the vault, the script will create an encrypted 7z archive of the vault and upload it to the cloud. After closing, all unencrypted notes are deleted. 
To retrieve your notes, the script will make an unzipped copy of the archeive available locally. 

# Installation

## Mac / Linux:
1. Create a cloud linked folder (such as ~/Dropbox/Obsidian_Cloud)
2. Create a local folder that is not linked to the cloud (such as ~/Obsidian_Local)
3. Place vault to be encrypted and synced in Obsidian_Local, rename vault to private_notes
4. Optional if you want to sync Obsidian settings across devices: 
- Open myvault in Obsidian 
- create a symbolic link to local folder ```ln -s ~/Dropbox/Obsidian_Cloud/.obsidian  ~/Obsidian_Local/ ```
5. Install [7-zip](https://www.7-zip.org/download.html) 
6. Zip and encrypt your private_notes using Terminal ``` 7z a -mhe -t7z private_notes.7z private_notes
(You will be prompted for a password. Note it down!)	
8. dowonload  toggle_private.sh from repository and place it anywhere on your  computer
9. adapt paths in script where shown
10. Make script executable  ```chmod +x toggle_private.sh ```
11. Optional in Mac: Make skript command as to execute it on click ```mv toggle_private.sh toggle_private_vault.command```
12. Install [7-zip](https://www.7-zip.org/download.html) 

## Android:
1. Install [Termux](https://github.com/termux/termux-app) and [Termux Widget](https://github.com/termux/termux-widget) 
2. Install Cloud Service App (as Dropbox) and a Folder Sync App of your choice (as [Dropsync](https://play.google.com/store/apps/details?id=com.ttxapps.dropsync&hl=de&gl=US))
3. On File Manager create an Obsidian_Local Folder anywhere on your device
4. On Folder Sync App, pair Obsidian_Local with Obsidian_Cloud on the Cloud Service App. Exclude pattern myvault to be synched. 
5. Download toggle_vault_droid.sh from repository to your device
6. adapt path to Obsidian_Local in script
7. Open Termux and enter ```mkdir .shortcuts; mv /path_to/toggle_droid.sh .shortcuts```
8. Make script executable  ```chmod +x .shortcuts/toggle_droid.sh ```
9. Type ```7z```and install the package as instructed. In case mirror is down change mirror:  ```termux-change-repo```
10. Install a Termux Widget pointing to toggle_droid.sh

# Usage
(on any device) 
1. Start toggle_private or toggle_droid by click or via command line
2. If vault is open, you will be promted to close it
3. If vault is closed, you will be prompted for password to open it
