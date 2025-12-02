#!/bin/bash

names=($(screen -Q windows | grep -o '[a-zA-Z]*' | cut -d '$' -f 1))
dirs=()

#gather cwd for each window into tmp files
for ((i=0; i<${#names[@]}; i++)); do
	screen -S $STY -p $i -X stuff "pwd > /tmp/window${i}.txt\n"
done

#read tmp files and put into an array with
#indices matching the numbers of the windows
for ((i=0; i<${#names[@]}; i++)); do
	cwd=$(cat "/tmp/window${i}.txt")
	dirs+=($cwd)
done

#cleanup the tmp files
for ((i=0; i<${#names[@]}; i++)); do
	(rm "/tmp/window${i}.txt")
done

#vars for recusive printing of the tree
ROOT="$(pwd)" #starts from directory it is run from
HIGHLIGHT="\033[1;92m"
RESET="\033[0m"

#recursively print the tree
print_tree() {
	local dir="$1"
	local prefix="$2"

	# mark windows in this directory
	for i in "${!dirs[@]}"; do
	    if [[ "${dirs[i]}" == "$dir" ]]; then
	          echo -e "${prefix}├── [${HIGHLIGHT}${names[i]}${RESET}]"
	    fi
	done

	# list subdirectories
	local subdirs=("$dir"/*/)
	for subdir in "${subdirs[@]}"; do
	    [[ -d "$subdir" ]] || continue
	    subdir=${subdir%/}  # remove trailing slash
	    echo "${prefix}├── $(basename "$subdir")"
	    print_tree "$subdir" "$prefix│   "
	done
}

#print the root then call the recursive function
echo "$ROOT"
print_tree "$ROOT" ""

