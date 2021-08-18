function select-session
    set -l sessions (command tmux ls)
    if test $status -ne 0
        return 1
    else
        set -l selected (string join \n $sessions | fzf $argv --reverse)
        if test $status -ne 0
            # fzf canceled
            return 1
        else
            # get the name of the selected session and attach
            set selected (echo $selected | cut -d ":" -f1)
            echo $selected
            return 0
        end
    end
end

function tmux -a command -d "a tmux wrapper with superpowers"
    # wrap certain commands to make them easier to use
    switch $command
        # create a new named session
        case n new new-session
            if test -z $argv[2]
                echo "must give session name"
                return
        end
            command tmux new -s $argv[2]

        # select from existing sessions with fzf
        case a attach
            set -l session (select-session -0 -1)
            if test $status -eq 0
                command tmux a -t $session
            end

        case k kill kill-session
            set -l session (select-session -0)
            if test $status -eq 0
                command tmux kill-session -t $session
                echo "killed tmux session \"$session\""
            end

        # fall-through to tmux
        case "*"
            command tmux $argv
    end
end
