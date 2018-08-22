Connects to Amazon ec2 from Ballerina. 

# Package Overview

The Amazon ec2 connector allows you to run, describe, and terminate the ec2 instances through the Amazon ec2 REST API.

**Instance Operations**

The `kana/amazonec2` package contains operations that work with instances. You can launch, describe, and stop the 
instances with these operations.

## Compatibility
|                    |    Version     |  
|:------------------:|:--------------:|
| Ballerina Language |   0.981.0      |
| Amazon ec2 API     |   2016-11-15   |

## Sample

First, import the `kana/amazonec2` package into the Ballerina project.

```ballerina
import kana/amazonec2;
```
The Amazon ec2 connector can be instantiated using the accessKeyId, secretAccessKey and region, 
in the Amazon ec2 client config.

**Obtaining Access Keys to Run the Sample**

 1. Create a amazon account by visiting <https://aws.amazon.com/ec2/>
 2. Obtain the following parameters
   * Access key ID.
   * Secret access key.
   * Desired Server region.

You can now enter the credentials in the Amazon ec2 client config:
```ballerina
endpoint amazonec2:Client amazonEC2Client {
    accessKeyId:"<your_access_key_id>",
    secretAccessKey:"<your_secret_access_key>",
    region:"<your_region>"
};
```
The `runInstances` function launches the specified number of instances using an AMI for which you have permissions.
You can specify the maximum number of instances to launch and the minimum number of instances to launch.

   `var runInstancesResponse = amazonEC2Client->runInstances(imgId, maxCount, minCount);`
   
If the instance started successfully, the response from the `runInstances` function is a `EC2Instance` array with
one or more launched instance ids. If it is unsuccessful, the response is a `AmazonEC2Error`. 
The `match` operation can be used to handle the response if an error occurs.

```ballerina
    match newInstances {
        amazonec2:EC2Instance[] insts => {
            io:println("Successfully run the instance : ");
            io:println(insts);
        }
        amazonec2:AmazonEC2Error e => io:println(e);
    }
```

The `describeInstances` function describes one or more of your instances.. It returns a `EC2Instance` array
with reservation ids if it is successful or the response is a `AmazonEC2Error`. 

```ballerina
  match describeInstances {
        amazonec2:EC2Instance[] insts => {
            io:println("Successfully describe the instance : ");
            io:println(insts);
        }
        amazonec2:AmazonEC2Error e => io:println(e);
    }
```
The `terminateInstances` function shuts down one or more instances. It returns a `EC2Instance` array
with terminated instance ids if it is successful or the response is a `AmazonEC2Error`. 

```ballerina
match terminated {
        amazonec2:EC2Instance[] insts => {
            io:println("Successfully terminate the instance : ");
            io:println(insts);
        }
        amazonec2:AmazonEC2Error e => io:println(e);
    }
```

The `createImage` function will create an image. It returns a `Image` object
with created image id if it is successful or the response is a `AmazonEC2Error`.

```ballerina
match newImage {
        amazonec2:Image img => {
            io:println(" Successfully create a new image : ");
            io:println(img);
        }
        amazonec2:AmazonEC2Error e => io:println(e);
    }
```

The `describeImages` function will describe the images . It returns an `Image` array
with image details if it is successful or the response is a `AmazonEC2Error`.

```ballerina
match describeImageResponse {
        amazonec2:Image[] image => {
            io:println(" Successfully describe the image : ");
            io:println(image);
        }
        amazonec2:AmazonEC2Error e => io:println(e);
    }
```

The `describeImageAttribute` function will describe an image with specified attributes . It returns an `ImageAttribute` response based on the attribute name if it is successful or the response is a `AmazonEC2Error`.

```ballerina
match imageAttributeResponse {
        amazonec2:ImageAttribute attribute => {
            io:println(" Successfully describes an image with an attribute : ");
            io:println(attribute);
        }
        amazonec2:AmazonEC2Error e => io:println(e);
    }
```

The `deRegisterImage` function will deregisters the specified AMI.
After you deregister an AMI, it can't be used to launch new instances;
however,it doesn't affect any instances that you've already launched from the AMI.
It returns true as a service response if it is successful or the response is a `AmazonEC2Error`.

```ballerina
match deRegisterImage {
        amazonec2:EC2ServiceResponse serviceResponse => {
            io:println(" Successfully de register the image : ");
            io:println(serviceResponse);
        }
        amazonec2:AmazonEC2Error e => io:println(e);
    }

```
The `copyImage` function will Initiates the copy of an AMI from the specified source region to the current region.
 It returns an `Image` object with copied image details if it is successful or the response is a `AmazonEC2Error`.

```ballerina
match copyImage {
        amazonec2:Image image => {
            io:println(" Successfully copy the image to the current region : ");
            io:println(image);
        }
        amazonec2:AmazonEC2Error e => io:println(e);
    }
```
The `createVolume` creates an EBS volume that can be attached to an instance in the same Availability Zone.
 It returns `Volume` object with created volume details if it is successful or the response is a `AmazonEC2Error`.

```ballerina
match newVolume {
        amazonec2:Volume volume => {
            io:println(" Successfully create a new volume : ");
            io:println(volume);
        }
        amazonec2:AmazonEC2Error e => io:println(e);
    }
```

The `attachVolume` attaches an EBS volume to a running or stopped instance and exposes it to the instance with the specified device name.
 It returns an `AttachmentInfo` object with attachment details if it is successful or the response is a `AmazonEC2Error`.

```ballerina
match attachmentInfo {
        amazonec2:AttachmentInfo attachment => {
            io:println(" Successfully attaches volume : ");
            io:println(attachment);
        }
        amazonec2:AmazonEC2Error e => io:println(e);
    }
```
The `detachVolume` detaches an EBS volume from an instance.
 It returns an `AttachmentInfo` object with specified details if it is successful or the response is a `AmazonEC2Error`.

```ballerina
  match detachmentInfo {
        amazonec2:AttachmentInfo detachInfo => {
            io:println(" Successfully detach the volume : ");
            io:println(detachInfo);
        }
        amazonec2:AmazonEC2Error e => io:println(e);
    }
```

The `createSecurityGroup` creates a security group.
It returns `SecurityGroup` object with group id if it is successful or the response is a `AmazonEC2Error`.

```ballerina
    match newSecurityGroup {
         amazonec2:SecurityGroup securityGroup => {
             io:println(" Successfully create a new security group : ");
             io:println(securityGroup);
         }
         amazonec2:AmazonEC2Error e => io:println(e);
     }

```

The `deleteSecurityGroup` deletes a security group. Can specify either the security group name or the security group ID.
But group id is required for a non default VPC.
It returns an true as an service response if it is successful or the response is a `AmazonEC2Error`.

```ballerina
    match deleteSecurityGroupResponse {
        amazonec2:EC2ServiceResponse serviceResponse => {
            io:println(" Successfully  delete the security group : ");
            io:println(serviceResponse);
        }
        amazonec2:AmazonEC2Error e => io:println(e);
    }
```
## Example
```ballerina
import ballerina/io;
import kana/amazonec2;
import ballerina/runtime;

function main(string... args) {
    endpoint amazonec2:Client amazonEC2Client {
        accessKeyId: "",
        secretAccessKey: "",
        region: "",
        clientConfig: {}
    };

    amazonec2:EC2Instance[] arr;
    string imgId = "ami-0ce0c1ehg8bebc34";

    var newInstances = amazonEC2Client->runInstances(imgId, 1, 1);
    match newInstances {
        amazonec2:EC2Instance[] insts => {
            io:println("Successfully run the instance : ");
            io:println(insts);
            arr = insts;
        }
        amazonec2:AmazonEC2Error e => io:println(e);
    }

    runtime:sleep(20000); // wait for a bit before terminating the new instance

    string[] instIds = arr.map((amazonec2:EC2Instance inst) => string {return inst.id;});

    var describeInstances = amazonEC2Client->describeInstances(instIds[0]);
    match describeInstances {
        amazonec2:EC2Instance[] insts => {
            io:println("Successfully describe the instance : ");
            io:println(insts);
        }
        amazonec2:AmazonEC2Error e => io:println(e);
    }

    var terminated = amazonEC2Client->terminateInstances(instIds[0]);

    match terminated {
        amazonec2:EC2Instance[] insts => {
            io:println("Successfully terminate the instance : ");
            io:println(insts);
        }
        amazonec2:AmazonEC2Error e => io:println(e);
    }
}
```

**Note**

To test the following sample, create `ballerina.conf` file inside `sample location`, with following keys and provide values for the variables.

    ```.conf
    ACCESS_KEY_ID="<your_access_key_id>"
    SECRET_ACCESS_KEY="<your_secret_access_key_id>"
    REGION="<your_current_region>"
    IMAGE_ID="<The ID of the AMI, which is required to launch an instance>"
    SOURCE_IMAGE_ID="<The ID of the AMI to copy>"
    SOURCE_REGION="<The name of the region that contains the AMI to copy>"
    IMAGE_NAME="<A name for the new image>"
    ZONE_NAME="<The Availability Zone in which to create the volume>"
    DEVICE_NAME="<The device name to attach the volume (for example, /dev/sdh or xvdh)>"
    GROUP_NAME="<The name of the security group>"
    ```


## Example
```
import ballerina/io;
import kana/amazonec2;
import ballerina/runtime;
import ballerina/config;

function main(string... args) {
    string accessKeyId = config:getAsString("ACCESS_KEY_ID");
    string secretAccessKey = config:getAsString("SECRET_ACCESS_KEY");
    string region = config:getAsString("REGION");
    string imageId = config:getAsString("IMAGE_ID");
    string sourceImageId = config:getAsString("SOURCE_IMAGE_ID");
    string sourceRegion = config:getAsString("SOURCE_REGION");
    string groupName = config:getAsString("GROUP_NAME");
    string imageName = config:getAsString("IMAGE_NAME");
    string zoneName = config:getAsString("ZONE_NAME");
    string deviceName = config:getAsString("DEVICE_NAME");

    callAmazonEC2Methods(accessKeyId, secretAccessKey, region, imageId, groupName, zoneName,
        deviceName, imageName, sourceImageId, sourceRegion );
}

function callAmazonEC2Methods(string accessKeyId, string secretAccessKey, string region, string imageId,
                                 string groupName, string zoneName, string deviceName,
                                 string imageName, string sourceImageId, string sourceRegion) {
    endpoint amazonec2:Client amazonEC2Client {
        accessKeyId: accessKeyId,
        secretAccessKey: secretAccessKey,
        region: region,
        clientConfig: {}
    };
    amazonec2:EC2Instance[] arr;
    string testGroupId;

    var newSecurityGroup = amazonEC2Client->createSecurityGroup(groupName, "Test Ballerina Group");
    match newSecurityGroup {
        amazonec2:SecurityGroup securityGroup => {
            io:println(" Successfully create a new security group : ");
            io:println(securityGroup);
            testGroupId = securityGroup.groupId;
        }
        amazonec2:AmazonEC2Error e => io:println(e);
    }

    var newInstances = amazonEC2Client->runInstances(imageId, 1, 1, securityGroupId = [testGroupId]);
    match newInstances {
        amazonec2:EC2Instance[] insts => {
            io:println("Successfully run the instance : ");
            io:println(insts);
            arr = insts;
        }
        amazonec2:AmazonEC2Error e => io:println(e);
    }

    string[] instIds = arr.map((amazonec2:EC2Instance inst) => string {return inst.id;});

    runtime:sleep(30000); // wait a bit until launch an instance.

    var describeInstances = amazonEC2Client->describeInstances(instIds[0]);
    match describeInstances {
        amazonec2:EC2Instance[] insts => {
            io:println("Successfully describe the instance : ");
            io:println(insts);
        }
        amazonec2:AmazonEC2Error e => io:println(e);
    }

    var newImage = amazonEC2Client->createImage(instIds[0], imageName);
    string id;
    match newImage {
        amazonec2:Image img => {
            io:println(" Successfully create a new image : ");
            id = img.imageId;
            io:println(img);
        }
        amazonec2:AmazonEC2Error e => io:println(e);
    }

    runtime:sleep(60000);// wait until the image creates.
    var deRegisterImage = amazonEC2Client->deRegisterImage(untaint id);

    match deRegisterImage {
        amazonec2:EC2ServiceResponse serviceResponse => {
            io:println(" Successfully de register the image : ");
            io:println(serviceResponse);
        }
        amazonec2:AmazonEC2Error e => io:println(e);
    }

    var describeImageResponse = amazonEC2Client->describeImages(imageId);

    match describeImageResponse {
        amazonec2:Image[] image => {
            io:println(" Successfully describe the image : ");
            io:println(image);
        }
        amazonec2:AmazonEC2Error e => io:println(e);
    }

    var imageAttributeResponse = amazonEC2Client->describeImageAttribute(imageId, "description");

    match imageAttributeResponse {
        amazonec2:ImageAttribute attribute => {
            io:println(" Successfully describes an image with an attribute : ");
            io:println(attribute);
        }
        amazonec2:AmazonEC2Error e => io:println(e);
    }

    var copyImage = amazonEC2Client->copyImage("Copy_Image", sourceImageId, sourceRegion);

    match copyImage {
        amazonec2:Image image => {
            io:println(" Successfully copy the image to the current region : ");
            io:println(image);
        }
        amazonec2:AmazonEC2Error e => io:println(e);
    }

    var newVolume = amazonEC2Client->createVolume(zoneName, size = 8);

    string volumeId;
    match newVolume {
        amazonec2:Volume volume => {
            io:println(" Successfully create a new volume : ");
            volumeId = volume.volumeId;
            io:println(volume);
        }
        amazonec2:AmazonEC2Error e => io:println(e);
    }

    runtime:sleep(30000);// wait for a bit before attaching to a new volume until it creates.

    var attachmentInfo = amazonEC2Client->attachVolume(deviceName, instIds[0], volumeId);

    match attachmentInfo {
        amazonec2:AttachmentInfo attachment => {
            io:println(" Successfully attaches volume : ");
            io:println(attachment);
        }
        amazonec2:AmazonEC2Error e => io:println(e);
    }

    runtime:sleep(60000); // wait for a bit before detaching the new volume until the attachment completes.
    var detachmentInfo = amazonEC2Client->detachVolume(volumeId);

    match detachmentInfo {
        amazonec2:AttachmentInfo detachInfo => {
            io:println(" Successfully detach the volume : ");
            io:println(detachInfo);
        }
        amazonec2:AmazonEC2Error e => io:println(e);
    }

    var terminated = amazonEC2Client->terminateInstances(instIds[0]);

    match terminated {
        amazonec2:EC2Instance[] insts => {
            io:println("Successfully terminate the instance : ");
            io:println(insts);
        }
        amazonec2:AmazonEC2Error e => io:println(e);
    }

    runtime:sleep(100000); // wait for a bit before delete security group until the instance get terminates
    var deleteSecurityGroupResponse = amazonEC2Client->deleteSecurityGroup(groupId = testGroupId);

    match deleteSecurityGroupResponse {
        amazonec2:EC2ServiceResponse serviceResponse => {
            io:println(" Successfully  delete the security group : ");
            io:println(serviceResponse);
        }
        amazonec2:AmazonEC2Error e => io:println(e);
    }
}
```