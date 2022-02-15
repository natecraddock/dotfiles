# Gruvbox Color Palette
# Style: dark
# Nathan Craddock
set -l foreground 383838
set -l selection e5e5e5
set -l comment 787878
set -l red 82251f
set -l orange 9b6422
set -l yellow d1aa1d
set -l blue 2a417c
set -l green 3a5e24
set -l purple 5f2f70
set -l cyan 186a70

# Syntax Highlighting Colors
set -g fish_color_normal $foreground
set -g fish_color_command --bold $cyan
set -g fish_color_keyword --bold $foreground
set -g fish_color_quote $comment
set -g fish_color_redirection $foreground
set -g fish_color_end $orange
set -g fish_color_error $red
set -g fish_color_param $foreground
set -g fish_color_comment $comment
set -g fish_color_selection --background=$selection
set -g fish_color_search_match --background=$selection
set -g fish_color_operator $foreground
set -g fish_color_escape $yellow
set -g fish_color_autosuggestion $comment

# Completion Pager Colors
set -g fish_pager_color_progress $comment
set -g fish_pager_color_prefix --bold $cyan
set -g fish_pager_color_completion $foreground
set -g fish_pager_color_description $comment
