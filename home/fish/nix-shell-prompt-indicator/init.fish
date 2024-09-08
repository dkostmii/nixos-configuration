function fish_prompt
    set -l nix_shell_info (
        if test -n "$IN_NIX_SHELL"
            echo -n "<nix-shell> "
        end
    )

    set -l git_info (
      if git rev-parse --is-inside-work-tree &>/dev/null
        set branch (git symbolic-ref --short HEAD 2>/dev/null)

        if test -n "$branch"
          set_color magenta
          echo -n "("
          echo -n $branch
          echo -n ") "
          set_color normal
        end
      end
    )

    set -l time_info (
      set_color green
      echo -n "$(date +'%H:%M:%S') "
      set_color normal
    )

    set_color $fish_color_cwd
    echo -n -s "$(prompt_pwd) "
    set_color normal

    echo -n -s "$nix_shell_info" "$git_info" "$time_info" "~> "
end
