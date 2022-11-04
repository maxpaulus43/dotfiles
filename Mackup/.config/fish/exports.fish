set -gx XDG_CONFIG_HOME $HOME/.config
set -gx ANDROID_HOME $HOME/Library/Android/sdk
set -gx ANDROID_SDK_ROOT $HOME/Library/Android/sdk/
set -gx BRAZIL_BUILD_HOME ~/.toolbox
set -gx CHTSH_CONF $HOME/.config/cht.sh/cht.sh.conf
set -gx DEFAULT_USER maxpaulu
set -gx FZF_DEFAULT_COMMAND 'rg --files --no-ignore-vcs --hidden'
set -gx FZF_DEFAULT_OPTS '--height 50% --layout=reverse'
set -gx GOPATH $HOME/go
set -gx JAVA_HOME $(/usr/libexec/java_home -v 1.8)
set -gx JAVA_TOOLS_OPTIONS "-Dlog4j2.formatMsgNoLookups=true"
set -gx LESS '-M --mouse --wheel-lines 3'

fish_add_path -p $HOME/.toolbox/bin
fish_add_path -p $HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin
fish_add_path -p $HOME/bin
fish_add_path -p /Users/maxpaulu/.local/bin
fish_add_path -p /Users/maxpaulu/Library/Python/3.7/bin
fish_add_path -p /usr/local/bin
fish_add_path -p /usr/local/opt/protobuf@3.1/bin

fish_add_path -a $ANDROID_HOME/emulator
fish_add_path -a $ANDROID_HOME/tools
fish_add_path -a $ANDROID_HOME/tools/bin
fish_add_path -a $ANDROID_HOME/platform-tools
fish_add_path -a $GOPATH/bin

