---
description: >-
  Explore the hierarchical structure of WEKA Command-Line Interface (CLI)
  commands for convenient reference.
---

# WEKA CLI hierarchy

### **weka agent**

* install-agent
* update-containers
* supported-specs
* uninstall
* autocomplete
  * install
  * uninstall
  * export

### **weka alerts**

* types
* mute
* unmute
* describe

### **weka cloud**

* status
* enable
* disable
* proxy
* update
* upload-rate
  * status
  * enable
  * disable
  * proxy
  * upload-rate

### **weka cluster**

* create
* update
* process
* bucket
* failure-domain
* hot-spare
* start-io
* stop-io
* drive
  * scan
  * activate
  * deactivate
  * add
  * remove
* join-secret
  * show
* mount-defaults
  * set
  * show
  * reset
* servers
  * list
  * show
* container
  * info-hw
  * failure-domain
  * dedicate
  * bandwidth
  * cores
  * memory
  * auto-remove-timeout
  * management-ips
  * resources
  * restore
  * apply
  * activate
  * deactivate
  * clear-failure
  * add
  * remove
  * factory-reset
  * net
    * add
    * remove
* default-net
* license
* task
  * pause
  * resume
  * abort
  * limits
* client-target-version

### **weka diags**

* collect
* list
* rm
* upload

### **weka events**

* list-local
* list-types
* trigger-event

### **weka fs**

* create
* download
* update
* delete
* restore
* quota
  * set
  * set-default
  * unset
  * unset-default
  * list
  * list-default
* group
  * create
  * update
  * delete
* snapshot
  * create
  * copy
  * update
  * access-point-naming-convention
    * status
    * update
  * upload
  * download
  * delete
* tier
  * location
  * fetch
  * release
  * capacity
  * s3
    * add
    * update
    * delete
    * attach
    * detach
    * snapshot
      * list
  * ops
  * obs
    * update
* reserve
  * status
  * set
  * inset

### **weka local**

* install-agent
* diags
* events
* ps
* rm
* start
* stop
* restart
* status
* enable
* disable
* monitoring
* exec
* run
* reset-data
* resources
  * import
  * export
  * restore
  * apply
  * join-secret
  * cores
  * base-port
  * memory
  * dedicate
  * bandwidth
  * management-ips
  * join-ips
  * failure-domain
  * net
    * add
    * remove
* setup
  * weka
  * container
* upgrade

### **weka mount**

### **weka nfs**

* rules
  * add
  * delete
* client-group
  * add
  * delete
* permission
  * add
  * update
  * delete
* interface-group
  * add
  * update
  * delete
  * ip-range
  * port
* debug-level
  * show
  * set
* global-config
  * set
  * show

### **weka org**

* create
* rename
* set-quota
* delete

### **weka security**

* kms
  * set
  * unset
  * rewrap
* tls
  * status
  * download
  * set
  * unset
* lockout-config
  * set
  * reset
  * show
* login-banner
  * set
  * reset
  * enable
  * disable
  * show
* ca-cert
  * set
  * status
  * download
  * unset

### **weka smb**

* cluster
  * containers
    * add
    * remove
  * wait
  * update
  * create
  * debug&#x20;
  * destroy
  * trusted-domains
    * add
    * remove
  * status&#x20;
  * host-access
    * list
    * reset
    * add
    * remove
* share
  * update
  * lists
    * show
    * reset
    * add
    * remove
  * add
  * remove
  * host-access
    * list
    * reset
    * add
    * remove
* domain
  * join
    * cluster
    * share
    * domain
  * leave
    * cluster
    * share
    * domain

### **weka stats**

* realtime
* list-types
* retention
  * set
  * status
  * restore-default

### **weka status**

* rebuild

### **weka umount**

### **weka upgrade**

* supported-features

### **weka user**

* login
* logout
* whoami
* passwd
* change-role
* update
* add
* delete
* revoke-tokens
* generate-token
* ldap
  * setup
  * setup-ad
  * update
  * enable
  * disable
  * reset

### **weka version**

* supported-specs
* get
* set
* unset
* current
* rm
* prepare

### **weka s3**

* cluster
  * create
  * update
  * destroy
  * status
  * audit-webhook
  * containers
* bucket
  * create
  * list
  * destroy
  * lifecycle-rule
  * policy
  * quota
* policy
  * list
  * show
  * add
  * remove
  * attach
  * detach
* service-account
  * list
  * show
  * add
  * remove
* sts
  * assume-role
* log-level
  * get
