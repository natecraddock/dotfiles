function cs -a colorscheme
    if not string length -q $colorscheme
        set colorscheme dawnfox
    end

    echo Setting global colorsheme to $colorscheme
    set -Ux COLORSCHEME $colorscheme

    kitty +kitten themes --reload-in=all $COLORSCHEME
end
