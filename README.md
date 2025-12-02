# screen-tree

## What It Does
Recursively prints a tree down from the current subdir, marking in green the locations of all of your gnu screen tabs by name

<img width="668" height="860" alt="Screenshot 2025-12-01 214451" src="https://github.com/user-attachments/assets/7a3b1d6a-1484-40dd-ae3c-cc43b61035f0" />

## Usage
1) Put that shit in your path as screen-tree or something sick and cool
2) Call it from within a screen session from whatever directory contains the screen tabs you are concerned about

## Issues 
1) In order to get the cwd for each tab, it sends each tab a command via a 'screen -X stuff' type command, which types the pwd command in that tab and then saves it to a tmp file which the script will read. As a result, all tabs must be outside of programs such as vim, more, man, etc. In other words, the program is typing directly into your screens (including the current one hence the "pwd > tmp/window?.txt" at the top) so if you have vim open it's going to mess up your shit. I'm trying to find ways to do this better, so hang tight homie.
2) House of Cards really fell off after season two I think.

