# weka upgrade

Control the cluster upgrade process.

```sh
weka upgrade
```

## weka upgrade backends

Run upgrade using a specific CLI version. Supports only a minimal set of flags.

```sh
weka upgrade backends <target> [--allow-alerts <strings>…] [--can-run] [--container <string>] [--distribute-version] [--enable-upgrade-prompt] [--environment <strings>…] [--expect-stopped-io] [--mode <string>] [--prepare-only] [--skip-alerts-check] [--skip-deleted-overrides-check] [--target-release <string>] [--use-requested-action <on-off>]
```

| Parameter                          | Description                                                                                                                                                                                              |
| ---------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `target`\*                         | The CLI version to run the upgrade command in.                                                                                                                                                           |
| `--allow-alerts` \<strings>…       | Allow a specific alert type to be active when starting the upgrade. Prefer this flag over skipping the alerts check. Multiple values may be supplied separated by commas, or the option may be repeated. |
| `--can-run`                        | Check whether the system is ready for the upgrade to run.                                                                                                                                                |
| `-C`, `--container` \<string>      | The container to run in.                                                                                                                                                                                 |
| `--distribute-version`             | Only download and prepare the version on all hosts, but don't actually start the upgrade process.                                                                                                        |
| `--enable-upgrade-prompt`          | Enable prompts between host upgrades.                                                                                                                                                                    |
| `-e`, `--environment` \<strings>…  | Environment variable (KEY=VALUE) to forward into the upgrade container. May be repeated. Multiple values may be supplied separated by commas, or the option may be repeated.                             |
| `--expect-stopped-io`              | Expect the system to already be in a stopped IO state.                                                                                                                                                   |
| `--mode` \<string>                 | The type of upgrade to perform.                                                                                                                                                                          |
| `--prepare-only`                   | Check we can upgrade, download and prepare the version on all hosts, but don't actually start the upgrade process.                                                                                       |
| `--skip-alerts-check`              | Skip the check making sure there are no active alerts.                                                                                                                                                   |
| `--skip-deleted-overrides-check`   | Skip the check making sure enabled manual overrides are supported by the target version.                                                                                                                 |
| `--target-release` \<string>       | The target release to upgrade to. This is a release string and should be in the format X.Y.Z.                                                                                                            |
| `--use-requested-action` \<on-off> | Use the requested-action mechanism to drain containers during upgrade.                                                                                                                                   |

## weka upgrade pause

Pause the cluster upgrade process.

```sh
weka upgrade pause
```

## weka upgrade resume

Resume the cluster upgrade process.

```sh
weka upgrade resume
```

## weka upgrade supported-features

Get the supported upgrade features of the cluster.

```sh
weka upgrade supported-features
```

**Columns:** `ndu_supported`, `rolling_compute_supported`, `leader_set_writable`
