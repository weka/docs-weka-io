---
description: >-
  Explore the hierarchical structure of WEKA Command-Line Interface (CLI)
  commands for easy reference.
metaLinks:
  alternates:
    - >-
      https://app.gitbook.com/s/0yXyIrnroN3zIG3qa4W3/getting-started-with-weka/manage-the-system-using-weka-cli/weka-cli-hierarchy
---

# WEKA CLI hierarchy

{% hint style="info" %}
CLI commands marked with two asterisks (\*\*) are new in version 5.1.34, compared to version 5.0.4.
{% endhint %}

### weka agent

```
weka agent
   |autocomplete
      |export
      |install
      |uninstall
   |install-agent
   |restart
   |uninstall
   |update-containers
```

### weka alerts

```
weka alerts
   |describe
   |mute
      |add **
      |list **
      |remove **
   |types
   |unmute
```

### weka audit

```
weka audit
   |cluster
      |decrypt-filename
         |disable
         |enable
      |decrypt-fullpath
         |disable
         |enable
      |disable
      |enable
      |enhancer
         |disable
         |enable
      |resolve-paths
         |disable
         |enable
      |set-global-operations
      |stats
      |status
   |fs
      |disable
      |enable
      |set-operations
      |status
```

### weka catalog \*\*

```
weka catalog
   |cluster **
      |add **
      |remove **
      |status **
      |update **
   |config **
      |show **
      |update **
   |fs **
      |status **
   |metadata **
      |remove **
      |show **
```

### weka cloud

```
weka cloud
   |disable
   |enable
   |proxy
   |quota-analytics **
      |disable **
      |enable **
      |redact-paths **
         |off **
         |on **
      |status **
   |status
   |upload-rate
      |set
```

### weka cluster

```
weka cluster
   |add
   |bucket
   |client-target-version
      |reset
      |set
      |show
   |container
      |activate
      |add
      |apply
      |bandwidth
      |clear-failure
      |cores
      |deactivate
      |deactivation-check
      |dedicate
      |failure-domain
      |info-hw
      |join-secret
      |management-ips
      |memory
      |net
         |add
         |remove
      |non-datapath-cores **
      |remove
      |requested-action
      |resources
      |restore
   |default-net
      |reset
      |set
      |update
   |drive
      |activate
      |add
      |deactivate
      |identify **
      |remove
      |scan
   |failure-domain
   |hot-spare
   |license
      |reset
      |set
   |mount-defaults
      |reset
      |set
      |show
   |network-space **
      |add **
      |remove **
      |show-usage **
      |update **
   |process
   |servers
      |list
      |requested-action
      |show
   |start-io
   |stop-io
   |task
      |abort
      |bucket
      |limits
         |set
      |pause
      |resume
      |throttle
   |update
```

### weka dataservice

```
weka dataservice
   |global-config
      |set
      |show
   |s3-lifecycle-task **
      |disable **
      |enable **
      |set **
      |show **
```

### weka diags

```
weka diags
   |collect
   |list
   |rm
   |upload
```

### weka driver

```
weka driver
   |build
   |download
   |export
   |import
   |install
   |kernel
   |pack
   |ready
   |sign
```

### weka events

```
weka events
   |list-local
   |list-types
   |trigger-event
```

### weka fs

```
weka fs
   |add
   |download
   |group
      |add
      |remove
      |update
   |kms-rewrap
   |protection
      |snapshot-policy
         |add
         |attach
         |detach
         |duplicate
         |export
         |list
         |remove
         |run-once
         |show
         |update
   |quota
      |disable-users **
      |enable-users **
      |list
      |list-default
      |reset
      |set
      |set-default
      |unset-default
   |remove
   |reserve
      |reset
      |set
      |status
   |restore
   |security
      |policy
         |attach
         |detach
         |list
         |reset
         |set
   |snapshot
      |access-point-naming-convention
         |status
         |update
      |add
      |copy
      |download
      |remove
      |update
      |upload
   |tier
      |capacity
      |fetch
      |location
      |obs
         |update
      |ops
      |release
      |s3
         |add
         |attach
         |detach
         |remove
         |snapshot
            |list
         |update
   |update
```

### weka interface-group

```
weka interface-group
   |add
   |assignment
   |ip-range
      |add
      |remove
   |port
      |add
      |remove
   |remove
   |update
```

### weka local

```
weka local
   |diags
   |disable
   |drive
      |identify
      |list **
   |enable
   |events
   |install-agent
   |monitoring
   |ps
   |reset-data
   |resources
      |apply
      |auto-remove-timeout
      |bandwidth
      |base-port
      |cores
      |dedicate
      |drive **
         |add **
         |remove **
         |scan **
      |export
      |failure-domain
      |fqdn
      |hardware-monitor **
      |import
      |join-ips
      |join-secret
      |management-ips
      |management-nets **
      |memory
      |net
         |add
         |remove
      |non-datapath-cores **
      |restore
   |restart
   |rm
   |run
   |setup
      |client
      |container
      |envoy
      |ssdproxy **
      |taskmon
      |telemetry
      |weka
   |start
   |status
   |stop
   |upgrade
```

### weka mount

```
weka mount
```

### weka nfs

```
weka nfs
   |client-group
      |add
      |remove
   |clients
      |show
   |debug-level
      |list **
      |set
      |show
   |global-config
      |set
      |show
   |interface-group
      |add
      |assignment
      |ip-range
         |add
         |remove
      |port
         |add
         |remove
      |remove
      |update
   |kerberos
      |registration
         |setup-ad
         |setup-mit
         |show
      |reset
      |service
         |setup
         |show
   |ldap
      |export-openldap
      |import-openldap
      |reset
      |setup-ad
      |setup-ad-nokrb
      |setup-onhostldap **
      |setup-openldap
      |show
   |permission
      |add
      |remove
      |update
   |rules
      |add
         |dns
         |ip
      |remove
         |dns
         |ip
```

### weka s3

```
weka s3
   |bucket
      |add
      |etag-alg **
         |reset **
         |set **
      |integrity-mode **
         |reset **
         |set **
      |lifecycle-rule
         |add
         |list
         |remove
         |reset
      |list
      |notification
         |add
         |list
         |remove
      |policy
         |get
         |get-json
         |reset
         |set
         |set-custom
      |quota
         |reset
         |set
      |remove
      |sorting **
         |reset **
         |set **
      |versioning **
         |enable **
         |get **
         |suspend **
   |cluster
      |add
      |audit-webhook
         |batch-config **
         |disable
         |enable
         |show
      |container
         |add
         |list
         |remove
      |etag-alg **
         |reset **
      |group **
         |add **
         |list **
         |remove **
      |integrity-mode **
         |reset **
      |notification-target
         |add
         |cert
            |add
            |list
            |remove
         |list
         |remove
         |show
         |status
         |update
      |oidc **
         |add **
         |remove **
         |show **
         |update **
      |performance-bucket **
      |remove
      |setup **
         |show **
         |update **
      |sorting **
         |reset **
      |status
      |update
         |performance-bucket **
   |policy
      |add
      |attach
      |detach
      |list
      |remove
      |show
   |service-account
      |add
      |list
      |remove
      |show
   |sts
      |assume-role
   |user **
      |keys-generate **
```

### weka security

```
weka security
   |ca-cert
      |download
      |reset
      |set
      |status
   |cors-trusted-sites
      |add
      |list
      |remove
      |remove-all
   |gui-idle-timeout **
      |restore-defaults **
      |set **
      |show **
   |kms
      |reset
      |rewrap
      |scope **
      |set
         |kmip **
         |vault **
   |lockout-config
      |reset
      |set
      |show
   |login-banner
      |disable
      |enable
      |reset
      |set
      |show
   |policy
      |add
      |duplicate
      |join
         |attach
         |detach
         |list
         |reset
         |set
      |list
      |remove
      |show
      |test
      |update
   |tls
      |download
      |local
         |reset
         |set
      |reset
      |set
      |status
```

### weka smb

```
weka smb
   |cluster
      |add
      |container
         |add
         |remove
      |debug
      |remove
      |status
      |trusted-domains
         |add
         |remove
      |update
      |wait
   |domain
      |join
      |leave
   |share
      |add
      |host-access
         |add
         |list
         |remove
         |reset
      |list
         |add
         |remove
         |reset
         |show
      |remove
      |update
```

### weka stats

```
weka stats
   |list-types
   |realtime
   |retention
      |restore-default
      |set
      |status
```

### weka status

```
weka status
   |rebuild
   |reduction
```

### weka telemetry

```
weka telemetry
   |exports
      |add
         |kafka
         |s3
         |splunk
         |syslog **
      |attach
      |detach
      |disable
      |enable
      |list
      |remove
      |status
      |update
         |s3
         |splunk
         |syslog **
```

### weka tenant \*\*

```
weka tenant
   |add **
   |network-space **
      |add **
      |remove **
   |remove **
   |rename **
   |security **
      |policy **
         |attach **
         |detach **
         |list **
         |reset **
         |set **
      |revoke-tokens **
   |stats **
   |update **
```

### weka umount

```
weka umount
```

### weka upgrade

```
weka upgrade
   |backends **
   |supported-features
```

### weka user

```
weka user
   |add
   |change-role
   |generate-token
   |ldap
      |disable
      |enable
      |refresh-imported **
      |reset
      |setup
      |setup-ad
      |update
   |login
   |logout
   |passwd
   |remove
   |revoke-tokens
   |update
   |whoami
```

### weka version

```
weka version
   |current
   |get
   |prepare
   |reset
   |rm
   |set
```
