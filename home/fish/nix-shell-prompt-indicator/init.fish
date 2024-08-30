function fish_prompt
    set -l nix_shell_info (
        if test -n "$IN_NIX_SHELL"
            echo -n "<nix-shell> "
        end
    )

    set_color $fish_color_cwd
    echo -n (prompt_pwd)
    set_color normal
    echo -n -s " $nix_shell_info ~>"
end
