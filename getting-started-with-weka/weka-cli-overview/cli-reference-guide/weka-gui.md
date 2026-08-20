# weka gui

Tools for reaching the Weka cluster's web GUI from the CLI.

```sh
weka gui
```

## weka gui bridge

Serve a local HTTP endpoint that forwards to the target cluster's web GUI over the CLI's own connection (including an SSH jump host), so support can open the GUI in a browser without direct network access to the cluster. Runs until interrupted with Ctrl-C.

```sh
weka gui bridge [--listen <string>] [--no-browser]
```

| Parameter                  | Description                                                                     |
| -------------------------- | ------------------------------------------------------------------------------- |
| `-l`, `--listen` \<string> | Local address to listen on (host:port). Defaults to an ephemeral loopback port. |
| `--no-browser`             | Do not open a web browser automatically.                                        |
