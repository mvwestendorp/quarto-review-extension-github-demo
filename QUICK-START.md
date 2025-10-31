# Quick Start

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

Push to `main` to let GitHub Actions rebuild Pages and the Docker image.
