FROM ghcr.io/quarto-dev/quarto:1.8.25 AS build

ARG EXTENSION_BUNDLE_URL="https://github.com/mvwestendorp/quarto-review-extension/releases/download/continuous/quarto-review-extension-0.1.0.zip"

WORKDIR /site

# project files
env DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y curl unzip && rm -rf /var/lib/apt/lists/*

COPY _quarto.yml .
COPY document.qmd document.qmd
COPY debug-example.qmd debug-example.qmd
COPY doc-translation.qmd doc-translation.qmd
COPY styles.css styles.css

RUN curl -sSL "$EXTENSION_BUNDLE_URL" -o extension.zip \
    && mkdir -p _extensions \
    && unzip -o extension.zip -d _extensions \
    && rm extension.zip

RUN quarto render --no-cache

FROM nginx:stable
COPY --from=build /site/_output /usr/share/nginx/html
