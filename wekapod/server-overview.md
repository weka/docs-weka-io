# WEKApod servers overview

## **WEKApod server core** component

The WEKApod's core component is a 1U server that includes:

* **Processor:** One AMD EPYC 9454P 48-Core Processor.
* **Memory:** 12 DDR5 DIMM slots with 384 GB.
* **Power supply:** Two redundant AC power units.
* **NVMe drive options:** (order-dependent)
  * 10 x 2.5-inch NVMe drives (WEKApod Prime)
  * 14 x E3.S NVMe drives (WEKApod Nitro)
  * 8 x 2.5-inch NVMe drives (WMS)
* **High-speed storage connectivity:** InfiniBand cards (order-dependent):
  * NVIDIA CX-6 MCX653105A-HDAT (WEKApod Prime)
  * NVIDIA CX-7 MCX75310AAS-NEAT (WEKApod Nitro)
  * NVIDIA CX-7 MCX75210AAS-NEAT (WEKApod Nitro)
* **Networking:** Network Interface Card (NIC) for general-purpose networking.

{% hint style="info" %}
A WEKApod server installed with WSA is referred to as a **WSA server**.

A WEKApod server installed with WMS is referred to as a **WMS server**.
{% endhint %}

## Front view of the WEKApod servers

The front view of the WEKApod server configuration is order-dependent:

* WEKApod Prime: A WSA server equipped with 10 X 2.5-inch NVMe drives.
* WEKApod Nitro: A WSA server equipped with 14 X E3.S NVMe drives.
* WMS: A WMS server equipped with 8 X 2.5-inch NVMe drives.

<figure><img src="../.gitbook/assets/wekapod_front_view_10-2.5.png" alt=""><figcaption><p>Front view of the WSA server Prime (10 X 2.5-inch NVMe drives)</p></figcaption></figure>

<figure><img src="../.gitbook/assets/wekapod_front_view_E3S.png" alt=""><figcaption><p>Front view of the WSA server Nitro (14 E3.S NVMe drives)</p></figcaption></figure>

<figure><img src="../.gitbook/assets/wekapod_front_view_8-2.5.png" alt=""><figcaption><p>Front view of the WMS server (8 X 2.5-inch NVMe drives)</p></figcaption></figure>

**Front view of the WSA and WMS servers: Ports, panels, and slots descriptions** (all configurations)

<table><thead><tr><th width="83">Item</th><th width="210">Ports, panels, and slots</th><th>Description</th></tr></thead><tbody><tr><td>1</td><td>Left control panel</td><td>Contains the system health, system ID, and the status LED indicators.</td></tr><tr><td>2</td><td>Drives</td><td>Enables you to install NVMe drives supported on your system (order-dependent: E3.S or 2.5-inch).</td></tr><tr><td>3</td><td>Right control panel</td><td>Contains the power button with integrated power LED, 1 x VGA port, 1 x 2.0 USB port, iDRAC Direct (Micro-AB USB) port, and the iDRAC Direct status LED.</td></tr><tr><td>4</td><td>VGA</td><td>Enables you to connect a display device to the system.</td></tr><tr><td>5</td><td>Information tag</td><td>The Express Service Tag is a slide-out label panel that contains system information such as Service Tag, NIC, MAC address, and so on. If you have opted for the secure default access to iDRAC, the Information tag also contains the iDRAC secure default password.</td></tr><tr><td>6</td><td>E3.S blank</td><td>Enables you to install blanks for 14 x E3.S configuration.</td></tr></tbody></table>

## Rear view of the WSA and WMS servers

<figure><img src="../.gitbook/assets/wekapod_wsa_server_rear.png" alt=""><figcaption><p>Rear view of the WSA server</p></figcaption></figure>

**Rear view of the WEKApod server: Ports, panels, and slots**

<table><thead><tr><th width="83">Item</th><th width="220">Ports, panels, and slots</th><th>Description</th></tr></thead><tbody><tr><td>1</td><td>Power supply unit (PSU1)</td><td>Primary power supply unit.</td></tr><tr><td>2</td><td>InfiniBand port 1</td><td>400 Gbps HDR InfiniBand port (<strong>ib1</strong>) for storage network connectivity.</td></tr><tr><td>3</td><td>InfiniBand port 2</td><td>400 Gbps HDR InfiniBand port (<strong>ib0</strong>) for storage network connectivity.</td></tr><tr><td>4</td><td>Power supply unit (PSU2)</td><td>Secondary power supply unit.</td></tr><tr><td>5</td><td>OS management Ethernet ports</td><td>1 Gbps Ethernet ports (left to right): WEKA Linux <strong>eno8303</strong> and <strong>eno8403</strong>.</td></tr><tr><td>6</td><td>25 Gbps Ethernet ports</td><td>Extra 25 Gbps Ethernet ports for auxiliary uses like WEKA Object Storage tiering, Snapshot-to-Object backup, and other secondary applications.</td></tr><tr><td>7</td><td>BMC Ethernet port</td><td>Ethernet port for in-band management (iDRAC).</td></tr></tbody></table>

**Rear view of the WMS server: Ports, panels, and slots**

<figure><img src="../.gitbook/assets/wekapod_wms_server_rear.png" alt=""><figcaption><p>Rear view of the WMS server</p></figcaption></figure>

<table><thead><tr><th width="83">Item</th><th width="220">Ports, panels, and slots</th><th>Description</th></tr></thead><tbody><tr><td>1</td><td>Power supply unit (PSU1)</td><td>Primary power supply unit.</td></tr><tr><td>2</td><td>Power supply unit (PSU2)</td><td>Secondary power supply unit.</td></tr><tr><td>3</td><td>OS management Ethernet ports</td><td>1 Gbps Ethernet ports (left to right): WEKA Linux <strong>eno12399</strong>, <strong>eno12409</strong>, <strong>eno12419</strong>, and <strong>eno12429</strong>.</td></tr><tr><td>4</td><td>BMC Ethernet port</td><td>Ethernet port for in-band management (iDRAC).</td></tr></tbody></table>

## Server Information tag location

Each server can be identified by its unique Express Service Code and Service Tag. To access this information, pull out the Information tag located at the front of the server. Alternatively, this information may be found on a sticker on the chassis. The mini Enterprise Service Tag (EST) is located on the back of the server and is used to route support calls to the appropriate personnel.

A spreadsheet containing the corresponding Service Tag number provides details on the WEKApod server's IP address and mount order.

The Information tag is a slide-out label that displays key server details, including the Service Tag, NIC, MAC address, and more. It also includes the iDRAC secure default password; however, note that the password has been reset to **WekaService** through the ID Module.

<figure><img src="../.gitbook/assets/WEKApod_info_label_upper.png" alt="" width="563"><figcaption><p>Information tag upper view (pulled from the front-right of the server)</p></figcaption></figure>

<figure><img src="../.gitbook/assets/WEKApod_info_label_back.png" alt="" width="563"><figcaption><p>Information tag bottom view</p></figcaption></figure>
