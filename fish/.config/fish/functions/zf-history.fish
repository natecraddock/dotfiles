function zf-history
    if [ $argv ]
        history $argv | zf | read cmd
    else
        history | zf | read cmd
    end
    commandline -f repaint
    if [ $cmd ]
        commandline $cmd
    end
end
