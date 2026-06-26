# Local development (`update` branch)

This branch is for upgrading the site. Iterate locally here, confirm it looks
right, **then** merge to `main` — only `main` is published to
<https://jingweio.github.io/>.

## Start the dev server

```bash
./serve-local.sh
```

Then open <http://localhost:4000>. **Live-reload is on** — save any file and the
browser refreshes automatically. Stop with `Ctrl-C`.

Use a different port if 4000 is busy:

```bash
./serve-local.sh --port 4001
```

## How it works

This is a [Jekyll](https://jekyllrb.com/) site using the **remote theme**
[`yaoyao-liu/minimal-light`](https://github.com/yaoyao-liu/minimal-light).
The theme's files are fetched from GitHub at build time; any file you create
locally **overrides** the theme's copy. So to customize, mirror the theme's
path locally and edit it:

| What you edit                | File / folder                                  |
| ---------------------------- | ---------------------------------------------- |
| Page content / bio           | `index.md`                                     |
| Page layout                  | `_layouts/homepage.html`                        |
| Sections (news, pubs, etc.)  | `_includes/*.md`                                |
| Data (publications, nav, …)  | `_data/*.yml`                                   |
| Styles                       | `_sass/minimal-light.scss`, `css/`, `assets/`  |
| Site settings                | `_config.yml`                                   |

To customize something that only exists in the remote theme, copy that file
down from the [theme repo](https://github.com/yaoyao-liu/minimal-light) into
the matching local path, then edit it.

## Config: production vs. local

- **`_config.yml`** — the real config. This is the **only** config GitHub Pages
  reads. Production-facing changes go here.
- **`_config.dev.yml`** — local-only overrides, layered on top by
  `serve-local.sh`. GitHub Pages never reads it. It blanks out Google Analytics
  and sets the localhost URL so local runs stay clean.

## First run / dependencies

`serve-local.sh` installs gems automatically on first run (into a git-ignored
`vendor/bundle/`). Requirements: Ruby + Bundler (already present on this Mac:
Ruby 3.2.2, Bundler 2.7.1).

If you ever need to reinstall manually:

```bash
bundle config set --local path vendor/bundle
bundle install
```

> On Apple Silicon, gems are installed against Homebrew's `libffi`
> (`brew install libffi`) — the script sets this up automatically.

## Build artifacts (not committed)

`_site/`, `.jekyll-cache/`, `vendor/`, `.bundle/` are git-ignored. GitHub Pages
rebuilds the site from source on every push, so the generated `_site/` is never
committed — don't add it back.

## Shipping to production

1. Verify everything at <http://localhost:4000>.
2. Commit on `update`.
3. Merge `update` → `main` and push. GitHub Pages rebuilds and the changes go
   live at <https://jingweio.github.io/>.
