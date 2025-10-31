# Quick Start

1. **Download the extension bundle**
   ```bash
   EXTENSION_BUNDLE_URL="https://github.com/mvwestendorp/quarto-review-extension/releases/download/continuous/quarto-review-extension-0.1.0.zip"
   curl -L "$EXTENSION_BUNDLE_URL" -o extension.zip
   rm -rf _extensions
   mkdir -p _extensions
   unzip -o extension.zip -d _extensions
   rm extension.zip
   ```

2. **Render the site locally**
   ```bash
   quarto render --no-cache
   quarto preview
   ```

3. **Deploy via GitHub Actions**
   - Push to `main` (ensure Pages is set to **GitHub Actions**).
   - Workflow downloads the bundle, renders, deploys to Pages, and rebuilds the Docker image.

4. **Run the container (optional)**
   ```bash
   docker build -t quarto-review-demo:local .
   docker run --rm -p 8080:80 quarto-review-demo:local
   ```
