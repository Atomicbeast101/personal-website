#### Download Files from Cloud ####
FROM rclone/rclone AS cloud

# Arguments
ARG RCLONE_CONFIG_CLOUD_TYPE
ARG RCLONE_CONFIG_CLOUD_VENDOR
ARG RCLONE_CONFIG_CLOUD_URL
ARG RCLONE_CONFIG_CLOUD_USER
ARG RCLONE_CONFIG_CLOUD_PASS
ARG CLOUD_PATH_RESUME_FILENAME

# Environment variables
ENV RCLONE_CONFIG_CLOUD_TYPE=${RCLONE_CONFIG_CLOUD_TYPE}
ENV RCLONE_CONFIG_CLOUD_VENDOR=${RCLONE_CONFIG_CLOUD_VENDOR}
ENV RCLONE_CONFIG_CLOUD_URL=${RCLONE_CONFIG_CLOUD_URL}
ENV RCLONE_CONFIG_CLOUD_USER=${RCLONE_CONFIG_CLOUD_USER}
ENV RCLONE_CONFIG_CLOUD_PASS=${RCLONE_CONFIG_CLOUD_PASS}
ENV CLOUD_PATH_RESUME_FILENAME=${CLOUD_PATH_RESUME_FILENAME}

# Dependencies
RUN mkdir -p /tmp/static

# Download files
RUN rclone copy cloud:"/Documents/Job Applications/$CLOUD_PATH_RESUME_FILENAME" /tmp/static/pdf
RUN rclone sync --create-empty-src-dirs cloud:"/Photos/Personal Site Images/" /tmp/static/images/


#### Build Static Files ####
FROM hugomods/hugo:latest AS hugo

# Copy files over
COPY --from=cloud /tmp/static/ /src/
COPY archetypes/ /src
COPY content/ /src
COPY layouts/ /src
COPY resources/ /src
COPY themes/ /src
COPY config.toml /src

# Generate static files
RUN hugo mod init github.com/luizdepra/hugo-coder.git
RUN hugo mod init github.com/holehan/hugo-components-matomo.git
RUN hugo

#### Host Static Files via Nginx ####
FROM nginx
COPY --from=hugo /src/public/. /usr/share/nginx/html
