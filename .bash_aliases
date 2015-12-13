alias aws='docker run -e AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY -e AWS_DEFAULT_REGION=eu-west-1 --rm  xueshanf/awscli aws'
alias apache='docker run -it --rm --name my-apache-app -p 80:80 -v "$PWD":/usr/local/apache2/htdocs/ httpd:2.4'
alias steharbeitsplatz='xrandr --output eDP1 --off --output DP2-1 --auto --output HDMI1 --auto --same-as DP2-1'
alias single_at_work='xrandr --output DP1 --auto --output eDP1 --auto --right-of DP1'
