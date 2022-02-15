# open a list of directories with zf
function zf-dir
    fd -t d | zf | read -l dir
    commandline -f repaint
    if [ $dir ]
        commandline -i $dir
    end
end
