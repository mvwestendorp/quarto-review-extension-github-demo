FROM ghcr.io/quarto-dev/quarto:1.8.25 AS build

WORKDIR /app
COPY my-document.qmd my-document.qmd
COPY _extensions _extensions
RUN quarto render my-document.qmd --output index.html

FROM nginx:stable

COPY --from=build /app /usr/share/nginx/html