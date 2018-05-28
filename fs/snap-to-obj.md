# Snap-To-Obj

## Uploading a Snapshot

#### Uploading a Snapshot Using the UI

To upload a snapshot to its filesystem's configured object store, in the main snapshot view screen, select the filesystem snapshot to be uploaded and click Upload To Object. The Snapshot Upload confirmation window will be displayed.

![Snapshot Upload Confirmation Window](../.gitbook/assets/snapshot-upload-confirmation-window.jpg)

Click Upload to upload the snapshot to the object store.

#### Uploading a Snapshot Using the CLI

**Command: `snapshot-upload`**

Use the following command line to update an existing snapshot:

`wcli snapshot-upload --file-system=<fs> --snapshot=<snapshot>`

**Parameters in Command Line**

| **Name** | **Type** | **Value** | **Limitations** | **Mandatory** | **Default** |
| --- | --- | --- |
| `<fs>` | String | Name of the filesystem |  | Yes |  |
| `<snapshot>` | String | Name of snapshot to upload | Has to be a snapshot of the &lt;fs&gt; filesystem | Yes |  |

## Creating a Filesystem from an Uploaded Snapshot

#### Creating a Filesystem from a Snapshot Using the UI

To create a filesystem from an uploaded snapshot, switch the From Uploaded Snapshot field in the Filesystem Creation dialog box to On. The Create Filesystem dialog box is displayed.

![Create Filesystem from an Uploaded Snapshot Dialog Box](../.gitbook/assets/create-fs-from-snapshot-dialog-box.jpg)

Define all the fields and enter the location of the snapshot to be used in the Object Store Locator field.

#### Creating a Filesystem from a Snapshot Using the CLI

**Command: `filesystem-download`**

Use the following command line to update an existing snapshot:

`wcli filesystem-download --name=<fs> --group-name=<group> --ssd-capacity=<ssd-capacity> --total-capacity=<total-capacity> --locator=<locator>`

**Parameters in Command Line**

| **Name** | **Type** | **Value** | **Limitations** | **Mandatory** | **Default** |
| --- | --- | --- | --- | --- | --- |
| `<fs>` | String | Name of filesystem to create |  | Yes |  |
| `<group>` | String | Name of filesystem-group to place the new filesystem in |  | Yes |  |
| `<ssd-capacity>` | Capacity | SSD capacity of the downloaded filesystem |  | Yes |  |
| `<total-capacity>` | Capacity | Total capacity of the downloaded filesystem |  | Yes |  |
| `<locator>` | String | The object-store locator obtained from a previously successful snapshot upload |  | Yes |  |





