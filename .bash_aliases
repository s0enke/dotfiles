alias apache='docker run -it --rm --name my-apache-app -p 80:80 -v "$PWD":/usr/local/apache2/htdocs/ httpd:2.4'
alias schm='xrandr --output HDMI-1 --auto --output eDP-1 --right-of HDMI-1'
alias scof='xrandr --output DP-1 --auto --output eDP-1 --below DP-1'
alias steharbeitsplatz='xrandr --output eDP1 --auto --output DP2-1 --auto --output HDMI1 --auto --same-as DP2-1'
alias single_at_work='xrandr --output DP1 --auto --output eDP1 --auto --right-of DP1'
alias sccl="xrandr --output HDMI-1 --auto --output eDP-1 --same-as HDMI-1 --scale-from $1"
alias awsinfo='docker run -it -v ~/.aws:/root/.aws -e AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY -e AWS_SESSION_TOKEN -e AWS_DEFAULT_REGION -e AWS_DEFAULT_PROFILE -e AWS_CONFIG_FILE flomotlik/awsinfo'
