# Setup Checklist

- [ ] Quarto installed locally (>= 1.8)
- [ ] `EXTENSION_BUNDLE_TOKEN` secret created (if the extension repo is private)
- [ ] GitHub Pages set to **GitHub Actions**
- [ ] Workflow permissions: `contents: read`, `pages: write`, `id-token: write`
- [ ] Bundle download URL confirmed (`continuous` release or specific version)
- [ ] Docker registry permissions for `ghcr.io` (optional)
- [ ] Kubernetes manifests updated with correct image tag/hostnames (optional)
