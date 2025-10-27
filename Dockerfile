# Copy composer files
COPY composer.json /var/www/html/
# (Skip composer.lock if you don’t have it)
# Install dependencies
RUN apt-get update && apt-get install -y git unzip \
    && php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php --install-dir=/usr/local/bin --filename=composer \
    && composer install

# Use an official PHP image with Apache
FROM php:8.3-apache

# Enable necessary Apache modules
RUN docker-php-ext-install pdo pdo_mysql

# Copy your app into the container
COPY . /var/www/html/

# Set the working directory
WORKDIR /var/www/html/

# Expose port 80 for web traffic
EXPOSE 80

# Start the Apache server
CMD ["apache2-foreground"]
