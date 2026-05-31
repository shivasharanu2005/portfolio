# Portfolio — build & deploy

Quick instructions to build and preview the static portfolio on Windows.

Run build (PowerShell):

```powershell
./build.ps1
```

This creates a `dist` folder with minified HTML and a `deploy.zip` archive for deployment.

Preview locally (PowerShell):

```powershell
./serve.ps1
# then open http://localhost:8000
```

If you prefer other options:
- Use VS Code Live Server and point it at the `dist` folder.
- Deploy `deploy.zip` contents to any static host (GitHub Pages, Netlify, Vercel, Firebase Hosting).

Notes:
- The build script performs a lightweight HTML minification (removes comments and extra whitespace).
- If you want a production pipeline (asset bundling, cache busting), I can add an npm-based workflow.

Deployment options

1) GitHub Pages (recommended for a simple static site)

- Create a new GitHub repository and push this project.

```bash
git init
git add .
git commit -m "Initial commit"
git branch -M main
git remote add origin <your-git-remote-url>
git push -u origin main
```

- The repository includes a GitHub Actions workflow at `.github/workflows/deploy-gh-pages.yml` that runs the included `build.ps1` and deploys `dist` to GitHub Pages on pushes to `main`.

2) Netlify

- Option A (quick): In Netlify's site settings choose "Deploy from Git" and set the publish directory to `shivasharanu portfolio/dist` (no build command required).
- Option B (manual): Drag & drop the contents of `deploy.zip` to the Netlify dashboard's "Sites > New site from deploy > Drag and drop" area.

Notes about pushing

- I created CI configs and a `netlify.toml` file but I cannot push to your remote repository from here. Run the git commands above (replace `<your-git-remote-url>` with your repo URL) to push and trigger the GitHub Actions workflow.

Would you like me to create the GitHub repo and push the code if you provide the remote URL and permission, or do you prefer to push it yourself?
