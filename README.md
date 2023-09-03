# LinuxLaptopScrips Main
https://codeberg.org/marvin1099/LinuxLaptopScrips  
https://codeberg.org/marvin1099/LinuxLaptopScrips#Description  
https://codeberg.org/marvin1099/LinuxLaptopScrips#PDF-Scripts  
https://codeberg.org/marvin1099/LinuxLaptopScrips#Audip-Scripts  
https://codeberg.org/marvin1099/LinuxLaptopScrips#Other-Files  
https://codeberg.org/marvin1099/LinuxLaptopScrips#Download  

# LinuxLaptopScrips Backup
https://github.com/marvin1099/LinuxLaptopScrips  
https://github.com/marvin1099/LinuxLaptopScrips#Description  
https://github.com/marvin1099/LinuxLaptopScrips#PDF-Scripts  
https://github.com/marvin1099/LinuxLaptopScrips#Audip-Scripts  
https://github.com/marvin1099/LinuxLaptopScrips#Other-Files  
https://github.com/marvin1099/LinuxLaptopScrips#Download  

# Description
These are a lot of my Linux bash scripts that in use for school.  
Most of them are for PDF conversion.  

# PDF-Scripts
|File in /PDF     |Intput / Output                                                 |Requires                                    |Description|
|-----------------|----------------------------------------------------------------|--------------------------------------------|-----------|
|A4CutMerge.sh    |Input can be pdf, png or jpg - Outputs pdf                      |notify-send convert pdfjam pdfunite identify|              Takes all arguments (assumes its a supported file), cuts off borders, changes the size to A4 and merges all of them into one                |
|A4Merge.sh       |Input can be pdf, png or jpg - Outputs pdf                      |notify-send convert pdfjam pdfunite identify|              Takes all arguments (assumes its a supported file), changes the size to A4 and merges, all of them into one                                 |
|A4PDF.sh         |Input can be pdf or png (could be expanded to jpg) - Outputs pdf|notify-send convert pdfjam pdfunite identify|              Takes all arguments (checks its a supported file) and changes the size to A4, for all of the files inputed                                  |
|A4CutPDF.sh      |Input can be pdf or png (could be expanded to jpg) - Outputs pdf|notify-send convert pdfjam pdfunite identify|              Takes all arguments (checks its a supported file), cuts off borders, changes the size to A4, for all of the files inputed                   |
|PDFtoPNG.sh      |Input can be pdf - Outputs png                                  |convert                                     |              Takes all arguments (assumes its a supported file) and exports all of the pdf pages to png, for all of the files inputed                    |
|OfficeToPDF.sh   |Input can any libreoffie file, Outputs pdf                      |libreoffie                                  |              Takes all arguments (assumes its a supported file) and converts them to pdf for all of the files                                            |
|XoppToPDF.sh     |Input can any xjournal file, Outputs pdf                        |xournalpp                                   |              Takes all arguments (assumes its a supported file) and converts them to pdf for all of the files                                            |
# Audio-Scripts
|File in /Audio   |Intput / Output                                                 |Requires                                    |Description|
|-----------------|----------------------------------------------------------------|--------------------------------------------|-----------|
|MuteDual.sh      |No Input or Output, toggles based on system                     |notify-send pactl awk                       |              Takes no arguments gets the state (muted or unmuted) of virtual device media, toggles if/virtual them and notifys the user about it         |
|Mute.sh          |No Input or Output, toggles based on system                     |notify-send pactl awk                       |              Takes no arguments gets the state (muted or unmuted) of alsa_input (mic), toggles it and notifys the user about it                          |
|SpeakerToggle.sh |No Input or Output, toggles based on system                     |notify-send pactl awk                       |              Takes no arguments gets the state (muted or unmuted) of alsa_alsa_output (speaker), toggles it and notifys the user about it                |
|VolumeSync.sh    |Input can be the string "lower" or "raise", No Output           |kde-plasma pactlawk                         |              Increases or decreases the speaker volume and syncs the volume to all alsa, bluetooth, and virtual media/them to the same volume            |
|MicrophoneSync.sh|Input can be the string "lower" or "raise", No Output           |kde-plasma pactl awk                        |              Increases or decreases the mic volume and syncs the volume to all alsa, bluetooth, and virtual micmirror to the same volume                 |
# Other-Files
|File in /Other   |Intput / Output                                                 |Requires                                    |Description|
|-----------------|----------------------------------------------------------------|--------------------------------------------|-----------|
|Minimizeall.sh   |No I/O but, Saves minimized.txt to remember minimized windows   |xserver xprop xwininfo xdotool awk          |              Takes no arguments gets the opened windows and minimizes all of them. If all windows are minimized it restores all of them                  |
|.xbindkeysrc     |Thats a config file. So no Inputs and Outputs                   |xbindkeys                                   |              Can be used for nice laptop shortcuts for yoga 9i (also includes https://codeberg.org/marvin1099/xbindkeys-german-keyboard)                 |

# Download
You can get the scripts here:  
https://codeberg.org/marvin1099/LinuxLaptopScrips/releases  
or you get them here:  
https://gihub.com/marvin1099/LinuxLaptopScrips/releases  