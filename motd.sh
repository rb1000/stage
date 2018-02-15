let upSeconds="$(/usr/bin/cut -d. -f1 /proc/uptime)"
let secs=$((${upSeconds}%60))
let mins=$((${upSeconds}/60%60))
let hours=$((${upSeconds}/3600%24))
let days=$((${upSeconds}/86400))
UPTIME=`printf "%d days, %02dh%02dm%02ds" "$days" "$hours" "$mins" "$secs"`

read one five fifteen rest < /proc/loadavg

echo "$(tput setaf 2)
                 `date +"%A, %e %B %Y, %r"`
                 `uname -srmo`
 ____________
| |_/ / |_/ /
|    /| ___ \       
| |\ \| |_/ /
\_| \_\____/
$(tput setaf 4)
HPBICT.nl
$(tput setaf 1)
                  Uptime.............: ${UPTIME}
                  Memory.............: `cat /proc/meminfo | grep MemFree | awk {'print $2'}`kB (Free) / `cat /proc/meminfo | grep MemTotal | awk {'print $2'}`kB (Total)
                  Load Averages......: ${one}, ${five}, ${fifteen} (1, 5, 15 min)
                  Running Processes..: `ps ax | wc -l | tr -d " "`
                  IP Addresses.......: `ip address list | grep "inet " | grep -v 127.0.0 | cut -d " " -f 6 | cut -d "/" -f 1`
                  Weather............: `curl -s "http://rss.accuweather.com/rss/liveweather_rss.asp?metric=1&locCode=EUR|NL|NL007|LEEK" | sed -n '/Currently:/ s/.*: \(.*\): \([0-9]*\)\([CF]\).*/\2°\3, \1/p'`
$(tput setaf 4)
Robin Bartol
$(tput sgr0)"
