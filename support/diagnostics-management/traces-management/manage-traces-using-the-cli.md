# Manage traces using the CLI

Manage trace settings using the CLI commands:

* Initiate trace collection
* Stop trace collection
* View traces configuration status
* Modify traces retention settings
* Adjust traces verbosity level to high or low
* Manage the traces freeze period

## Initiate trace collection

**Command:** `weka debug traces start`

## Stop trace collection

**Command:** `weka debug traces stop`

## View traces configuration status

**Command:** `weka debug traces status`

## Modify traces retention settings

**Command:** `weka debug traces retention set  [--server-max server-max] [--client-max client-max] [--server-ensure-free server-ensure-free] [--client-ensure-free client-ensure-free]`

**Parameters**

<table><thead><tr><th width="240">Parameter</th><th>Description</th><th>Default</th></tr></thead><tbody><tr><td><code>server-max</code></td><td>Maximum capacity to retain per server.</td><td>50GB per IO-node with a minimum of 100GB</td></tr><tr><td><code>client-max</code></td><td>Maximum capacity to retain per client.</td><td>50GB per IO-node with a minimum of 100GB</td></tr><tr><td><code>server-ensure-free</code></td><td>Always maintain at least this much capacity to remain free on servers.</td><td>50GB per IO-node with a minimum of 100GB</td></tr><tr><td><code>client-ensure-free</code></td><td>Always maintain at least this much capacity to remain free on clients.</td><td>50GB per IO-node with a minimum of 100GB</td></tr></tbody></table>

{% hint style="info" %}
To modify the trace retention setting of a single client, you can use the `traces_capacity_mb` mount command. See [#additional-mount-options-using-the-stateless-clients-feature](../../../fs/mounting-filesystems/#additional-mount-options-using-the-stateless-clients-feature "mention").
{% endhint %}

### Restore default traces retention values

**Command:** `weka debug traces retention restore-default`

## Adjust traces verbosity level

**Command:** `weka debug traces level set <level>`

**Parameters**

<table><thead><tr><th width="161">Parameter</th><th>Description</th></tr></thead><tbody><tr><td><code>level</code>*</td><td><p>Verbosity level.</p><p>Format: <code>low</code> or <code>high</code></p></td></tr></tbody></table>

## Manage the traces freeze period

### View the frozen trace period &#x20;

**Command:** `weka debug traces freeze show`

### Set the freeze period

**Command:** `weka debug traces freeze set [--start-time start-time] [--end-time end-time] [--retention retention]`

**Parameters**

<table><thead><tr><th width="152">Parameter</th><th>Description</th></tr></thead><tbody><tr><td><code>start-time</code></td><td><p>The start time of the frozen period.</p><p>Format: 5m, -5m, -1d, -1w, 1:00, 01:00, 18:30, 18:30:07, 2018-12-31 10:00, 2018/12/31 10:00, 2018-12-31T10:00, 2019-Nov-17 11:11:00.309, 9:15Z, 10:00+2:00</p></td></tr><tr><td><code>end-time</code></td><td><p>The end time of the frozen period.</p><p>Format: 5m, -5m, -1d, -1w, 1:00, 01:00, 18:30, 18:30:07, 2018-12-31 10:00, 2018/12/31 10:00, 2018-12-31T10:00, 2019-Nov-17 11:11:00.309, 9:15Z, 10:00+2:00</p></td></tr><tr><td><code>retention</code></td><td><p>The time to retain the traces.</p><p>Format: 3s, 2h, 4m, 1d, 1d5h, 1w, infinite/unlimited</p></td></tr></tbody></table>

### Reset the traces freeze period and delete the existing frozen traces

**Command:** `weka debug traces freeze reset`
