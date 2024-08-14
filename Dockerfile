# Arguments
ARG CLOUD_URL
ARG CLOUD_USERNAME
ARG CLOUD_PASSWORD

# Build image
FROM ubuntu

# Install dependencies
RUN apt-get update && apt-get install rclone -y

# Create required directories
RUN mkdir -p /tmp/static
RUN mkdir -p /tmp/static/pdf
RUN mkdir -p /tmp/static/images
RUN mkdir -p /root/.config/rclone/

# Create rclone config
RUN echo "[PrivateCloud]" >> /root/.config/rclone/rclone.conf
RUN echo "type = webdav" >> /root/.config/rclone/rclone.conf
RUN echo "url = $CLOUD_URL" >> /root/.config/rclone/rclone.conf
RUN echo "vendor = nextcloud" >> /root/.config/rclone/rclone.conf
RUN echo "user = $CLOUD_USERNAME" >> /root/.config/rclone/rclone.conf
RUN echo "pass = REPLACED_BY_NEXT_CMD" >> /root/.config/rclone/rclone.conf
RUN rclone config password PrivateCloud pass $CLOUD_PASSWORD

# Download stuff from NextCloud
RUN rclone copy PrivateCloud:"/Documents/Job Applications/$CLOUD_PATH_RESUME_FILENAME" "/tmp/static/pdf"
RUN rclone sync --create-empty-src-dirs PrivateCloud:"/Photos/Personal Site Images/" "/tmp/static/images/"

# Run image
FROM hugomods/hugo:base

# Copy files over
COPY --from=0 /tmp/static/ /src/
COPY archetypes/ /src
COPY content/ /src
COPY layouts/ /src
COPY resources/ /src
COPY themes/ /src
COPY config.toml /src

# Environment Variables
ARG HUGO_BASEURL
ARG HUGO_TITLE
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
ENV HUGO_RESUME=${$CLOUD_PATH_RESUME_FILENAME}
