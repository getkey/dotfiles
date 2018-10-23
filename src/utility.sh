bold=$(tput bold)
reset=$(tput sgr0)

# terminal colors
red=$(tput setaf 1)
green=$(tput setaf 2)
yellow=$(tput setaf 3)
blue=$(tput setaf 4)

e_success() {
  printf "${green}✔ %s${reset}\n" "$@"
}

e_error() {
  printf "${red}✖ %s${reset}\n" "$@"
}

e_warning() {
  printf "${yellow}${bold}!${reset} ${yellow}%s${reset}\n" "$@"
}

e_prompt() {
	printf "${blue}${bold}?${reset} %s\n" "$@" 
}

