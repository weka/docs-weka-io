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
CLI commands marked with two asterisks (\*\*) are new in version 5.1.0, compared to version 5.0.4.
{% endhint %}

### weka agent

```
weka agent
   |autocomplete
      |export
      |install
      |uninstall
   |install-agent
   |update-containers
   |uninstall
```

### **weka alerts**

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

### **weka audit**

```
weka audit
   |cluster
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

### **weka cloud**

```
weka cloud
   |disable
   |enable
   |proxy
   |status
   |update
   |upload-rate   
      |set
```

### **weka cluster**

```
weka cluster
    |bucket
    |client-target-version
       |reset
       |set
       |show
    |container
       |activate
       |add
       |apply
       |auto-remove-timeout
       |bandwidth
       |clear-failure
       |cores
       |deactivate
       |deactivation-chec 
       |dedicate
       |failure-domain
       |info-hw
       |join-secret
       |management-ips
       |memory
       |net
          |add
          |remove
       |remove
       |requested-action
       |resources
       |restore
    |add
    |default-net
        |reset
        |set
        |update  
    |drive
        |activate
        |add
        |deactivate
        |remove
        |scan
        |identify **
    |failure-domain
    |hot-spare
    |license
        |reset
        |set
    |task
        |pause
        |resume
        |abort
        |limits
            |set
    |mount-defaults
        |reset
        |set
        |show   
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
        |disable
        |enable
        |set
        |show
```

### **weka diags**

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
    |add
    |remove
    |download
    |group
        |add
        |remove
        |update
    |kms-rewrap
    |protection
        |snapshot-policy
            |attach
            |add
            |remove
            |detach
            |duplicate
            |export
            |list
            |run-once
            |show
            |update
     |quota
        |list
        |list-default
        |set
        |set-default
        |reset
        |unset-default
    |reserve
        |set
        |status
        |reset
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
        |copy
        |add
        |remove
        |download
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
            |remove
            |detach
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
    |remove
    |ip-range
        |add
        |remove
    |port
        |add
        |remove
    |update
```

### **weka local**

```
weka local
    |diags
    |disable
    |drive **
       |identify
       |list
    |enable
    |events
    |extract-hostside
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
           |add
           |remove
           |scan
        |export
        |failure-domain
        |fqdn
        |hardware-monitor **
        |import
        |join-ips
        |join-secret
        |management-ips
        |memory       
        |net
            |add
            |remove
        |restore
    |restart
    |rm
    |run
    |setup
        |client
        |container
        |envoy
        |ssdproxy **
        |services
        |taskmon
        |telemetry
        |weka
    |start  
    |status
    |stop  
    |upgrade
```

### **weka mount**

```
weka mount
```

### **weka nfs**

```
weka nfs 
    |client-group
        |add
        |remove
    |clients
        |show
    |debug-level
        |set
        |show
    |global-config
        |set
        |show
    |interface-group
        |add
        |assignmment
        |remove
        |ip-range
            |add
            |remove
        |port
            |add
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

### **weka org**

```
weka org
   |add
   |remove
   |rename
   |security
      |policy
         |attach
         |detach
         |list
         |reset
         |set
      |revoke-tokens
   |set-quota   
```

### **weka s3**

```
weka s3
   |bucket
      |add
      |remove
      |etag-alg **
         |reset
         |set
      |integrity-mode **
         |set
      |lifecycle-rule
         |add
         |list
         |remove
         |reset
      |list
      |policy
         |get
         |get-json
         |set
         |set-custom
         |reset
      |quota
         |set
         |reset
      |sorting **
         |reset
         |set
   |cluster
      |audit-webhook
         |batch-config **
         |disable
         |enable
         |show
      |container
         |add
         |list
         |remove
      |add
      |remove
      |etag-alg **
         |reset
      |integrity-mode **
         |reset
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
      |performance-bucket **
      |sorting **
         |reset
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
```

### **weka security**

```
weka security
   |ca-cert
      |download
      |set
      |status
      |reset
   |cors-trusted-sites
      |add
      |list
      |remove
      |remove-all
   |gui-idle-timeout **
      |restore-defaults
      |set
      |show
   |kms
      |rewrap
      |set
      |reset
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
      |remove
      |duplicate
      |join
          |attach
          |detach
          |list
          |reset
          |set
      |list
      |show
      |test
      |update     
   |tls
      |download
      |local
         |set
         |reset
      |set
      |status
      |reset
```

### **weka smb**

```
weka smb
   |cluster
      |container
         |add
         |remove
      |add
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

### **weka stats**

```
weka stats
   |list-types
   |realtime
   |retention
      |restore-default
      |set
      |status
```

### **weka status**

```
weka status
   |rebuild
   |reduction
```

### weka telemetry <a href="#weka-telemetry" id="weka-telemetry"></a>

```
weka telemetry
   |exports
      |add
         |kafka
         |S3
         |splunk
      |attach
      |detach
      |disable
      |enable
      |list
      |remove
      |status
      |update
         |S3
         |splunk
```

### weka umount

```
weka unmount
```

### **weka upgrade**

```
weka upgrade
   |pause
   |resume
   |supported-features
```

### **weka user**

```
weka user
   |add
   |change-role
   |remove
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
   |revoke-tokens
   |update
   |whoami
```

### **weka version**

```
weka version
   |current
   |get
   |prepare
   |rm
   |set
   |reset
```
