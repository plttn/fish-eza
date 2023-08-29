function __fish_eza_install --on-event fish-eza_install
    set -Ux __FISH_EZA_BASE_ALIASES l ll lg le lt lc lo
    set -Ux __FISH_EZA_EXPANDED a d i id aa ad ai aid aad aai aaid
    set -Ux __FISH_EZA_EXPANDED_OPT_NAME LA LD LI LID LAA LAD LAI LAID LAAD LAAI LAAID
    set -Ux __FISH_EZA_OPT_NAMES
    set -Ux __FISH_EZA_ALIASES
    set -Ux __FISH_EZA_SORT_OPTIONS name .name size ext mod old acc cr inode

    set -Ux EZA_STANDARD_OPTIONS "--group" "--header" "--group-directories-first"

    # Base aliases
    set -Ux EZA_L_OPTIONS
    set -Ux EZA_LL_OPTIONS "--long"
    set -Ux EZA_LG_OPTIONS "--git" "--git-ignore" "--long"
    set -Ux EZA_LE_OPTIONS "--extended" "--long"
    set -Ux EZA_LT_OPTIONS "--tree" "--level"
    set -Ux EZA_LC_OPTIONS "--across"
    set -Ux EZA_LO_OPTIONS "--oneline"

    # Extended aliases
    set -Ux EZA_LI_OPTIONS "--icons"
    set -Ux EZA_LD_OPTIONS "--only-dirs"
    set -Ux EZA_LID_OPTIONS "--icons" "--only-dirs"
    set -Ux EZA_LA_OPTIONS "--all" "--binary"
    set -Ux EZA_LAD_OPTIONS "--all" "--binary" "--only-dirs"
    set -Ux EZA_LAI_OPTIONS  "--all" "--binary" "--icons"
    set -Ux EZA_LAID_OPTIONS  "--all" "--binary" "--icons" "--only-dirs"
    set -Ux EZA_LAA_OPTIONS "--all" "--all" "--binary"
    set -Ux EZA_LAAD_OPTIONS "--all" "--all" "--binary" "--only-dirs"
    set -Ux EZA_LAAI_OPTIONS  "--all" "--all" "--binary" "--icons"
    set -Ux EZA_LAAID_OPTIONS  "--all" "--all" "--binary" "--icons" "--only-dirs"

    for a in $__FISH_EZA_BASE_ALIASES
        set -l opt_name (string join '_' "EZA" (string upper $a) "OPTIONS")
        if test $a = "ll"
            alias --save "$a" "eza_git"
        else
            alias --save "$a" "eza \$EZA_STANDARD_OPTIONS \$$opt_name"
        end
        set -a __FISH_EZA_OPT_NAMES "$opt_name"
        set -a __FISH_EZA_ALIASES "$a"

        for i in (seq (count $__FISH_EZA_EXPANDED))
            set -l name "$a$__FISH_EZA_EXPANDED[$i]"
            # --tree is useless given --all --all
            if test $name = "ltaa"; or test $name = "ltaac"
                continue
            end
            set -l exp_opt_name (string join '_' "EZA" $__FISH_EZA_EXPANDED_OPT_NAME[$i] "OPTIONS")
            if string match --quiet 'll*' "$name"
                alias --save "$name" "eza_git \$$exp_opt_name"
            else
                alias --save "$name" "eza \$EZA_STANDARD_OPTIONS \$$exp_opt_name \$$opt_name"
            end
            set -a __FISH_EZA_ALIASES "$name"

            if not contains $exp_opt_name $__FISH_EZA_OPT_NAMES
                set -a __FISH_EZA_OPT_NAMES $exp_opt_name
            end
        end
    end
end

function __fish_eza_update --on-event fish-eza_update
    __fish_eza_uninstall
    __fish_eza_install
end

function __fish_eza_uninstall --on-event fish-eza_uninstall
    set --erase EZA_STANDARD_OPTIONS

    for a in $__FISH_EZA_ALIASES
        functions --erase $a
        funcsave $a
    end

    for opt in $__FISH_EZA_OPT_NAMES
        set --erase $opt
    end

    set --erase __FISH_EZA_BASE_ALIASES
    set --erase __FISH_EZA_ALIASES
    set --erase __FISH_EZA_EXPANDED
    set --erase __FISH_EZA_EXPANDED_OPT_NAME
    set --erase __FISH_EZA_OPT_NAMES
    set --erase __FISH_EZA_SORT_OPTIONS
end
