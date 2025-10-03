# Quick Start Guide - Git Integration

Get your reviewable document live on GitHub Pages in 5 minutes! ⏱️

## Prerequisites

- GitHub account
- Git installed locally
- Quarto installed (`quarto --version`)

## Step-by-Step Setup

### 1️⃣ Use This Template (1 min)

**On GitHub:**
1. Click **"Use this template"** button (top right)
2. Choose **"Create a new repository"**
3. Name it: `my-review-docs` (or any name)
4. Make it **Public** (required for free GitHub Pages)
5. Click **"Create repository"**

**Or clone manually:**
```bash
git clone https://github.com/your-username/your-repo-name.git
cd your-repo-name
```

### 2️⃣ Create OAuth App (2 min)

1. Go to: https://github.com/settings/developers
2. Click **"New OAuth App"**
3. Fill in:
   ```
   Application name: Quarto Web Review
   Homepage URL: https://your-username.github.io/your-repo-name
   Callback URL: https://your-username.github.io/your-repo-name/oauth-callback.html
   ```
4. Scroll down, check **"Enable Device Flow"**
5. Click **"Register application"**
6. **Copy your Client ID** (looks like `Ov23liciIyUSEqziWxVe`)

### 3️⃣ Copy the Extension (30 sec)

```bash
# From your quarto-web-review project root
cp -r _extensions example-repo/
```

Or if starting fresh:
```bash
# Clone the main project
git clone <web-review-extension-url>

# Copy extension to your repo
cp -r quarto-web-review/_extensions /path/to/your-repo/
```

### 4️⃣ Configure Your Document (1 min)

Edit `my-document.qmd`:

```yaml
web-review:
  git:
    client-id: "Ov23liciIyUSEqziWxVe"  # ← Paste your Client ID here
    repository:
      owner: "your-username"            # ← Your GitHub username
      repo: "your-repo-name"            # ← Your repository name
      branch: "main"
```

**Important:** Replace:
- `Ov23liciIyUSEqziWxVe` → Your actual Client ID
- `your-username` → Your GitHub username
- `your-repo-name` → Your repository name

### 5️⃣ Enable GitHub Pages (30 sec)

1. Go to your repo **Settings** → **Pages**
2. Under **Source**, select: **GitHub Actions**
3. Save

### 6️⃣ Deploy! (30 sec)

```bash
git add .
git commit -m "Setup web review with Git integration"
git push origin main
```

### 7️⃣ Wait & Access (2 min)

1. Go to **Actions** tab in your repo
2. Watch the deployment (takes ~2 minutes)
3. When complete, your document is live at:
   ```
   https://your-username.github.io/your-repo-name/my-document.html
   ```

## 🎉 You're Done!

### Test the Review Workflow

1. **Open your live document** at the GitHub Pages URL
2. **Make some edits:**
   - Select text → Add a comment
   - Double-click paragraph → Edit text
3. **Click the GitHub icon** (Submit to Git button)
4. **Authenticate:**
   - Visit `https://github.com/login/device`
   - Enter the code shown
   - Authorize
5. **See your PR created!** 🚀

## Troubleshooting

### Button not showing?

**Check:**
```yaml
web-review:
  git:
    enabled: true  # ← Must be true
    client-id: "..." # ← Must have a value
```

### Authentication fails?

**Verify:**
- Device Flow is enabled in OAuth App settings
- Client ID is correct
- You authorized within 10 minutes

### Pages not deploying?

**Check:**
- Repository is Public
- GitHub Actions is enabled
- Pages source is "GitHub Actions"
- Check Actions tab for errors

### Repository not auto-configured?

**Solution:** Add to YAML:
```yaml
web-review:
  git:
    repository:
      owner: "your-username"
      repo: "your-repo-name"
      branch: "main"
```

## Next Steps

- **Customize:** Edit `my-document.qmd` with your content
- **Add docs:** Create more `.qmd` files
- **Invite reviewers:** Share your GitHub Pages URL
- **Review PRs:** Check the Pull Requests tab for submissions

## Support

- **Full setup guide:** See `README.md`
- **OAuth details:** See `GIT-INTEGRATION-SETUP.md` in main project
- **Issues:** Open an issue on the main project repo

---

**Happy reviewing! 📝✨**
