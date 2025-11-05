# GitHub Integration Testing Guide

This guide will help you test the GitHub pull request integration for the Quarto Review extension.

## Overview

The Quarto Review extension has **full GitHub integration** already implemented. When configured, it allows reviewers to submit their changes directly as GitHub pull requests from the browser.

## What's Already Implemented ✅

The code includes:

1. **GitHub API Provider** (`src/modules/git/providers/github.ts`)
   - Branch creation
   - File updates
   - Pull request creation and updates
   - Review comments
   - Full authentication support (PAT, cookies, headers)

2. **Git Integration Service** (`src/modules/git/integration.ts`)
   - Complete workflow orchestration
   - Branch naming with conflict resolution
   - Multi-file support
   - PR creation/updates with reuse logic
   - Error handling and fallback storage

3. **UI Integration** (`src/modules/ui/index.ts`)
   - Submit Review button in sidebar
   - Review submission modal
   - Progress notifications
   - Error handling

## Prerequisites

1. **GitHub Repository**
   - You'll need a test repository on GitHub
   - The `github-demo` folder is already set up for this purpose

2. **GitHub Personal Access Token (PAT)**
   - Go to https://github.com/settings/tokens
   - Click "Generate new token (classic)"
   - Give it a name like "Quarto Review Test"
   - Select scopes:
     - ✅ `repo` (Full control of private repositories)
     - ✅ `workflow` (if you want to update GitHub Actions)
   - Click "Generate token"
   - **Copy the token** - you'll need it in the next steps

3. **Local Setup**
   - Node.js installed
   - Quarto installed (>= 1.8)
   - This repository cloned locally

## Step-by-Step Testing Guide

### Step 1: Configure the Demo Repository

Edit `github-demo/_quarto.yml` to add the git configuration:

```yaml
project:
  type: website
  output-dir: _output

website:
  title: 'Quarto Review Example'
  navbar:
    left:
      - text: 'Home'
        file: document.qmd
      - text: 'Debug'
        file: debug-example.qmd
      - text: 'Translation'
        file: doc-translation.qmd

format:
  html:
    theme: cosmo
    css: styles.css
    toc: true

review:
  enabled: true
  debug:
    enabled: true
    level: debug
    modules:
      - UIModule
      - ChangesModule
      - GitModule
  git:
    provider: github
    owner: <YOUR_GITHUB_USERNAME>      # ← Change this
    repo: <YOUR_TEST_REPO_NAME>        # ← Change this
    base-branch: main
    auth:
      mode: pat
      # Don't put token here - you'll enter it in the UI

filters:
  - review
```

**Important**: Replace `<YOUR_GITHUB_USERNAME>` and `<YOUR_TEST_REPO_NAME>` with your actual values.

### Step 2: Build the Extension

From the project root:

```bash
npm run build
```

This will:
- Compile TypeScript
- Bundle the JavaScript
- Copy assets to `_extensions/review/`
- Install to the `example/` and `github-demo/` directories

### Step 3: Render the Demo

```bash
cd github-demo
quarto render --no-cache
```

### Step 4: Preview Locally

```bash
quarto preview
```

This will open the site in your browser at `http://localhost:XXXX`.

### Step 5: Test the Review Workflow

1. **Make Some Edits**
   - Double-click any paragraph to open the editor
   - Make some changes
   - Click "Save"
   - The sidebar should show "Unsaved Changes"

2. **Add a Comment**
   - Select some text
   - Right-click and choose "Add Comment"
   - Enter a comment
   - Click "Add Comment"

3. **Open the Submit Review Dialog**
   - Click the "Submit Review" button in the left sidebar
   - You should see a dialog with:
     - Reviewer name (auto-filled from your user info)
     - Branch name (auto-generated)
     - Base branch (from config)
     - Commit message (auto-generated)
     - Pull request title (auto-generated)
     - Pull request body (auto-generated)
     - Draft checkbox
     - PAT token field (if you didn't configure it in _quarto.yml)

4. **Enter Your GitHub Token**
   - Paste your Personal Access Token
   - The token is stored in memory only (not persisted)

5. **Submit the Review**
   - Click "Submit"
   - You should see a progress indicator
   - On success, you'll see:
     - "Review submitted: <PR URL>"
     - A link to the created pull request

6. **Verify on GitHub**
   - Click the PR link or go to your repository
   - Navigate to "Pull requests"
   - You should see a new PR with:
     - The title you specified
     - The body you specified
     - Changes to `document.qmd` (or whatever file you edited)
     - The branch name you specified

### Step 6: Test PR Update (Second Submission)

1. **Make More Changes**
   - Edit the document again
   - Add more comments

2. **Submit Again**
   - Click "Submit Review" again
   - The system will automatically:
     - Reuse the existing branch
     - Update the existing PR (if `updateExisting: true`, which is default)

3. **Verify on GitHub**
   - The same PR should now have updated changes
   - New commits should appear in the PR timeline

## Configuration Options

### Authentication Modes

#### 1. PAT (Personal Access Token) - Prompt in UI

```yaml
review:
  git:
    auth:
      mode: pat
      # Token entered in browser UI (most secure for testing)
```

#### 2. PAT (Personal Access Token) - Environment Variable

```yaml
review:
  git:
    auth:
      mode: pat
      token: ${GITHUB_TOKEN}
```

Then set in your shell:
```bash
export GITHUB_TOKEN="ghp_your_token_here"
quarto preview
```

#### 3. Cookie-based (for SSO environments)

```yaml
review:
  git:
    auth:
      mode: cookie
      cookie-name: github_token
```

#### 4. Custom Header (for proxy environments)

```yaml
review:
  git:
    auth:
      mode: header
      header-name: X-GitHub-Token
```

### Repository Options

```yaml
review:
  git:
    provider: github
    owner: your-username
    repo: your-repo
    base-branch: main              # Default: main
    options:
      apiUrl: https://github.com  # For GitHub Enterprise
```

### Advanced Options

```yaml
review:
  git:
    provider: github
    owner: your-username
    repo: your-repo
    base-branch: main
    source-file: document.qmd      # Path to source file in repo
    auth:
      mode: pat
```

## Testing Checklist

- [ ] **Basic Submission**
  - [ ] Edit document
  - [ ] Submit review
  - [ ] PR created successfully
  - [ ] PR URL displayed
  - [ ] Changes visible on GitHub

- [ ] **PR Updates**
  - [ ] Make additional edits
  - [ ] Submit again
  - [ ] Existing PR updated (not new PR created)

- [ ] **Comments**
  - [ ] Add section comments
  - [ ] Submit review
  - [ ] Comments appear in PR body or as review comments

- [ ] **Error Handling**
  - [ ] Invalid token → Clear error message
  - [ ] No network → Error with fallback storage
  - [ ] Invalid repository → Clear error message

- [ ] **Branch Naming**
  - [ ] Auto-generated branch has correct format
  - [ ] Custom branch name works
  - [ ] Branch name conflicts handled

## Expected Workflow

```
1. User makes edits in browser
   ↓
2. User clicks "Submit Review"
   ↓
3. UI shows submission dialog
   ↓
4. User enters/confirms details + GitHub token
   ↓
5. GitReviewService exports changed files
   ↓
6. GitIntegrationService orchestrates:
   - Create/reuse review branch
   - Commit file changes
   - Create/update pull request
   - Add review comments (if any)
   ↓
7. Success: Show PR URL
   OR
   Failure: Show error + save to fallback storage
```

## Troubleshooting

### "Git integration is not configured"

**Cause**: The `git` section is missing from `_quarto.yml` or has errors.

**Fix**: Ensure your `_quarto.yml` has the complete `review.git` configuration.

### "Current user does not have write access"

**Cause**: Your GitHub token doesn't have permission to push to the repository.

**Fix**:
1. Check that your token has `repo` scope
2. Ensure you have write access to the repository
3. For organization repos, check if SSO authorization is required

### "Source file not found: document.qmd"

**Cause**: The file specified in the configuration doesn't exist in the repository.

**Fix**:
1. Check that `document.qmd` exists in your GitHub repo
2. Or specify the correct `source-file` in the configuration

### "Failed to submit review: Network error"

**Cause**: Can't reach GitHub API.

**Fix**:
1. Check your internet connection
2. Check if GitHub is accessible
3. For Enterprise, verify the `apiUrl` is correct

### Review Fallback Storage

If submission fails, the system saves the payload to local storage:

1. Open browser console
2. Run: `window.reviewDebug?.git?.listEmbeddedSources?.()`
3. This lists all failed submissions
4. You can download and manually submit via git CLI

## Example Test Scenario

Here's a complete example test:

1. **Setup**
   ```bash
   cd github-demo
   # Edit _quarto.yml with your GitHub info
   quarto render --no-cache
   quarto preview
   ```

2. **Make Changes**
   - Open http://localhost:XXXX
   - Double-click the first paragraph
   - Change "Welcome" to "Hello"
   - Click Save

3. **Add Comment**
   - Select some text in the second paragraph
   - Right-click → Add Comment
   - Enter: "Great content!"
   - Click Add Comment

4. **Submit**
   - Click "Submit Review" in sidebar
   - Review the auto-filled information:
     - Reviewer: (your name)
     - Branch: review/yourname-2025-11-04-...
     - Commit: "Review updates from yourname"
     - PR Title: "Review updates from yourname"
   - Paste your GitHub PAT
   - Click Submit

5. **Verify**
   - Click the PR URL in the success message
   - Verify changes in GitHub
   - Check that the branch was created
   - Check that the PR has your changes

## Next Steps After Testing

Once you've verified the GitHub integration works:

1. **Deploy to GitHub Pages**
   - Push this demo to a GitHub repository
   - Enable GitHub Pages in repository settings
   - The demo will auto-deploy on push

2. **Test Other Providers**
   - GitLab: Change `provider: gitlab`
   - Gitea/Forgejo: Change `provider: gitea`
   - Azure DevOps: Change `provider: azure-devops`

3. **Production Setup**
   - Consider using environment variables for tokens
   - Set up SSO/OAuth for team access
   - Configure webhook notifications

## Code References

- **Git Integration**: `src/modules/git/integration.ts:68-104`
- **GitHub Provider**: `src/modules/git/providers/github.ts`
- **Review Service**: `src/modules/git/review-service.ts`
- **UI Integration**: `src/modules/ui/index.ts:1044-1126`

## Documentation

- `docs/git-review-workflow.md` - Workflow overview
- `docs/GITHUB_BACKEND_IMPLEMENTATION_PLAN.md` - Implementation details
- `docs/GITHUB_PAGES_SETUP.md` - Deployment guide
