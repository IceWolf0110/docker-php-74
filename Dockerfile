FROM almalinux:9

# Install dependencies and Remi repository for PHP 7.4
RUN dnf -y install epel-release && \
    dnf -y install https://rpms.remirepo.net/enterprise/remi-release-9.rpm && \
    dnf -y module reset php && \
    dnf -y module enable php:remi-7.4 && \
    dnf -y install php php-mysqlnd php-mbstring php-xml php-opcache git nano sudo && \
    dnf clean all

# Create user 'son' with sudo privileges
RUN useradd -m -s /bin/bash son && \
    echo "son ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/son && \
    chmod 0440 /etc/sudoers.d/son

# Set working directory
WORKDIR /home/son/workspace

# Copy the project folder (context is the parent directory)
COPY . .

# Copy and make the startup script executable
COPY start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh

# Set permissions
RUN chown -R son:son /home/son/workspace && \
    chmod -R 755 /home/son/workspace

# Expose port 80
EXPOSE 80

# Use JSON array syntax for CMD
CMD ["/usr/local/bin/start.sh"]
