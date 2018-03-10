function e -d "explore"
    if test (count $argv) -gt 1
        printf "%s\n" (_ "Too many args for e command")
        return 1
    end
    # cd if args supplied
    if test (count $argv) -eq 1
        if test -d $argv
            if test (realpath $argv) != (realpath $PWD)
                cd $argv
            end
        else if test -e $argv
            printf "%s %s\n" $argv (_ "is not a directory")
            return 1
        else
            printf "%s %s\n" $argv (_ "is not found")
            return 1
        end
    end

    # explore
    set ret 0
    set msg
    while true
        # for empty dir
        set list *
        set sel (command ls -lLd . .. $list \
            | fzf --prompt=(prompt_pwd)"> " --nth=9.. --no-clear \
            | awk '{ print substr($0, index($0, $9)) }')
        if test -z "$sel"
            # Press Ctrl-C
            set ret 1
            # finish to brose
            break
        else if test -d "$sel"
            if test "$sel" = '.'
                # finish to explore
                break
            else
                # cd and continue to explore
                cd "$sel"
            end
        else if test -f "$sel"
            # open
            set text (file "$sel" | grep text)
            if test -n "$text"
                eval $EDITOR "\"$sel\""
                set ret $status
            else
                begin
                    open "$sel" ^&1
                    set ret $status
                end | read msg
            end
            # finish to explore
            break
        else
            set msg "$sel can not open"
            set ret 1
            break
        end
    end
    tput rmcup
    tput clear
    test -n $msg; and echo $msg
    return $ret
end

