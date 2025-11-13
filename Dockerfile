FROM ghcr.io/quarto-dev/quarto:1.8.26 AS build

ARG EXTENSION_BUNDLE_URL="https://github.com/mvwestendorp/quarto-review-extension/releases/download/continuous/quarto-review-extension-0.1.0.zip"

WORKDIR /site

RUN apt-get update \
    && apt-get install -y --no-install-recommends tzdata curl unzip r-base r-cran-rmarkdown r-cran-knitr \
    && ln -fs /usr/share/zoneinfo/Etc/UTC /etc/localtime \
    && dpkg-reconfigure --frontend noninteractive tzdata \
    && rm -rf /var/lib/apt/lists/*

COPY _quarto.yml .
COPY document.qmd document.qmd
COPY debug-example.qmd debug-example.qmd
COPY doc-translation.qmd doc-translation.qmd
COPY styles.css styles.css

RUN curl -sSL "$EXTENSION_BUNDLE_URL" -o extension.zip \
    && rm -rf extension-temp _extensions \
    && unzip extension.zip -d extension-temp \
    && mkdir -p _extensions \
    && cp -R extension-temp/_extensions/review _extensions/ \
    && rm -rf extension-temp extension.zip

RUN quarto render --no-cache

FROM nginx:stable
COPY nginx.conf /etc/nginx/nginx.conf
COPY --from=build /site/_output /usr/share/nginx/html

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD curl -f http://localhost/health || exit 1
    
CMD ["nginx", "-g", "daemon off;"]

