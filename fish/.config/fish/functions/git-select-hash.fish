function git-select-hash
    git log --format=reference $argv | zf | cut -f1 -d" "
end
