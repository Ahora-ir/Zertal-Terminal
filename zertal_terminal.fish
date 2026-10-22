# ==========================================
# Zertal Terminal
# Copyright (c) Ahora-ir
# ==========================================

function fish_greeting
    set_color cyan
    echo '██████╗'
    echo '╚══███╔╝'
    echo '  ███╔╝ '
    echo ' ███╔╝  '
    echo '███████╗'
    echo '╚══════╝'
    set_color normal
    echo

    set_color white
    echo -n '[+] '
    set_color cyan
    echo -n 'SHELL'
    set_color white
    echo ' : Fish'

    set_color white
    echo -n '[+] '
    set_color cyan
    echo -n 'BATTERY'
    set_color white
    echo ' : '(termux-battery-status 2>/dev/null | grep -o '"percentage":[0-9]*' | cut -d: -f2)'%'

    set_color white
    echo -n '[+] '
    set_color cyan
    echo -n 'MEMORY'
    set_color white
    echo ' : '(free -h 2>/dev/null | awk '/Mem:/ {print $3 "/" $2}')

    set_color white
    echo -n '[+] '
    set_color cyan
    echo -n 'STORAGE'
    set_color white
    echo ' : '(df -h "$HOME" | awk 'NR==2 {print $3 "/" $2}')

    set_color white
    echo -n '[+] '
    set_color cyan
    echo -n 'TELEGRAM'
    set_color white
    echo ' : @iD_Zertal'

    set_color white
    echo -n '[+] '
    set_color cyan
    echo -n 'RUBIKA'
    set_color white
    echo ' : @Ahura_Zertal'

    set_color white
    echo -n '[+] '
    set_color cyan
    echo -n 'GITHUB'
    set_color white
    echo ' : @Ahora-ir'
    set_color normal
    echo
end

function fish_prompt
    set_color white
    echo -n '┌──('
    set_color cyan
    echo -n 'ZERTAL'
    set_color white
    echo -n ')-['

    if test "$PWD" = "$HOME"
        echo -n '~'
    else
        set_color red
        echo -n (basename "$PWD")
        set_color white
    end

    echo ']'
    set_color white
    echo -n '├──['
    echo -n (date '+%H:%M:%S')
    echo ']'
    echo -n '└─> '
    set_color normal
end
