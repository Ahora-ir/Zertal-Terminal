#!/data/data/com.termux/files/usr/bin/bash
# ============================================================
# ZERTAL TERMINAL - PRIVATE SOURCE
# OWNER: ZERTAL
# DEVELOPER: AHORA-IR
# Unauthorized redistribution is prohibited.
# ============================================================

set -u

PREFIX="${PREFIX:-/data/data/com.termux/files/usr}"
FISH="$PREFIX/bin/fish"
CONFIG_DIR="$HOME/.config/fish"
CONFIG_FILE="$CONFIG_DIR/zertal_terminal.fish"

if [ ! -x "$FISH" ]; then
    printf 'Fish is not installed. Run the prerequisite setup first.\n'
    exit 1
fi

mkdir -p "$CONFIG_DIR"

cat > "$CONFIG_FILE" <<'FISHCONF'
# ZERTAL TERMINAL - Private configuration
# Owner: Zertal | Developer: Ahora-ir

function fish_greeting
    set -l cyan (set_color cyan)
    set -l white (set_color white)
    set -l normal (set_color normal)

    # Original approved Z logo - keep unchanged
    set -l logo \
        '██████╗' \
        '╚══███╔╝' \
        '  ███╔╝ ' \
        ' ███╔╝  ' \
        '███████╗' \
        '╚══════╝'

    # Device information
    set -l android (getprop ro.build.version.release 2>/dev/null)
    set -l model (getprop ro.product.model 2>/dev/null)
    set -l arch (uname -m)
    set -l kernel (uname -r)
    set -l shell_version (fish --version | string replace 'fish, version ' '')

    test -n "$android"; or set android Unknown
    test -n "$model"; or set model Unknown

    set -l details \
        'ZERTAL TERMINAL' \
        '──────────────────────────' \
        "OS      : Android $android" \
        "DEVICE  : $model" \
        "ARCH    : $arch" \
        "KERNEL  : $kernel"

    printf '\n'
    for i in (seq 1 6)
        set_color cyan
        printf '  %-10s' "$logo[$i]"
        set_color normal

        if test $i -le (count $details)
            if test $i -eq 1
                set_color cyan
            else if test $i -eq 2
                set_color white
            else
                set_color cyan
            end
            printf '    %s' "$details[$i]"
        end

        set_color normal
        printf '\n'
    end

    printf '\n'

    # Battery percentage (N/A if Termux:API is unavailable)
    set -l battery 'N/A'
    if type -q termux-battery-status
        set -l battery_json (termux-battery-status 2>/dev/null)
        set -l battery_value (string match -r '"percentage"\s*:\s*[0-9]+' -- "$battery_json" | string replace -r '.*:\s*' '')
        if test -n "$battery_value"
            set battery "$battery_value%"
        end
    end

    # Memory information
    set -l mem_total 'N/A'
    set -l mem_used 'N/A'

    if test -r /proc/meminfo
        set -l total_kb (awk '/MemTotal:/ {print $2}' /proc/meminfo)
        set -l avail_kb (awk '/MemAvailable:/ {print $2}' /proc/meminfo)

        if test -n "$total_kb"; and test -n "$avail_kb"
            set mem_total (awk -v n="$total_kb" 'BEGIN {printf "%.1f", n/1048576}')
            set mem_used (awk -v t="$total_kb" -v a="$avail_kb" 'BEGIN {printf "%.1f", (t-a)/1048576}')
        end
    end

    # Storage information
    set -l storage_used (df -h "$HOME" | awk 'NR==2 {print $3}')
    set -l storage_total (df -h "$HOME" | awk 'NR==2 {print $2}')
    test -n "$storage_used"; or set storage_used N/A
    test -n "$storage_total"; or set storage_total N/A

    # Info line colors: white brackets and labels, cyan plus and values
    function zertal_info_line --argument-names label value
        set_color white
        printf '['
        set_color cyan
        printf '+'
        set_color white
        printf '] %-10s : ' "$label"
        set_color cyan
        printf '%s\n' "$value"
        set_color normal
    end

    zertal_info_line SHELL "Fish $shell_version"
    zertal_info_line BATTERY "$battery"
    zertal_info_line MEMORY "$mem_used/$mem_total GiB"
    zertal_info_line STORAGE "$storage_used/$storage_total"
    zertal_info_line TELEGRAM '@iD_Zertal'
    zertal_info_line RUBIKA '@Ahura_Zertal'
    zertal_info_line GITHUB '@Ahora-ir'

    printf '\n'
end

# Original Zertal prompt
function fish_prompt
    set -l now (date '+%H:%M:%S')
    set -l here (prompt_pwd)

    set_color white
    printf '┌──('
    set_color cyan
    printf 'ZERTAL'
    set_color white
    printf ')-['

    if test "$here" = '~'
        set_color white
    else
        set_color red
    end

    printf '%s' "$here"
    set_color white
    printf ']\n├──['
    set_color cyan
    printf '%s' "$now"
    set_color white
    printf ']\n└─>'
    set_color normal
    printf ' '
end
FISHCONF

# Hide the standard Termux welcome message where supported.
touch "$HOME/.hushlogin"

# Start Fish with the Zertal configuration.
exec "$FISH" --init-command "source '$CONFIG_FILE'"
