set fish_greeting # Disable greeting

set -l CARGO_BIN_PATH $HOME/.cargo/bin
if test -d $CARGO_BIN_PATH
	set PATH $CARGO_BIN_PATH $PATH
end

begin
	if test -n "$XDG_DATA_HOME"
		set HOME_BIN_PATH $XDG_DATA_HOME/bin
	else
		set HOME_BIN_PATH $HOME/.local/bin
	end

	if test -d $HOME_BIN_PATH
		set PATH $HOME_BIN_PATH $PATH
	end
end

if test (uname) = 'Darwin'
	set gcloud_path_script /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.fish.inc
else
	set gcloud_path_script /opt/google-cloud-sdk/path.fish.inc
end

if test -f $gcloud_path_script
	source $gcloud_path_script
end

set -x VISUAL 'vim'
set -x OLIMEX 'getkey@getkey.eu'

set -x LC_MESSAGES 'en_US.UTF-8' # for CLI programs
# another language can be used for GUI programs by exporting it in ~/.xinitrc, ie export LC_MESSAGES=fr_FR.UTF-8
