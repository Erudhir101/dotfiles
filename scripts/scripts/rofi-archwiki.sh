#!/usr/bin/env bash
# Variables
_menu_cmd="rofi -dmenu -i -p ArchWiki -theme ~/.config/rofi/theme.rasi"
_opener="xdg-open"
_disown=false
_lang="en" # for future possibilities to have different lang support

check() {
	command -v "$1" >/dev/null 2>&1
}

notify() {
	# shellcheck disable=SC2015
	check notify-send && {
		notify-send "$@"
	} || {
		echo "$@"
	}
}

main() {
	[ -d /usr/share/doc/arch-wiki/html ] || {
		notify "arch-wiki-docs not installed"
		exit 1
	}

	wikidir="/usr/share/doc/arch-wiki/html/${_lang}"
	wikidocs="$(find ${wikidir} -iname "*.html")"

	choice=$(echo "$wikidocs" | sed -e "s|${wikidir}/||g" | sed -e "s|.html||g" | sed 's/_/ /g' | sort -n | eval "$_menu_cmd")
	[ -z "$choice" ] && exit 0
	article=$(printf "%s\n" "${wikidir}/${choice}.html" | sed 's/ /_/g')
	if $_disown; then
		$_opener "$article" &>/dev/null &
	else
		$_opener "$article"
	fi
}

help() {
	cat <<EOF
  This is a bash script for quick archwiki search using arch-wiki-docs package.

  flags:
    -h: Displays This help menu
    -d: Sets disown flag to true. e.g 'archwiki -d'
        This will disown the process after opening the entry.
        Good for using a browser like firefox and chrome. (default is false)
        *(Not recomended for terminal browsers like w3m)
    -m: Sets the menu program. e.g 'archwiki -m "rofi -dmenu -i"'
                                   'archwiki -m "bemenu"'
        This program will be used to display list of wiki entry.
        default is (${_menu_cmd[@]})
    -o: Sets the opener program. e.g 'archwiki -o firefox'
                                   'archwki -o w3m'
        This program will be used to open entry.
        default is (${_opener[@]})
    -l: Sets the lang of wiki pages. e.g 'archwiki -l en'
        default is (${_lang[@]})

    * Note make sure to use -h as last flag to get a preview of your choices in the help menu
EOF
}

getArgs() {
	while [ "$#" -gt 0 ]; do
		case "$1" in
		-h | --help)
			help
			exit 0
			;;
		-d)
			_disown=true
			;;
		-m)
			_menu_cmd=("$2")
			shift
			;;
		-o)
			_opener=("$2")
			shift
			;;
		-l)
			_lang=("$2")
			shift
			;;
		*)
			help
			echo ""
			echo "Wrong argument given"
			exit 1
			;;
		esac
		shift
	done
	main
}

getArgs "$@"
