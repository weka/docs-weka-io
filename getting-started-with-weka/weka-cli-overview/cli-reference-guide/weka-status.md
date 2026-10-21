# weka status

Show overall status of the cluster.

```sh
weka status [--detailed-capacity]
```

| Parameter             | Description                                        |
| --------------------- | -------------------------------------------------- |
| `--detailed-capacity` | Include capacity details including data reduction. |

**Columns:** `build_options`, `cluster`, `leader_process`, `leadership_processes`, `deployment_mode`, `status`, `rebuild`, `init_error`, `protection`, `hot_spare`, `drive_storage`, `data_reduction_ratio`, `data_reduction_saved`, `cloud`, `license`, `io_status`, `link_layer`, `clients`, `reads`, `writes`, `operations`, `upgrade`, `data_upgrade`, `alerts`, `denied`, `reason`

## weka status meta

Show metadata about the API service.

```sh
weka status meta
```

**Columns:** `api_major_version`, `api_minor_version`, `build`, `legal`, `banner`, `multi_org`, `stem_mode`, `git_version`

## weka status rebuild

Show the cluster phasing in/out progress, and protection per fault-level.

```sh
weka status rebuild
```

## weka status reduction

Show cluster data reduction information.

```sh
weka status reduction
```

**Columns:** `ReductionRatio`, `SavedBytes.Value`
