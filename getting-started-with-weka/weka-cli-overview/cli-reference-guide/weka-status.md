# weka status

Show overall status of the cluster.

```sh
weka status [--detailed-capacity]
```

| Parameter             | Description                                        |
| --------------------- | -------------------------------------------------- |
| `--detailed-capacity` | Include capacity details including data reduction. |

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
