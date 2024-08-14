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
RUN rclone copy cloud:"/Documents/Job Applications/$CLOUD_PATH_RESUME_FILENAME" /downloads/static/pdf
RUN rclone sync --create-empty-src-dirs cloud:"/Photos/Personal Site Images/" /downloads/static/images/

# Run image
FROM hugomods/hugo:base

# Arguments
ARG HUGO_BASEURL
ARG HUGO_TITLE
ARG CLOUD_PATH_RESUME_FILENAME
ARG HUGO_PARAMS_AUTHOR
ARG HUGO_PARAMS_DESCRIPTION
ARG HUGO_PARAMS_KEYWORDS
ARG HUGO_PARAMS_INFO
ARG HUGO_PARAMS_AVATARURL
ARG HUGO_PARAMS_COLORSCHEME
ARG HUGO_PARAMS_UMAMI_ENABLED
ARG HUGO_PARAMS_UMAMI_WEBSITEID
ARG HUGO_PARAMS_UMAMI_JSLOCATION
ARG HUGO_SOCIAL_EMAIL
ARG HUGO_SOCIAL_LINKEDIN
ARG HUGO_SOCIAL_GITHUB

# Environment Variables
ENV HUGO_BASEURL=${HUGO_BASEURL}
ENV HUGO_TITLE=${HUGO_TITLE}
ENV HUGO_PARAMS_AUTHOR=${HUGO_PARAMS_AUTHOR}
ENV HUGO_PARAMS_DESCRIPTION=${HUGO_PARAMS_DESCRIPTION}
ENV HUGO_PARAMS_KEYWORDS=${HUGO_PARAMS_KEYWORDS}
ENV HUGO_PARAMS_INFO=${HUGO_PARAMS_INFO}
ENV HUGO_PARAMS_AVATARURL=${HUGO_PARAMS_AVATARURL}
ENV HUGO_PARAMS_COLORSCHEME=${HUGO_PARAMS_COLORSCHEME}
ENV HUGO_PARAMS_UMAMI_ENABLED=${HUGO_PARAMS_UMAMI_ENABLED}
ENV HUGO_PARAMS_UMAMI_WEBSITEID=${HUGO_PARAMS_UMAMI_WEBSITEID}
ENV HUGO_PARAMS_UMAMI_JSLOCATION=${HUGO_PARAMS_UMAMI_JSLOCATION}
ENV HUGO_SOCIAL_EMAIL=${HUGO_SOCIAL_EMAIL}
ENV HUGO_SOCIAL_LINKEDIN=${HUGO_SOCIAL_LINKEDIN}
ENV HUGO_SOCIAL_GITHUB=${HUGO_SOCIAL_GITHUB}
ENV HUGO_RESUME=${CLOUD_PATH_RESUME_FILENAME}

# Copy files over
COPY --from=0 /tmp/static/ /src/
COPY archetypes/ /src
COPY content/ /src
COPY layouts/ /src
COPY resources/ /src
COPY themes/ /src
COPY config.toml /src
