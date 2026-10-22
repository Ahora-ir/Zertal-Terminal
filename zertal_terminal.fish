# ==========================================
# Zertal Terminal
# Proprietary project by Ahora-ir
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
    set_color cyan
    echo '[+] SHELL : Fish'
    echo '[+] TELEGRAM : @iD_Zertal'
    echo '[+] RUBIKA : @Ahura_Zertal'
    echo '[+] GITHUB : @Ahora-ir'
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
    set_color white
    echo -n (date '+%H:%M:%S')
    echo ']'
    set_color white
    echo -n '└─> '
end
