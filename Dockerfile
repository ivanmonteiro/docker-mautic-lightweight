FROM mautic/mautic:v3-fpm

# Use our custom crontab. This greatly reduces memory usage. 
# The default crontab of mautic-docker runs up to 6 tasks at the same time
# and uses up to 6 times more memory.
COPY mautic.crontab /etc/cron.d/mautic
RUN chmod 644 /etc/cron.d/mautic

COPY php-fpm/www2-override-mautic-fpm.conf /usr/local/etc/php-fpm.d/www2-override.conf