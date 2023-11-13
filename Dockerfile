FROM nextcloud:27.1.3



RUN apt-get update \
    && apt-get -y install imagemagick ffmpeg

WORKDIR /usr/src/nextcloud
RUN chown -R www-data:www-data .
USER www-data

RUN ./occ maintenance:install --admin-user admin --admin-pass password --admin-email admin@example.com
RUN OC_PASS=passworddoesntmatter ./occ user:add --password-from-env --display-name="Test" test
RUN su www-data -c "php /var/www/html/occ user:setting user2 files quota 1G"

RUN ./occ app:install richdocumentscode
RUN ./occ app:install files_external
RUN ./occ app:install files_archive
RUN ./occ app:install richdocuments

EXPOSE 80:80/tcp