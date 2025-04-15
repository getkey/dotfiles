set fish_greeting # Disable greeting

begin
	if test -n "$XDG_DATA_HOME"
		set HOME_BIN_PATH $XDG_DATA_HOME/bin
	else
		set HOME_BIN_PATH $HOME/.local/bin
	end

	fish_add_path -a $HOME_BIN_PATH
end

fish_add_path -a $HOME/.cargo/bin

if type -fq yarn
	# this is important because with nvm it might not always be $HOME/.yarn/bin
	fish_add_path -a (yarn global bin)
end

if test (uname) = 'Darwin'
	set tentative_android_home /Users/$USER/Library/Android/sdk
else
	set tentative_android_home $HOME/Android/Sdk
end

if test -d $tentative_android_home
	set -x ANDROID_HOME $tentative_android_home
	fish_add_path -a $ANDROID_HOME/platform-tools
	fish_add_path -a $ANDROID_HOME/cmdline-tools/latest/bin
end

set -x GOPATH $HOME/go
fish_add_path -a $GOPATH/bin

# Dart
fish_add_path -a $HOME/.pub-cache/bin

if test (uname) = 'Darwin'
	set gcloud_path_script (brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.fish.inc
else
	set gcloud_path_script /opt/google-cloud-sdk/path.fish.inc
end

if test -f $gcloud_path_script
	source $gcloud_path_script
end

# on NixOS, this is configured through home-manger
if test (uname) = 'Darwin'; and type -fq direnv
	eval (direnv hook fish)
end

# https://nix-community.github.io/home-manager/index.html#_why_are_the_session_variables_not_set
set session_vars $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh
if test -f $session_vars
	tail -n +5 $session_vars | source
end

set -x VISUAL 'nvim'
set -x EDITOR 'nvim' # for the morons who think $EDITOR is the same as $VISUAL

set -x LC_MESSAGES 'en_US.UTF-8' # for CLI programs
# another language can be used for GUI programs by exporting it in ~/.xinitrc, ie export LC_MESSAGES=fr_FR.UTF-8
