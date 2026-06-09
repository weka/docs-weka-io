---
description: >-
  Find answers to common questions about data catalog capacity, performance,
  upgrades, and deployment limits.
---

# Data catalog FAQ

Browse common answers about data catalog capacity, performance, upgrades, and deployment limits.

<details>

<summary>What happens if <code>.indexfs</code> runs out of space?</summary>

Catalog ingestion can stall and then fail until you add space to the index filesystem.

After capacity is available again, ingestion resumes on the next catalog ingest cycle.

Check these events on the affected filesystem:

```bash
Event: CatalogIndexFsCapacityCritical
Event: CatalogIngestionFailed
```

</details>

<details>

<summary>What IO overhead does data catalog add?</summary>

Internal testing with typical workloads shows up to 10% overhead on client IO.

For high-churn environments (500+ million objects), run data catalog on dedicated servers instead of sharing servers with backend workloads.

</details>

<details>

<summary>What happens if you upgrade with catalog indexing enabled?</summary>

The upgrade is blocked. The cluster does not start the upgrade while catalog indexing is enabled or catalog tasks are still running.

Disable indexing before the upgrade. Re-enable it after the upgrade completes.

Example upgrade failure:

```bash
Upgrade starting with mode ndu
Running pre-upgrade verifications
Can't start upgrade because catalog indexing is enabled
verification catalog indexing is enabled or catalog tasks are running failed
Upgrade can't continue: verification catalog indexing is enabled or catalog tasks are running failed
```

Disable indexing:

```bash
weka catalog config update --index-enabled false
weka catalog config show
```

Before you start the upgrade, confirm the output shows:

```bash
Indexing enabled: false
```

Re-enable indexing after the upgrade:

```bash
weka catalog config update --index-enabled true
weka catalog config show
```

After the upgrade completes, confirm the output shows:

```bash
Indexing enabled: true
```

</details>

<details>

<summary>Can you deploy all data service containers on one server?</summary>

No. Deploy one data service container per server, and size the deployment based on the number of objects and expected growth rate.

</details>

**Related topics**

For deployment steps and sizing guidance, see [Configure data catalog](configure-data-catalog.md).

For UI workflows, see [Analyze storage distribution](analyze-storage-distribution.md).
