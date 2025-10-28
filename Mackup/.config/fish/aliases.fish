# alias brca="brazil-recursive-cmd --matches '^(?!MShopAndroidPhoneApp).*$' -- 'brazil-build'"

abbr "..." "cd ../.."
abbr "...." "cd ../../.."
abbr "....." "cd ../../../.."
abbr bb "brazil-build"
abbr bbx "brazil-build xcode-env"
abbr brc "brazil-recursive-cmd --all"
abbr brcp "BRAZIL_VERBOSE=true brazil-recursive-cmd-parallel --allPackages"
abbr brcx "brazil-recursive-cmd -- 'brazil-build xcode-env'"
abbr brx "brazil-runtime-exec"
abbr bu "bb -u"
abbr bz "brazil"
abbr cat "bat"
abbr ding "afplay /System/Library/Sounds/Glass.aiff"
abbr gaa 'git add --all'
abbr gc 'git commit -v'
abbr gco 'git checkout'
abbr gd 'git diff'
abbr gdca 'git diff --cached'
abbr gds 'git diff --staged'
abbr gf 'git fetch'
abbr gfa 'git fetch --all --prune --jobs=10'
abbr gfo 'git fetch origin'
abbr glo "git log --pretty='format:%Cblue%h %Cgreen%<(15,trunc)%an %Cred%d %Creset %s'"
abbr grhh 'git reset HEAD --hard'
abbr gst 'git status'
abbr gsta 'git stash push'
abbr gstaa 'git stash apply'
abbr gstp 'git stash pop'
abbr icat "wezterm imgcat"
abbr imgcat "wezterm imgcat"
abbr jtc 'eval "$(pbpaste | jsonToCurl)" | jq | code -'
# abbr la 'eza -1la'
# abbr ls 'eza --icons'
abbr mcp-inspector "npx @modelcontextprotocol/inspector npm start"
abbr nds "ninja-dev-sync"
abbr pbjq "pbpaste | jq"
abbr studio "open -a ~/Applications/JetBrains\ Toolbox/Android\ Studio.app"
abbr sz "source $__fish_config_dir/config.fish"
abbr tree "eza -T"
abbr typora "open -a typora"
abbr vv "nvim ."
abbr vd 'nvim ~/c/dotfiles'
abbr v "nvim"
abbr vf "nvim (fzf)"
abbr vn 'nvim ~/c/dotfiles/Mackup/.config/nvim/init.lua'
abbr vs 'brazil ws show --format "json" | jq .version_set.name -r | pbcopy && pbpaste'
abbr vz "nvim $__fish_config_dir/config.fish"
abbr cfg 'kitty +kitten config.py | less'
abbr watch-cwd 'fswatch -o . | xargs -n1 -I {} osascript -l JavaScript -e "Application(\"chrome\").windows[0].tabs.whose({url: {_contains: \'$(pwd)\'}})[0].reload()"'
abbr scr 'scrcpy 1>/dev/null & && disown $last_pid'
abbr dow 'date -j -f "%Y-%m-%d" +"%A"'
abbr vgf 'git diff --name-only HEAD | xargs nvim' # vim git files
abbr oll 'ollama run llama3.1:8b'

abbr keycode_menu 'adb shell input keyevent "KEYCODE_MENU"'
abbr home 'mshop-debug -i navigate "com.amazon.mobile.shopping://www.amazon.com"'
abbr live 'ssnap-launch -f immersivevisualexperience-modal -p \'{"placementId": "shopping-videos-home", "broadcastId": "2547231c-3c93-48cc-bec9-15e86c6fc062"}\' -s local -riL'
abbr inspire 'ssnap-launch -f immersivevisualexperience-nonmodal -l inspire_tab -p \'{"placementId": "inspire-feed"}\' -v non-modal -s local -riL'
# abbr vse 'ssnap-launch -f immersivevisualexperience-modal -p \'{"placementId": "shopping-videos-home", "broadcastId": "08841a86ef1b4acc8cfb6a3ef2e1e8c2", "source": "VSE"}\' -s local -riL'
abbr vse 'ssnap-launch -f immersivevisualexperience-modal -p \'{"placementId": "shopping-videos-home", "broadcastId": "0b24b6e6c5da452c821bcfbe3ac8c808", "source": "VSE"}\' -s local -riL'
abbr vse2 'ssnap-launch -f immersivevisualexperience-modal -p \'{"placementId": "shopping-videos-home", "broadcastId": "0e69be87386c4aeb91ea2a8986cce049", "source": "VSE"}\' -s local -riL'
abbr catamaran 'ssnap-launch -f amazon-live-catamaran -p \'{"placementId": "shopping-videos-home", "broadcastId": "ea65fbc8-5b39-43c2-a619-a4befb5249c9"}\' -s prod -riL'
abbr dpmb 'ssnap-launch -f immersivevisualexperience-modal -p \'{"placementId":"dp-media-block","initialSeekTime":"20","ingressMediaId":"0f40c3e27cdf443c8c68552d8c733c04","metadata":"%7B%22mediaUrl%22:%22https://m.media-amazon.com/images/S/vse-vms-transcoding-artifact-us-east-1-prod/bc4deb86-8d9a-4b2c-a815-4400e5bc0cbe/default.jobtemplate.mp4.480.mp4%22,%22slateImageUrl%22:%22https://m.media-amazon.com/images/I/51IOnzQKDRL._SY350_PKmb-play-button-overlay_.jpg%22,%22asin%22:%22B0B1G5M31V%22%7D"}\' -s local -riL'
abbr dpmb2 'ssnap-launch -f immersivevisualexperience-modal -p \'{"placementId":"dp-media-block","initialSeekTime":"20","ingressMediaId":"00065f4aac0242d0881b65f4343bf303","metadata":"%7B%22mediaUrl%22:%22https://m.media-amazon.com/images/S/vse-vms-transcoding-artifact-us-east-1-prod/e2f28b92-dc19-42ce-baf3-4727960f16e3/noresize.jobtemplate.mp4.mp4%22,%22slateImageUrl%22:%22https://m.media-amazon.com/images/I/51IOnzQKDRL._SY350_PKmb-play-button-overlay_.jpg%22,%22asin%22:%22B0B1G5M31V%22%7D"}\' -s local -riL'
abbr fif 'echo "https://m.media-amazon.com/images/S/mbp-ssnap-msa/prod/featureInteg/ios/v7/MBPFeatureIntegrationIOS.json" | pbcopy'

function lg
  set -gx LAZYGIT_NEW_DIR_FILE ~/.lazygit/newdir

  lazygit $argv

  if test -f $LAZYGIT_NEW_DIR_FILE 
    cd (cat $LAZYGIT_NEW_DIR_FILE)
    rm -f $LAZYGIT_NEW_DIR_FILE > /dev/null
  end
end

function mp4Desktop
  for i in ~/Desktop/*.{mov,MOV}
    mp4 $i && rm $i
  end
end
