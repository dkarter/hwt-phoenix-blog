# hwt Phoenix blog

A deliberately small Phoenix blog for exercising hwt worktree workflows. One Docker Compose
PostgreSQL server is shared by every checkout, while each worktree receives its own Phoenix port and
database.

## Primary checkout

```sh
mise install
mise run setup
mise run dev
```

The primary checkout defaults to <http://localhost:4000> and database
`hwt_phoenix_blog_dev`.

## Worktree workflow

The repository pins the immutable hwt development release that contains ticket-backed creation,
stable worktree ports and environments, named URLs and metadata, local DNS registration, pull
request URLs, and review workspaces.

Create a worktree directly:

```sh
hwt create --branch feature/change-title --base main --json
```

Or create an RMS Linear ticket and its worktree together:

```sh
hwt create 'Change the blog title' --json
```

HWT copies `deps` and `_build` with copy-on-write, allocates `HWT_PORT_WEB`, writes
`.env.worktree`, starts the shared PostgreSQL container, and prepares the worktree-specific database.
From the new workspace, start Phoenix with:

```sh
mise run dev
```

Inspect the generated environment and URLs:

```sh
hwt env --json
hwt url local --json
hwt url branch-preview --json
hwt url database --json
hwt url ticket --json
hwt pr --json
hwt preview --json
```

`local` uses hwt's generated Caddy/dnsmasq hostname. Run `hwt dns setup --json` once and connect the
reported snippets to user-managed services if you want that hostname to resolve. `branch-preview`
and `preview` use `.invalid` intentionally: they demonstrate deterministic branch and PR URL
resolution without pretending a deployment provider exists.

Create a pull request before using `hwt pr`, `hwt preview`, or `{pr_number}`. Review it in an exact,
reusable workspace with:

```sh
hwt review https://github.com/dkarter/hwt-phoenix-blog/pull/NUMBER --json
```

Remove a finished worktree through hwt so its port, database route, and Herdr workspace are cleaned
up:

```sh
hwt remove --workspace WORKSPACE_ID --json
```

The PostgreSQL database remains available for inspection after worktree removal. Drop it explicitly
when its data is no longer useful.

The repository pins lnr and stores only the public RMS team ID under `.hwt-config`. Authentication
still comes from your normal lnr OAuth cache; no Linear credential is copied into a worktree or
committed. `bin/hwt-ticket` adapts lnr's output into hwt's private per-worktree ticket metadata.

## Checks

```sh
mise run check
```

Lefthook enforces conventional commit messages and scans staged changes with gitleaks. Pre-push runs
the full project check. `fnox` is available for future secret-backed integrations; this local demo
uses only non-secret PostgreSQL development credentials.
