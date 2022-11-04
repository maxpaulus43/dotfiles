function fish_add_plugin
  set -l plugin_name $(echo $argv[1] | cut -d "/" -f 2)
  set -l plugin_dir "$__fish_config_dir/plugins/$plugin_name"

  if test ! -d $plugin_dir
    git clone "https://github.com/$argv[1].git" $plugin_dir
  end

  for f in $plugin_dir/functions/*
    source $f
  end
end
