[![Deploy to GitHub Pages](https://github.com/mvwestendorp/quarto-review-extension-github-demo/actions/workflows/deploy.yml/badge.svg)](https://github.com/mvwestendorp/quarto-review-extension-github-demo/actions/workflows/deploy.yml)

# Quarto Review Demo (GitHub)

This repository renders the sample Quarto project and deploys it to
GitHub Pages (plus a Docker image for on-prem distribution). The demo loads the latest
Quarto review extension bundle from the `continuous` release of
[mvwestendorp/quarto-review-extension](https://github.com/mvwestendorp/quarto-review-extension).

## Structure

- `_quarto.yml`, `document.qmd`, `debug-example.qmd`, `doc-translation.qmd`, `styles.css`
- `.github/workflows/deploy.yml` – downloads the bundle, renders, publishes Pages & Docker image
- `Dockerfile` – same steps for container builds
- `manifests/` – Kubernetes manifests for publishing the resulting image

## Local Render

```bash
EXTENSION_BUNDLE_URL="https://github.com/mvwestendorp/quarto-review-extension/releases/download/continuous/quarto-review-extension-0.1.0.zip"
curl -L "$EXTENSION_BUNDLE_URL" -o extension.zip
rm -rf extension-temp _extensions
unzip extension.zip -d extension-temp
mkdir -p _extensions
cp -R extension-temp/_extensions/review _extensions/
rm -rf extension-temp extension.zip

quarto render --no-cache
quarto preview
```

## GitHub Pages deployment

Workflow steps:
1. Download bundle from `continuous` release.
2. Extract `_extensions/review` into the repo.
3. Render the site (`quarto render --no-cache`).
4. Upload `_output/` to GitHub Pages.
5. Build and push Docker image `ghcr.io/mvwestendorp/quarto-review-extension-github-demo:main`.

Requirements:
- If the extension repo is private, set `EXTENSION_BUNDLE_TOKEN` with a PAT giving
  `contents:read` access.
- GitHub Pages configured for **GitHub Actions**.

## Docker

```
docker build \
  --build-arg EXTENSION_BUNDLE_URL="https://github.com/mvwestendorp/quarto-review-extension/releases/download/continuous/quarto-review-extension-0.1.0.zip" \
  -t quarto-review-demo:local .

docker run --rm -p 8080:80 quarto-review-demo:local
```

## Kubernetes

Use the manifests in `manifests/`, updating hostnames & image tags as needed.
