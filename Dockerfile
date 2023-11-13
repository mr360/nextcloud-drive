FROM nextcloud:27.1.3



RUN apt-get update \
    && apt-get -y install imagemagick ffmpeg

WORKDIR /usr/src/nextcloud
RUN chown -R www-data:www-data .
USER www-data

# https://docs.nextcloud.com/server/latest/admin_manual/configuration_server/occ_command.html
RUN ./occ maintenance:install --database "sqlite" --admin-user admin --admin-pass password --no-interaction
#RUN ./occ user:setting admin files quota 1G"

RUN ./occ app:install richdocumentscode
RUN ./occ app:install files_external
RUN ./occ app:install files_archive
RUN ./occ app:install richdocuments

EXPOSE 80:80/tcp