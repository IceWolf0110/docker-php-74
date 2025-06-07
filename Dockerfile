FROM almalinux:9

# Install PHP 7.4 and web stack via Remi
RUN dnf install -y epel-release && \
    dnf install -y https://rpms.remirepo.net/enterprise/remi-release-9.rpm && \
    dnf module reset php -y && \
    dnf module enable php:remi-7.4 -y && \
    dnf install -y php php-fpm php-mysqlnd nginx sudo procps-ng nano git expect && \
    dnf clean all

# Configure PHP-FPM to use Unix socket
RUN sed -i 's|;listen.owner = nobody|listen.owner = nginx|' /etc/php-fpm.d/www.conf && \
    sed -i 's|;listen.group = nobody|listen.group = nginx|' /etc/php-fpm.d/www.conf && \
    sed -i 's|;listen.mode = 0660|listen.mode = 0660|' /etc/php-fpm.d/www.conf && \
    sed -i 's|^listen.acl_users *=.*|;listen.acl_users = apache,nginx|' /etc/php-fpm.d/www.conf

# Set working directory
WORKDIR /workspace

# Copy project + configuration
COPY . /workspace
RUN git config --global --add safe.directory /workspace
COPY default.conf /etc/nginx/conf.d/default.conf

COPY run.sh /workspace/run.sh
