function zf-file
    fd -t f | zf | read -l file
    commandline -f repaint
    if [ $file ]
        commandline -i $file
    end
end
