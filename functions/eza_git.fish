function eza_git -d "Use exa and its git options if in a git repo"
    if git rev-parse --is-inside-work-tree &>/dev/null
        eza $EZA_STANDARD_OPTIONS {$EZA_LL_OPTIONS} --git $argv
    else
        eza $EZA_STANDARD_OPTIONS {$EZA_LL_OPTIONS} $argv
    end
end
