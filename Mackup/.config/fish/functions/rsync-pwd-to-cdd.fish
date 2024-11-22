function rsync-pwd-to-cdd
  if test (count $argv) -ne 1
    echo "Error: rsync_to_graviton requires exactly one argument."
    echo "Usage: rsync_to_graviton <destination>"
    return 1
  end

  set -l destination $argv[1]
  rsync-workspace (pwd) $destination (string replace "Users" "home" (pwd))
end

