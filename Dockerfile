# Build image
FROM rclone/rclone

# Arguments
ARG RCLONE_CONFIG_CLOUD_TYPE
ARG RCLONE_CONFIG_CLOUD_VENDOR
ARG RCLONE_CONFIG_CLOUD_URL
ARG RCLONE_CONFIG_CLOUD_USER
ARG RCLONE_CONFIG_CLOUD_PASS
ARG CLOUD_PATH_RESUME_FILENAME

# Environment Variables
ENV RCLONE_CONFIG_CLOUD_TYPE=${RCLONE_CONFIG_CLOUD_TYPE}
ENV RCLONE_CONFIG_CLOUD_VENDOR=${RCLONE_CONFIG_CLOUD_VENDOR}
ENV RCLONE_CONFIG_CLOUD_URL=${RCLONE_CONFIG_CLOUD_URL}
ENV RCLONE_CONFIG_CLOUD_USER=${RCLONE_CONFIG_CLOUD_USER}
ENV RCLONE_CONFIG_CLOUD_PASS=${RCLONE_CONFIG_CLOUD_PASS}
ENV CLOUD_PATH_RESUME_FILENAME=${CLOUD_PATH_RESUME_FILENAME}

# Dependencices
RUN mkdir -p /tmp/static

# Download files
RUN rclone copy cloud:"/Documents/Job Applications/$CLOUD_PATH_RESUME_FILENAME" /tmp/static/pdf
RUN rclone sync --create-empty-src-dirs cloud:"/Photos/Personal Site Images/" /tmp/static/images/

# Run image
FROM hugomods/hugo:nginx

# Copy files over
COPY --from=0 /tmp/static/ /src/
COPY archetypes/ /src
COPY content/ /src
COPY layouts/ /src
COPY resources/ /src
COPY themes/ /src
COPY config.toml /src
