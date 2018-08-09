Connects to Amazon ec2 from Ballerina. 

# Package Overview

The Amazon ec2 connector allows you to start, stop, and monitor the ec2 instances through the Amazon ec2 REST API.

**Instance Operations**

The `kana/amazonec2` package contains operations that work with instances. You can start, stop, and monitor the 
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
The `startInstances` function starts an Amazon EBS-backed instance. You can give One or more instance IDs as an array.

   `var startInstancesResponse = amazonEC2Client->startInstances(instanceArray);`
   
If the instance started successfully, the response from the `startInstances` function is a `InstanceList` object with 
one or more started instance ids. If it is unsuccessful, the response is a `AmazonEC2Error`. 
The `match` operation can be used to handle the response if an error occurs.

```ballerina
 match startInstancesResponse {
        amazonec2:InstanceList instance => {
            io:println(" Successfully start the instance : ");
            string instanceId = (instance.instanceSet[0].instanceId);
            io:println("Started Instance Id : " + instanceId);
        }
        amazonec2:AmazonEC2Error e => io:println(e);
}
```

The `monitorInstances` function enables detailed monitoring for a running instance. It returns a `InstanceList` object 
with instance ids if it is successful or the response is a `AmazonEC2Error`. 

```ballerina
match monitorInstancesResponse {
        amazonec2:InstanceList instance => {
            io:println(" Successfully monitor the instance : ");
            string instanceId = (instance.instanceSet[0].instanceId);
            io:println("Instance Id : " + instanceId);
        }
        amazonec2:AmazonEC2Error e => io:println(e);
}
```
The `stopInstances` function stops an Amazon EBS-backed instance. It returns a `InstanceList` object 
with stopped instance ids if it is successful or the response is a `AmazonEC2Error`. 

```ballerina
match stopInstancesResponse {
        amazonec2:InstanceList instance => {
            io:println(" Successfully stop the instance : ");
            string instanceId = (instance.instanceSet[0].instanceId);
            io:println("Stoped Instance Id : " + instanceId);
        }
        amazonec2:AmazonEC2Error e => io:println(e);
}
```

## Example
```ballerina
import ballerina/io;
import kana/amazonec2;

function main(string... args) {
    endpoint amazonec2:Client amazonEC2Client {
        accessKeyId: "",
        secretAccessKey: "",
        region: "",
        clientConfig:{}
    };

    string[] instanceArray = ["i-05ec", "i-0aecd"];
    var startInstancesResponse = amazonEC2Client->startInstances(instanceArray);
    io:println(startInstancesResponse);
    match startInstancesResponse {
        amazonec2:InstanceList instance => {
            io:println(" Successfully start the instance : ");
            string instanceId = (instance.instanceSet[0].instanceId);
            io:println("Started Instance Id : " + instanceId);
        }
        amazonec2:AmazonEC2Error e => io:println(e);
    }

    var monitorInstancesResponse = amazonEC2Client->monitorInstances(instanceArray);
    io:println(monitorInstancesResponse);
    match monitorInstancesResponse {
        amazonec2:InstanceList instance => {
            io:println(" Successfully monitor the instance : ");
            string instanceId = (instance.instanceSet[0].instanceId);
            io:println("Instance Id : " + instanceId);
        }
        amazonec2:AmazonEC2Error e => io:println(e);
    }

    var stopInstancesResponse = amazonEC2Client->stopInstances(instanceArray);
    io:println(stopInstancesResponse);
    match stopInstancesResponse {
        amazonec2:InstanceList instance => {
            io:println(" Successfully stop the instance : ");
            string instanceId = (instance.instanceSet[0].instanceId);
            io:println("Stoped Instance Id : " + instanceId);
        }
        amazonec2:AmazonEC2Error e => io:println(e);
    }
}
```