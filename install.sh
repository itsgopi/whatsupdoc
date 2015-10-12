sudo apt-get update
sudo apt-get upgrade
sudo apt-get install nginx
sudo apt-get install mysql-server
sudo apt-get install php5 php5-cli php5-fpm php5-gd libssh2-php  php5-mcrypt php5-mysql git unzip zip php5-curl php5-json libssh2-php -y
sudo mkdir -p /var/www/html
sudo rsync -avP mywordpress/ /var/www/html/
sudo mkdir -p /var/www/html/wp-content/uploads
sudo chown -R ubuntu:www-data /var/www/html/*
sudo cp wordpress /etc/nginx/sites-available/
sudo rm /etc/nginx/sites-enabled/default
sudo ln -s /etc/nginx/sites-available/wordpress /etc/nginx/sites-enabled/
sudo cp nginx.conf /etc/nginx/nginx.conf
sudo cp php.ini /etc/php5/fpm/php.ini
sudo service nginx restart
sudo service php5-fpm restart

