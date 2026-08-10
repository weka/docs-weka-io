---
description: >-
  Assess Local WEKA Home health on K3s and capacity with one command. homecli
  local diagnose is available in LWH 5.0 and later.
---

# Diagnose the Local WEKA Home

Unlike `homecli local status`, which confirms reachability, `homecli local diagnose` evaluates deployment health and sizing.

### Before you begin

* Use LWH 5.0 or later.
* Ensure `homecli` can access the LWH deployment.
* Use an account authorized to inspect the deployment.

### Diagnose Local WEKA Home

1. Run the following command:

```sh
homecli local diagnose
```

2. Review the report. Apply each recommended action.
3. For automated processing, output the report in JSON format:

```sh
homecli local diagnose -o json
```

### Interpret the report

The report includes:

* Pod health across all LWH components.
* Node, PVC, and disk capacity, including disk fill estimates.
* Stats and forwarding pipeline backlogs.
* NATS and FSQ queue state.
* Database and VictoriaMetrics status.
* Resource sizing recommendations based on current load and the selected resource preset.

When the command detects a problem, it raises a targeted alert. A `[MIGRATION STUCK]` banner includes the command required to resolve it.

Run the command in the following situations:

* After a new deployment, to confirm the installation is healthy and correctly sized.
* Before and after an upgrade, to validate resource preset recommendations.
* When investigating performance issues, backlogs, or disk space alerts.

The LWH deployment diagnostics archive automatically bundles a `homecli local diagnose -o json` snapshot, so a separate run before contacting support is not required.
