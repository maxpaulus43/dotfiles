function creds
  if count $argv > /dev/null
    echo "ada credentials update --account=\"$argv[1]\" --provider=conduit --role=IibsAdminAccess-DO-NOT-DELETE --once"
    set -l accountId $argv[1]
    ada credentials update --account="$accountId" --provider=conduit --role=IibsAdminAccess-DO-NOT-DELETE --once
  else
    echo "Missing argument: accountId"
    echo "usage: creds <accountId>"
  end
end

