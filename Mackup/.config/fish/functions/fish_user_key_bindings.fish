function fish_user_key_bindings
  fzf_key_bindings
  fish_vi_key_bindings

  # maps jk to do the same thing as "escape" 
  bind -s --user -M insert jk "if commandline -P; commandline -f cancel; else; set fish_bind_mode default; commandline -f backward-char repaint-mode; end"
end
