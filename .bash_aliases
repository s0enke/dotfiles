alias apache='docker run -it --rm --name my-apache-app -p 80:80 -v "$PWD":/usr/local/apache2/htdocs/ httpd:2.4'
alias schm='xrandr --output HDMI1 --auto --output eDP1 --right-of HDMI1'
alias steharbeitsplatz='xrandr --output eDP1 --off --output DP2-1 --auto --output HDMI1 --auto --same-as DP2-1'
alias single_at_work='xrandr --output DP1 --auto --output eDP1 --auto --right-of DP1'
