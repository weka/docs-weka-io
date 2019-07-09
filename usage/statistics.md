---
description: >-
  This page describes the statistics available in the WekaIO system and how to
  work with them.
---

# Statistics

## Overview

As the WekaIO system runs, it collects hundreds of statistics on system performance. These statistics help in analyzing the WekaIO system performance and determining the source of any problems.

Five different categories of statistics are available for review - Operations \(NFS\), Operations \(Driver\), Object Store, SSD and CPU – and when each category is selected, a list of the possible statistics that can be selected is displayed.

By default, the main statistics page displays the last 3 hours of operation, presenting the WekaIO system operation per second on a time axis.

![Statistics View Screen](../.gitbook/assets/statistics-main-screen.png)

This Statistics view screen offers a number of options to drill-down into the statistics, according to category. Options include:

* Mousing over the scrollable graph area to view various performance metrics of the WekaIO matrix cluster.
* Troubleshooting or obtaining a correlation between events and performance \(using the top line which provides links to events that occurred\).
* Adding more statistics to the view \(using the Statistics menu\).
* Displaying different statistics simultaneously and toggling between them. By default, the graph area shows Ops/sec for the last hour. Using the "Hour, Day, Week" buttons

  at the bottom-right enables changing of the time interval.

* Displaying, hiding. deleting, and zooming-in on statistics from defined timelines and dates.
* Bookmarking specific statistics for future reference and sharing with others \(using the URL\).

## Working with Statistics Using the GUI

### Viewing Statistics

To view the statistics screen using the GUI, click the statistics button on the left bar:  

![Statistics View Screen](../.gitbook/assets/screenshot-from-2018-07-29-11-47-29.png)

### Adding Statistics

To select the addition of specific statistics, click the + Add Statistics tab on the right-hand side of the Statistics view screen. The statistics menu will be displayed.

![Add Statistics Tab](../.gitbook/assets/screenshot-from-2018-07-29-11-55-54.png)

![Statistics Menu](../.gitbook/assets/screenshot-from-2018-07-29-12-03-48.png)

Then select the component for which statistics required from the six possible categories. As each component is selected, the list of possible Statistics Names that can be selected changes. It is also possible to searching for a specific statistic by typing the name of the statistic in the Filter field at the top of the menu. 

Up to 5 different statistics can be displayed simultaneously. Selecting a metric adds its graph to the Statistics view, together with a selector containing the category and name of the statistics which are displayed according to the appropriate units. 

Switching the active unit scale is performed by clicking on one of the inactive units displayed in the left bottom corner of the graph display box.

### Hiding/Deleting Statistics

To hide or delete statistics from a graph, mouse-over the selector and click either the Hide or Delete button appearing under the selector.

![Example of Hide/Delete Buttons ](../.gitbook/assets/screenshot-from-2018-07-29-13-13-57.png)

### Defining a Specific Timeline

To define a specific period of time \(start and end\) for the statistics to be displayed, click the From and To selectors appearing in the left corner of the graph display box. Then select the date of the statistics required from the calendar popup and the hours from the right scroller, or by using the up and down arrows that appear when hovering on the time selectors.

![From/To Time Selectors](../.gitbook/assets/screenshot-from-2018-07-29-14-44-31.png)

![Calendar Popup](../.gitbook/assets/screenshot-from-2018-07-29-15-01-39.png)

{% hint style="info" %}
**Note:** It is also possible to change the time period by dragging the graph left or right.
{% endhint %}

The Auto Refresh setting offers another option for defining a specific period of time. Activation of Auto Refresh is performed by clicking on one of the buttons displayed in the right bottom corner of the graph display box, according to the desired period \(hour, day or week\). The selected period of time for the statistics will be automatically updated every minute, until Auto Refresh is deactivated by clicking the 'x' button located at the top right of the Auto Refresh tool tip, or by defining a period of time using the time selector.   

![Auto Refresh Buttons](../.gitbook/assets/screenshot-from-2018-07-29-14-42-22.png)

### Obtaining a Summary of Events

To obtain a summary of events that occurred in a specific time period, click the events bubble displayed above the graph. The Events popup will be displayed.  Expand the popup in order to obtain a detailed list of events. Click on the icon next to each event to link to the selected event in the Events view screen.    

![Events Popup](../.gitbook/assets/screenshot-from-2018-07-29-14-57-57.png)

## Working with Statistics Using the CLI

**Command:** `weka stats`

Use the following command line to obtain statistics definition information:  
`weka stats list-types`

{% hint style="info" %}
**Note:** This command can be filtered according to names or categories of statistics \(when the name or category are defined\).
{% endhint %}

Use the following command line to obtain the current performance status of the hosts:  
`weka stats realtime`

Use the following command line to manage filters and read statistics:  
`weka stats --start-time=<start> [--end-time=<end>] [--category=<category>]... [--stat=<stat>]... [--resolution-secs=<secs>] [--accumulated] [--node-ids=<node>...] [--param=<key:val>]... [--no-zeroes] [--show-internal] [--per-node]`  
or:

`weka stats --interval=<interval> [--category=<category>]... [--stat=<stat>]... [--resolution-secs=<secs>] [--accumulated] [--node-ids=<node>...] [--param=<key:val>]... [--no-zeroes] [--show-internal] [--per-node]`

**Parameters in Command Lines**

| **Name** | **Type** | **Value** | **Limitations** | **Mandatory** | **Default** |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `start` | String | Start time of the reported period | Valid date and time\* | Yes |  |
| `end` | String | End time of the reported period | Valid date and time\* | No | Current time |
| `interval**` | String | Period of time to be reported | Valid interval in seconds \(positive integer number\) | Yes |  |
| `category` | String | Specific categories for retrieval of appropirate statistics | Valid existing categories: CPU, Object Store, Operations, Operations \(NFS\), Operations \(Driver\), SSD  | No | All |
| `stat` | String | Statistics names | Valid statistics names | No | All |
| `secs` | String | Length of each interval in the reported period | Must be multiples of 60 seconds | No | 60 seconds |
| `nodes` | String | Node id | Valid node-id | No | All |
| `key:val` | String | A pair of key and value, where `key` is a statistics parameterization type and `val` is a valid parameterization value for that type | Valid parameterization type and value | No |  |

{% hint style="info" %}
**Notes:**

\*Refer to Datetime Switches Syntax section in `weka --help-syntax` for help regarding datetime typed switches.

\*\*Relevant to the second command.
{% endhint %}

**Optional Flags in Command Line**

`[--accumulated]`: Displays accumulated statistics, not rate statistics

`[--no-zeroes]`: Filters results where the value is 0

`[--show-internal]`: Displays internal statistics

`[--per-node]`: Does not aggregate statistics across nodes

## List of Statistics Collected

This section details the statistics collected to analyze system performance and determine the source of any problems as the WekaIO system runs, according to the following five categories: Operations \(NFS\), Operations \(Driver\), Object Storage, SSD and CPU. When each category is selected, a list of the possible statistics that can be selected is displayed.

{% hint style="info" %}
**Note:** All statistics are averaged over 1 second intervals. Consequently, "total" or other aggregates relate to a specific minute.
{% endhint %}

### Operations \(NFS\) Statistics

| Statistic | Description |
| :--- | :--- |
| ACCESS\_OPS \(total\) | The number of checks of access permissions \(that a specified user has to a filesystem object\) performed. |
| ACCESS\_Latency \(per operation\) | The time spent performing access permission checks that a specified user has to a filesystem. |
| COMMIT\_OPS \(total\) | The number of commit operations of cached data on a server to stable storage. |
| COMMIT\_Latency \(per operation\) | The time spent committing cached data on a server to stable storage. |
| CREATE\_OPS \(total\) | The number of regular file creation operations.  |
| CREATE\_Latency \(per operation\) | The time spent performing regular file creation operations. |
| FSINFO\_OPS \(total\) | The number of operations performed to retrieve nonvolatile filesystem state information and general information about the NFS version 3 protocol server implementation. |
| FSINFO\_Latency \(per operation\) | The time spent retrieving nonvolatile filesystem state information and general information about the NFS version 3 protocol server implementation. |
| GETATTR\_OPS \(total\) | The number of file attributes retrieved for a specified filesystem object.  |
| GETATTR\_Latency \(per operation\) | The time spent retrieving file attributes for a specified filesystem object.  |
| LINK\_OPS \(total\) | The number of hard links created from files to objects in the directory. The link.dir files and link.dir must reside on the same filesystem and server. |
| LINK\_Latency \(per operation\) | The time spent creating hard links from files to objects in the directory. |
| LOOKUP\_OPS \(total\) | The number of searches for specific names in a directory and returns of the file handles for the corresponding filesystem objects. |
| LOOKUP\_Latency \(per operation\) | The time spent searching for specific names in a directory and returns of the file handles for the corresponding filesystem objects. |
| MKDIR\_OPS \(total\) | The number of new directories created. |
| MKDIR\_Latency \(per operation\) | The time spent creating new directories. |
| MKNOD\_OPS \(total\) | The number of new special files \(device files or named pipes\) created. |
| MKNOD\_Latency \(per operation\) | The time spent creating new special files \(device files or named pipes\). |
| NFS write sizes \(total\) | Histogram of NFS write sizes. |
| NFS read sizes \(total\) | Histogram of NFS read sizes. |
| OPS \(total\) | The total number of operations. |
| PATHCONF\_OPS \(total\) | The number of retrievals of the PATHCONF information for a file or directory. If the FSF\_HOMOGENEOUS bit is set in SFINFO3resok.properties, the PATHCONF information will be the same for all files and directories in the exported filesystem in which this file or directory resides. |
| PATHCONF\_Latency \(per operation\) | The time spent retrieving PATHCONF information for a file or directory. |
| READ\_Bytes \(total\) | The number of bytes read from a file. |
| READ\_Latency \(per read\) | The time spent reading bytes from a file. |
| READ\_Duration \(total\) | Histogram of the time spent performing read operations. |
| READDIR\_OPS \(total\) | The total number of retrieval operations attempted i.e., retrieval of a variable number of entries, in sequence, from a directory and return of the name and file identifier for each, with information allowing the request of additional directory entries in a subsequent READDIR request. |
| READDIR\_Latency \(per operation\) | The time spent performing retrieval operations. |
| READLINK\_OPS \(total\) | The total number of reads performed on data associated with a symbolic link i.e., data that is not interpreted when created, but just stored. |
| READLINK\_Latency \(per operation\) | The time spent performing read operations on data associated with a symbolic link. |
| READS \(total\) | The total number of read operations. |
| REMOVE\_OPS \(total\) | The number of entries removed \(deleted\) from a directory \(if the entry in the directory was the last reference to the corresponding filesystem object, the object may be destroyed\). |
| REMOVE\_Latency \(per operation\) | The time spent removing \(deleting\) entries from a directory. |
| RENAME\_OPS \(total\) | The number of file or directory renames performed \(operation must be atomic to the client\). The To and From directories must reside on the same filesystem and server. |
| RENAME\_Latency \(per operation\) | The time spent renaming files or directories.  |
| SETATTR\_OPS \(total\) | The number of filesystem object attributes set on the server. |
| SETATTR\_Latency \(per operation\) | The time spent setting filesystem object attributes on the server. |
| STATFS\_OPS \(total\) | The number of operations performed to retrieve static filesystem information. |
| STATFS\_Latency \(per operation\) | The time spent retrieving static filesystem information. |
| SYMLINK\_OPS \(total\) | The number of symbolic links created. |
| SYMLINK\_Latency \(per operation\) | The time spent creating symbolic links. |
| Throughput \(total\) | The total number byte reads/writes. |
| WRITE\_Bytes \(total\) | The number of bytes written to a file. |
| WRITE\_Latency \(per write\) | The time spent writing bytes to a file. |
| WRITE\_Duration \(total\) | Histogram of the time spent performing write operations. |
| WRITES \(total\) | The total number of write operations. |

### Operations \(Driver\) Statistics

| Statistic | Description |
| :--- | :--- |
| Direct Read Sizes \(total\) | Histogram of the sizes of read operations that were not cached. |
| Direct Write Sizes \(total\) | Histogram of the sizes of write operations that were not cached. |
| FILEATOMICOPEN OPS \(total\) | The number of atomic open operations \(operations that atomically create and open a file\). |
| FILEATOMICOPEN Latency \(per operation\) | The time spent on atomic open operations. |
| FILEOPEN OPS \(total\) | The number of file open operations. |
| FILEOPEN Latency \(per operation\) | The time spent on file open operations. |
| FILECLOSE OPS \(total\) | The number of file close operations. |
| FILECLOSE Latency \(per operation\) | The time spent on file close operations. |
| FLOCK OPS \(total\) | The number of file lock operations. |
| FLOCK Latency \(per operation\) | The time spent on file lock operations \(without the time spent waiting for the lock to be granted\). |
| GETATTR\_OPS \(total\) | The number of file attributes retrieved for a specified filesystem object.  |
| GETATTR\_Latency \(per operation\) | The time spent retrieving file attributes for a specified filesystem object.  |
| IOCTL\_OBS\_PREFETCH OPS \(total\) | The number of OBS prefetch operations. |
| IOCTL\_OBS\_PREFETCH Latency \(per operation\) | The time spent on OBS prefetch operations. |
| LINK\_OPS \(total\) | The number of hard links created from files to objects in the directory. The link.dir files and link.dir must reside on the same filesystem and server. |
| LINK\_Latency \(per operation\) | The time spent creating hard links from files to objects in the directory. |
| LOOKUP\_OPS \(total\) | The number of searches for specific names in a directory and returns of the file handles for the corresponding filesystem objects. |
| LOOKUP\_Latency \(per operation\) | The time spent searching for specific names in a directory and returns of the file handles for the corresponding filesystem objects. |
| MKNOD\_OPS \(total\) | The number of new special files \(device files or named pipes\) created. |
| MKNOD\_Latency \(per operation\) | The time spent creating new special files \(device files or named pipes\). |
| OPS \(total\) | The total number of operations. |
| Reads \(total\) | The total number of data read operations. |
| Read Bytes \(total\) | The number of bytes read from a file. |
| Read Duration \(total\) | Histogram of the time spent performing read operations. |
| Read Latency \(per read\) | The time spent reading bytes from a file. |
| Read Sizes \(total\) | Histogram of sizes of read operations. |
| READDIR\_OPS \(total\) | The total number of retrieval operations attempted i.e., retrieval of a variable number of entries, in sequence, from a directory and return of the name and file identifier for each, with information allowing the request of additional directory entries in a subsequent READDIR request. |
| READDIR\_Latency \(per operation\) | The time spent performing retrieval operations. |
| RENAME\_OPS \(total\) | The number of file or directory renames performed \(operation must be atomic to the client\). The To and From directories must reside on the same filesystem and server. |
| RENAME\_Latency \(per operation\) | The time spent renaming files or directories.  |
| RMDIR OPS \(total\) | The number of directory deletes performed. |
| RMDIR Latency \(per operation\) | The time spent deleting directories. |
| READLINK\_OPS \(total\) | The total number of reads performed on data associated with a symbolic link i.e., data that is not interpreted when created, but just stored. |
| READLINK\_Latency \(per operation\) | The time spent performing read operations on data associated with a symbolic link. |
| STATFS\_OPS \(total\) | The number of operations performed to retrieve static filesystem information. |
| STATFS\_Latency \(per operation\) | The time spent retrieving static filesystem information. |
| SETATTR OPS \(total\) | The number of explicit attribute changes performed by the user \(chown/chmod operations\). |
| SETATTR Latency \(per operation\) | The time spent on attributes changing. |
| SYMLINK\_OPS \(total\) | The number of symbolic links created. |
| SYMLINK\_Latency \(per operation\) | The time spent creating symbolic links. |
| Throughput \(total\) | The total number byte reads/writes. |
| UNLINK OPS \(total\) | The number of file deletion operations. |
| UNLINK Latency \(per operation\) | The time spent deleting files. |
| Writes \(total\) | The total number of write operations. |
| Write Bytes \(total\) | The number of bytes written to a file. |
| Write Duration \(total\) | Histogram of the time spent performing write operations. |
| Write Latency \(per write\) | The time spent writing bytes to a file. |
| Write Sizes \(total\) | The total amount of write operations. |

### Object Store Statistics

| Statistic | Description |
| :--- | :--- |
| Failed\_Object\_Deletes \(total\) | The number of HTTP DELETE \(remove\) operations attempted on all object stores. |
| Failed\_Object\_Downloads \(total\) | The number of HTTP GET \(download\) operations that have failed on all object stores. |
| Failed\_Object\_Operations \(total\) | The sum of 3 other statistics \(Failed Object Downloads, Failed Object Uploads and Failed Object Deletes\). |
| Failed\_Object\_Uploads \(total\) | The number of failed HTTP PUT \(upload\) operations on all object stores. |
| Object\_Delete\_Latency \(per delete\) | The time spent performing HTTP DELETE \(remove\) operations on all object stores. |
| Object\_Deletes \(total\) | The number of HTTP DELETE \(remove\) operations attempted on all object stores. |
| Object\_Downloads \(total\) | The number of HTTP GET \(download\) operations attempted on all object stores. |
| Object\_Download\_Duration \(total\) | Histogram of the time spent performing HTTP GET \(download\) operations on all object stores. |
| Object\_Download\_Latency \(per download\) | The time spent performing HTTP GET \(download\) operations on all object stores. |
| Object\_Operations \(total\) | The sum of 3 other statistics \(Object Downloads, Object Uploads and Object Deletes\). |
| Object\_Uploads \(total\) | The number of HTTP PUT \(upload\) operations attempted on all object stores. |
| Object\_Upload\_Duration \(total\) | Histogram of the time spent performing HTTP PUT \(upload\) operations on all object stores. |
| Object\_Upload\_Latency \(per upload\) | The time spent performing HTTP PUT \(upload\) operations on all object stores. |
| OBS\_Read\_Bytes \(total\) | Deprecated alias for the object store Read Bytes statistic. |
| OBS\_Write\_Bytes \(total\) | Deprecated alias for the object store Write Bytes statistic. |
| Read\_Bytes \(total\) | The total number of bytes downloaded \(even in eventually failed operations\) on all object stores. |
| Write\_Bytes \(total\) | The total number of bytes attempted to upload on all object stores. |

### SSD Statistics

| Statistic | Description |
| :--- | :--- |
| Drive\_Read\_Operations \(total\) | The number of read requests seen by the drive \(total number, not an average\). |
| Drive\_Read\_Latency \(per IO\) | Histogram of the time spent performing read request operations. |
| Drive\_Write\_Operations \(total\) | The number of write requests seen by the drive \(total number, not an average\). |
| Drive\_Write\_Latency \(per IO\) | Histogram of the time spent performing write request operations. |
| SSD\_Blocks\_Read \(total\) | The number of data blocks read from the drive. This is only user data requests and does not include any metadata operations performed. Counted in blocks of 4K. |
| SSD\_Blocks\_Written \(total\) | The number of blocks written to the user data \(does not include metadata writes\). |
| SSD\_Media\_Errors \(total\) | The total number of SSD media errors in 1 minute. |
| SSD\_Non-Media\_Errors \(total\) | Non-media errors in NVME can be easily distinguished, while all errors in SATA/SAS are considered non-media errors. Media errors are treated differently and can be corrected; however, non-media errors are fatal to the request and can only be recovered by parities. |
| SSD\_Reads \(total\) | The number of read requests performed for the user data. These can have multiple blocks and can be broken into multiple drive requests. |
| SSD\_Read\_Errors \(total\) | The number of read errors observed in the minute of the SSD errors. |
| SSD\_Read\_Latency \(per read\) | The latency of user data read requests includes the execution time on the disk and the queue time before the disk. If a single request has been broken into multiple requests, they can be executed in parallel or serially, depending on the disk load and internal behavior. |
| SSD\_Writes \(total\) | The number of SSD write operations to the user data. |
| SSD\_Write\_Latency \(per write\) | The average time the drive required to service the write requests received \(for all sizes, a single user write can be broken into multiple drive writes; this relates to the writes observed by the drive. |
| SSD\_Write\_Errors \(total\) | The number of write errors observed in the minute of the SSD errors. |

### CPU Statistics

| Statistic | Description |
| :--- | :--- |
| CPU\_Utilization \(average\) |  The average percentage of CPU time utilized by WekaIO \(from the cores used by WekaIO\). |









