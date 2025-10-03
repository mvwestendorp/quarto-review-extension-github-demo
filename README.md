# Quarto Web Review - Example Repository

This repository demonstrates a complete setup for collaborative document review using the Quarto Web Review extension with Git integration.

## 🚀 Live Demo

Once deployed, your document will be available at:
- **GitHub Pages URL:** `https://your-username.github.io/your-repo-name/my-document.html`

## 📋 Quick Setup (5 minutes)

### Step 1: Fork/Clone This Repository

```bash
# Option 1: Use this as a template on GitHub (recommended)
# Click "Use this template" button on GitHub

# Option 2: Clone locally
git clone <your-repo-url>
cd <your-repo-name>
```

### Step 2: Install the Web Review Extension

```bash
# Copy the extension to your repository
cp -r ../_extensions .
```

### Step 3: Create GitHub OAuth App

1. Go to https://github.com/settings/developers
2. Click **"New OAuth App"**
3. Fill in:
   - **Application name:** `Quarto Web Review - [Your Project]`
   - **Homepage URL:** `https://your-username.github.io/your-repo-name`
   - **Authorization callback URL:** `https://your-username.github.io/your-repo-name/oauth-callback.html`
4. **Enable Device Flow** (scroll down, check the box)
5. Copy your **Client ID** (looks like `Ov23liciIyUSEqziWxVe`)

### Step 4: Configure Your Document

Edit `my-document.qmd` and update:

```yaml
web-review:
  git:
    client-id: "YOUR_CLIENT_ID_HERE"  # Paste your Client ID
    repository:
      owner: "your-username"           # Your GitHub username
      repo: "your-repo-name"           # This repository name
      branch: "main"
```

### Step 5: Enable GitHub Pages

1. Go to your repository **Settings** → **Pages**
2. Under **Source**, select:
   - Source: **GitHub Actions**
3. Save settings

### Step 6: Push and Deploy

```bash
git add .
git commit -m "Configure web review with OAuth"
git push origin main
```

GitHub Actions will automatically:
- Render your Quarto document
- Deploy to GitHub Pages
- Your site will be live in ~2 minutes!

## 📖 How to Use

### For Reviewers

1. **Visit the live document** at `https://your-username.github.io/your-repo-name/my-document.html`

2. **Review the document:**
   - Select text to add comments
   - Double-click paragraphs to suggest edits
   - Use the toolbar buttons to manage your review

3. **Submit your review:**
   - Click the **GitHub icon** button (Submit to Git)
   - Follow the device authentication flow:
     - Visit `https://github.com/login/device`
     - Enter the code shown
     - Authorize the app
   - Your review will be submitted as a Pull Request!

### For Authors

1. **Receive PR notifications** when reviewers submit changes

2. **Review changes in GitHub:**
   - View the PR with all suggested changes
   - See comments in the PR description
   - Review individual commits (each change is a commit)

3. **Accept/Reject changes:**
   - Merge the PR to accept all changes
   - Or cherry-pick specific commits
   - Or close the PR to reject

4. **Auto-deployment:**
   - Merged changes automatically deploy
   - Updated document is live within minutes

## 🏗️ Repository Structure

```
.
├── my-document.qmd           # Your reviewable document
├── _extensions/              # Web Review extension (copy from main project)
│   └── web-review/
├── .github/
│   └── workflows/
│       └── deploy.yml        # GitHub Actions CI/CD
├── docs/                     # Generated HTML (ignored in git)
└── README.md                 # This file
```

## 🔧 Customization

### Add More Documents

Create additional `.qmd` files:

```yaml
---
title: "Another Document"
format:
  html:
    filters:
      - _extensions/web-review/web-review.lua
web-review:
  enabled: true
  git:
    enabled: true
    client-id: "YOUR_CLIENT_ID"
---
```

Update `.github/workflows/deploy.yml` to render multiple files:

```yaml
- name: Render Quarto documents
  run: |
    quarto render my-document.qmd --output-dir docs
    quarto render another-document.qmd --output-dir docs
```

### Customize Review Settings

In your document's YAML:

```yaml
web-review:
  mode: "review"              # review, author, read-only
  features:
    comments: true
    editing: true
    versioning: true
    diff-view: true
  ui:
    theme: "default"
    sidebar-position: "right"
    diff-style: "side-by-side"
```

### Add Custom Styling

Create `custom.css`:

```css
.review-toolbar {
  background: #your-color;
}
```

Include in YAML:

```yaml
format:
  html:
    css: custom.css
```

## 🔐 Security Notes

### What's Safe to Share

- ✅ **Client ID** - Public, safe to commit to repository
- ✅ **Repository info** - Public repositories only
- ✅ **Device codes** - Temporary, expire after use

### Keep Private

- ❌ **Client Secret** - Never needed for Device Flow, but keep it secret
- ❌ **Access Tokens** - Stored in browser sessionStorage, never committed

### Access Control

- OAuth scopes: `repo` (repository access), `user` (user info)
- Reviewers need write access to submit PRs
- Or: Enable "Allow edits from maintainers" on PRs

## 🐛 Troubleshooting

### "Submit to Git" button not visible

**Solution:** Check that Git integration is enabled in your document's YAML:

```yaml
web-review:
  git:
    enabled: true
    client-id: "YOUR_CLIENT_ID"
```

### Device Flow authentication fails

**Checklist:**
- [ ] Device Flow is enabled in OAuth App settings
- [ ] Client ID is correct in YAML
- [ ] You authorized within 10 minutes
- [ ] Browser allows sessionStorage

### Repository not auto-configured

**Solution:** Add repository info to YAML:

```yaml
web-review:
  git:
    repository:
      owner: "your-username"
      repo: "your-repo-name"
      branch: "main"
```

### GitHub Pages not deploying

**Checklist:**
- [ ] Pages source is set to "GitHub Actions"
- [ ] Workflow has `pages: write` permission
- [ ] Check Actions tab for errors
- [ ] Wait 2-3 minutes for deployment

## 📚 Additional Resources

- **Main Documentation:** See `../GIT-INTEGRATION-SETUP.md`
- **Extension Docs:** See `../README.md`
- **GitHub Actions:** [Quarto Actions](https://github.com/quarto-dev/quarto-actions)
- **OAuth Device Flow:** [GitHub Docs](https://docs.github.com/en/apps/oauth-apps/building-oauth-apps/authorizing-oauth-apps#device-flow)

## 🤝 Contributing

To add features or fix bugs:

1. Create a branch for your changes
2. Make your edits
3. Test locally with `quarto preview`
4. Submit a PR to the main project repository

## 📄 License

Same license as the main Quarto Web Review extension (MIT).

---

**Happy Reviewing! 🎉**

For questions or issues, please open an issue in the main project repository.
