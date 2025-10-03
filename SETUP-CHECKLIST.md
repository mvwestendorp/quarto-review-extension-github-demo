# Setup Checklist ✅

Use this checklist to ensure everything is configured correctly.

## ☑️ Pre-Setup

- [ ] GitHub account created
- [ ] Git installed and configured
- [ ] Quarto installed (run `quarto --version` to verify)
- [ ] Repository created (template or fresh)

## ☑️ OAuth App Setup

- [ ] Visited https://github.com/settings/developers
- [ ] Created new OAuth App
- [ ] Set Homepage URL to: `https://[username].github.io/[repo-name]`
- [ ] Set Callback URL to: `https://[username].github.io/[repo-name]/oauth-callback.html`
- [ ] **Enabled Device Flow** (important!)
- [ ] Copied Client ID (format: `Ov23...`)

## ☑️ Repository Configuration

- [ ] Extension copied to `_extensions/` folder
- [ ] Document configured with:
  ```yaml
  web-review:
    git:
      enabled: true
      client-id: "YOUR_CLIENT_ID"
      repository:
        owner: "your-username"
        repo: "your-repo-name"
        branch: "main"
  ```
- [ ] Client ID is correct (no quotes issues)
- [ ] Owner is your GitHub username
- [ ] Repo name matches your repository
- [ ] Branch is correct (usually "main")

## ☑️ GitHub Pages Setup

- [ ] Repository is Public (or you have GitHub Pro)
- [ ] Went to Settings → Pages
- [ ] Source is set to **"GitHub Actions"**
- [ ] Settings saved

## ☑️ CI/CD Workflow

- [ ] File `.github/workflows/deploy.yml` exists
- [ ] Workflow has correct structure
- [ ] Permissions are set for Pages deployment
- [ ] Quarto rendering step is present

## ☑️ Deployment

- [ ] Committed all changes
- [ ] Pushed to `main` branch
- [ ] Checked Actions tab for workflow run
- [ ] Workflow completed successfully (green checkmark)
- [ ] Document is accessible at GitHub Pages URL

## ☑️ Testing Review Workflow

- [ ] Opened document at GitHub Pages URL
- [ ] Can see the document content
- [ ] Toolbar is visible (top right)
- [ ] **GitHub icon button is visible** (Submit to Git)
- [ ] Can select text and add comments
- [ ] Can double-click to edit paragraphs
- [ ] Changes show in diff view

## ☑️ Testing Git Integration

- [ ] Clicked "Submit to Git" button
- [ ] OAuth modal appeared with device code
- [ ] Visited `https://github.com/login/device`
- [ ] Entered device code successfully
- [ ] Authorized the application
- [ ] Modal showed success message
- [ ] Repository was auto-detected (or manually selected)
- [ ] Progress modal showed: Branch → Changes → PR
- [ ] Pull Request was created successfully
- [ ] PR contains the changes
- [ ] Comments are in PR description

## ☑️ Verification

- [ ] PR link works and shows changes
- [ ] Each change is a separate commit
- [ ] Branch name follows pattern: `review/username-timestamp`
- [ ] Author can review PR in GitHub
- [ ] Merging PR triggers re-deployment
- [ ] Updated document appears on Pages

## 🚨 Common Issues Checklist

If something doesn't work, check:

### Button Not Showing
- [ ] `git.enabled: true` in YAML
- [ ] `client-id` has a value
- [ ] Page fully loaded
- [ ] Check browser console for errors

### Authentication Fails
- [ ] Device Flow is enabled in OAuth App
- [ ] Client ID is correct (check for typos)
- [ ] Authorized within 10 minutes
- [ ] Browser allows sessionStorage

### Repository Not Found
- [ ] Repository metadata in YAML is correct
- [ ] You have write access to the repository
- [ ] Repository exists and is accessible
- [ ] OAuth app has `repo` scope

### Deployment Issues
- [ ] Repository is Public
- [ ] GitHub Actions is enabled
- [ ] Workflow file is in `.github/workflows/`
- [ ] Workflow has correct permissions
- [ ] Check Actions tab for error details

## 📝 Notes

**Client ID Location:**
- GitHub Settings → Developer settings → OAuth Apps → Your App
- Shows on app details page

**GitHub Pages URL Format:**
```
https://[username].github.io/[repo-name]/[document-name].html
```

**Device Flow URL:**
```
https://github.com/login/device
```

**Workflow Status:**
- Check: Repository → Actions tab
- Should see "Deploy to GitHub Pages" workflow
- Green = success, Red = error, Yellow = running

## ✅ Success Criteria

You know it's working when:
1. ✅ Document loads on GitHub Pages
2. ✅ GitHub button visible in toolbar
3. ✅ Can authenticate with device flow
4. ✅ Can submit changes as PR
5. ✅ PR appears in repository
6. ✅ Merging PR updates the live document

---

**If all checkboxes are checked, you're ready to review! 🎉**

If you're stuck, see `README.md` and `GIT-INTEGRATION-SETUP.md` for detailed help.
