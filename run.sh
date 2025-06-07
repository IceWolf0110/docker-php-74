if [ ! -d /run/php-fpm ]; then
    mkdir -p /run/php-fpm
fi
pkill php-fpm
pkill nginx
if ! grep -q "^139\.177\.191\.117[[:space:]]\+apinew\.xsradar\.com" /etc/hosts; then
    echo "139.177.191.117 apinew.xsradar.com" | sudo tee -a /etc/hosts
fi
php-fpm -D
nginx
