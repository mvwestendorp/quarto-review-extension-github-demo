# Quarto Review Demo (GitHub)

This repository hosts the demo site for the Quarto Review extension. It renders the
project located in this folder and publishes the HTML to GitHub Pages (and an
optional Docker image for on‑prem distribution). The extension code itself lives
in [mvwestendorp/quarto-review-extension](https://github.com/mvwestendorp/quarto-review-extension).

## Contents

- `_quarto.yml`, `document.qmd`, `debug-example.qmd`, `doc-translation.qmd`, `styles.css` –
  a Quarto website taken from the extension's `example/` project.
- `.github/workflows/deploy.yml` – downloads the latest extension bundle, renders the
  site, deploys to GitHub Pages, and publishes a container image.
- `Dockerfile` – builds a container image that serves the rendered site via Nginx.
- `manifests/` – Kubernetes manifests for on-prem deployments.

## Rendering locally

1. Fetch the latest extension bundle (replace the release tag or version as needed):

   ```bash
   EXTENSION_BUNDLE_URL="https://github.com/mvwestendorp/quarto-review-extension/releases/download/continuous/quarto-review-extension-0.1.0.zip"
   curl -L "$EXTENSION_BUNDLE_URL" -o extension.zip
   rm -rf _extensions
   mkdir -p _extensions
   unzip -o extension.zip -d _extensions
   rm extension.zip
   ```

2. Render the site:

   ```bash
   quarto render --no-cache
   ```

   Output appears in `_output/`. Use `quarto preview` to run a local server.

## Deploying to GitHub Pages

The `Deploy to GitHub Pages` workflow:

1. Downloads the latest packaged extension bundle from the `continuous` release.
2. Extracts it into `_extensions/`.
3. Runs `quarto render --no-cache` and uploads the `_output/` folder.
4. Deploys to GitHub Pages.
5. Builds and pushes the Docker image `ghcr.io/mvwestendorp/quarto-review-extension-github-demo:main`.

Requirements:
- `EXTENSION_BUNDLE_TOKEN` secret (only if the extension repo is private).
- GitHub Pages set to **GitHub Actions**.

## Docker image

Build locally:

```bash
docker build \
  --build-arg EXTENSION_BUNDLE_URL="https://github.com/mvwestendorp/quarto-review-extension/releases/download/continuous/quarto-review-extension-0.1.0.zip" \
  -t quarto-review-demo:local .
```

Run:

```bash
docker run --rm -p 8080:80 quarto-review-demo:local
```

## Updating to a new extension build

1. Update `EXTENSION_BUNDLE_URL` in the Dockerfile and workflow if the version changes
   (or continue using the `continuous` tag).
2. Repeat the rendering steps above to verify changes locally.
3. Commit the project files and push to `main`. The workflow will redeploy the site
   and rebuild the container image.

## Kubernetes manifests

The files in `manifests/` show how to deploy the container image into a cluster. Update
`quarto-review-deployment.yaml` and the Gateway/HTTPRoute with your actual hostnames and image tags.
