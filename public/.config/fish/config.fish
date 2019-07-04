set fish_greeting # Disable greeting

function addtopath --description 'Attempts to add a directory to the PATH'
	# $argv[1] directory to add

	if test -d $argv[1]
		set PATH $PATH $argv[1]
	end
end

begin
	if test -n "$XDG_DATA_HOME"
		set HOME_BIN_PATH $XDG_DATA_HOME/bin
	else
		set HOME_BIN_PATH $HOME/.local/bin
	end

	addtopath $HOME_BIN_PATH
end

addtopath $HOME/.cargo/bin
addtopath $HOME/.yarn/bin

set -x ANDROID_HOME $HOME/Android/Sdk
addtopath $ANDROID_HOME/tools
addtopath $ANDROID_HOME/tools/bin
addtopath $ANDROID_HOME/platform-tools

set -x GOPATH $HOME/go
addtopath $GOPATH/bin

if test (uname) = 'Darwin'
	set gcloud_path_script /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.fish.inc
else
	set gcloud_path_script /opt/google-cloud-sdk/path.fish.inc
end

if test -f $gcloud_path_script
	source $gcloud_path_script
end

if type -fq direnv
	eval (direnv hook fish)
end

set -x VISUAL 'nvim'
set -x EDITOR 'nvim' # for the morons who think $EDITOR is the same as $VISUAL
set -x OLIMEX 'getkey@getkey.eu'

set -x LC_MESSAGES 'en_US.UTF-8' # for CLI programs
# another language can be used for GUI programs by exporting it in ~/.xinitrc, ie export LC_MESSAGES=fr_FR.UTF-8
