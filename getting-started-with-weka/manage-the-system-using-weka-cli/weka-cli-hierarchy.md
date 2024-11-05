---
description: >-
  Explore the hierarchical structure of WEKA Command-Line Interface (CLI)
  commands for easy reference.
---

# WEKA CLI hierarchy

{% hint style="info" %}
New commands the V4.4.X CLI, compared to V4.3.5, are marked with \*\*.
{% endhint %}

### weka agent

```
weka agent
   |install-agent
   |update-containers
   |uninstall
   |autocomplete
      |install
      |uninstall
      |export
```

### **weka alerts**

```
weka alerts
   |types
   |mute
   |unmute
   |describe
```

### **weka cloud**

```
weka cloud
   |status
   |enable
   |disable
   |proxy
   |update
   |upload-rate   
      |set
```

### **weka cluster**

```
weka cluster
    |create
    |update
    |process
    |bucket
    |failure-domain
    |hot-spare
    |start-io
    |stop-io
    |drive
        |scan
        |activate
        |deactivate
        |add
        |remove
    |mount-defaults
        |set
        |show
        |reset
    |servers
        |list
        |show
    |container
        |info-hw
        |failure-domain
        |dedicate
        |bandwidth
        |cores
        |memory
        |auto-remove-timeout
        |management-ips
        |resources
        |restore
        |apply
        |activate
        |deactivate
        |requested-action **
        |clear-failure
        |add
        |remove
        |factory-reset
        |net
            |add
            |remove
    |default-net
        |set
        |update
        |reset
    |license
        |reset
        |set
        |task
        |pause
        |resume
        |abort
        |limits
            |set
        |client-target-version
            |show
            |set
            |reset
```

### **weka diags**

```
weka diags
    |collect
    |list
    |rm
    |upload
```

### **weka events**

```
weka events
    |list-local
    |list-types
    |trigger-event
```

### **weka fs**

```
weka fs
    |create
    |download
    |update
    |kms-rewrap **
    |delete
    |restore
    |quota
        |set
        |set-default
        |unset
        |unset-default
        |list
        |list-default
    |group
        |create
        |update
        |delete
    |snapshot
        |create
        |copy
        |update
        |access-point-naming-convention
            |status
            |update
        |upload
        |download
        |delete
    |tier
        |location
        |fetch
        |release
        |capacity
        |s3
            |add
            |update
            |delete
            |attach
            |detach
            |snapshot
                |list
        |ops
        |obs
            |update
    |reserve
        |status
        |set
        |unset
    |security **
        |policy
            |list
            |set
            |reset
            |attach
            |detach        
```

### weka dataservice

```
weka dataservice
    |global-config
    |global-config set
    |global-config show
```

### weka interface-group

```
weka interface-group **
    |assignment
    |add
    |update
    |delete
    |ip-range
        |add
        |delete
    |port
        |add
        |delete
```

### **weka local**

```
weka local
    |install-agent
    |diags
    |events
    |ps
    |rm
    |start
    |stop
    |restart
    |status
    |enable
    |disable
    |monitoring
    |run
    |reset-data
    |resources
        |import
        |export
        |restore
        |apply
        |cores
        |base-port
        |memory
        |dedicate
        |bandwidth
        |management-ips
        |join-ips
        |fqdn **
        |failure-domain
        |net
            |add
            |remove
    |setup
        |services **
        |envoy **
        |weka
        |container
        |client **
    |upgrade
```

### **weka mount**

```
weka mount
```

### **weka nfs**

```
weka nfs 
    |rules
        |add
           |dns
        |delete
    |client-group
        |add
        |delete
    |permission
        |add
        |update
        |delete
    |interface-group
        |add
        |update
        |delete
        |ip-range
            |add
            |delete
        |port
            |add
            |delete
    |debug-level
        |show
        |set
    |global-config
        |set
        |show
    |clients **
        |show
    |kerberos
        |service
            |setup
            |show
        |registration
            |setup-ad
            |setup-mit
            |show
        |reset
    |ldap
        |setup-ad
        |setup-ad-nokrb **
        |setup-openldap
        |import-openldap **
        |export-openldap **
        |show
        |reset
```

### **weka org**

```
weka org
   |create
   |rename
   |set-quota
   |delete
   |security **
      |policy
         |list
         |set
         |reset
         |attach
         |detach
```

### **weka s3**

```
weka s3
   |cluster
      |create
      |update
      |destroy
      |status
      |audit-webhook
         |enable
         |disable
         |show
      |containers
         |add
         |remove
         |list
   |bucket
      |create
      |list
      |destroy
      |lifecycle-rule
         |add
         |remove
         |reset
         |list
      |policy
         |get
         |set
         |unset
         |get-json
         |set-custom
      |quota
         |set
         |unset
   |policy
      |list
      |show
      |add
      |remove
      |attach
      |detach
   |service-account
      |list
      |show
      |add
      |remove
   |sts
      |assume-role
   |log-level
      |get
```

### **weka security**

```
weka security
   |kms
      |set
      |unset
      |rewrap
   |tls
      |status
      |download
      |set
      |unset
   |lockout-config
      |set
      |reset
      |show
   |login-banner
      |set
      |reset
      |enable
      |disable
      |show
   |ca-cert
      |set
      |status
      |download
      |unset
   |cors-trusted-sites
      |list
      |add
      |remove
      |remove-all
   |policy **
      |list
      |show
      |create
      |delete
      |duplicate
      |update
      |test
      |join
          |set
          |attach
          |detach
          |reset
```

### **weka smb**

```
weka smb
   |cluster
      |containers
         |add
         |remove
      |wait
      |update
      |create
      |debug 
      |destroy
      |trusted-domains
         |add
         |remove
      |status 
   |share
      |update
      |lists
         |show
         |reset
         |add
         |remove
      |add
      |remove
      |host-access
         |list
         |reset
         |add
         |remove
   |domain
      |join
      |leave
```

### **weka stats**

```
weka stats
   |realtime
   |list-types
   |retention
      |set
      |status
      |restore-default
```

### **weka status**

```
weka status
   |rebuild
```

### weka umount

```
weka unmount
```

### **weka upgrade**

```
weka upgrade **
   |pause
   |resume
   |supported-features
```

### **weka user**

```
weka user
   |login
   |logout
   |whoami
   |passwd
   |change-role
   |update
   |add
   |delete
   |revoke-tokens
   |generate-token
   |ldap
      |setup
      |setup-ad
      |update
      |enable
      |disable
      |reset
```

### **weka version**

```
weka version
   |get
   |set
   |unset
   |current
   |rm
   |prepare
```

### weka driver

```
weka driver **
   |download
   |install
   |build
   |pack
   |sign
   |export
   |import
   |kernel
   |ready
```
