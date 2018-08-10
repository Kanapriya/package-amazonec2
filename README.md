# Ballerina Amazon ec2 Connector

The Amazon ec2 connector allows you to access the Amazon ec2 REST API through ballerina. 
The following section provide you the details on connector operations.

## Compatibility
| Ballerina Language Version | Amazon ec2 API version  |
| -------------------------- | --------------------   |
| 0.981.0                    | 2016-11-15             |


The following sections provide you with information on how to use the Ballerina Amazon ec2 connector.

- [Contribute To Develop](#contribute-to-develop)
- [Working with Amazon ec2 Connector actions](#working-with-amazon-ec2-endpoint-actions)
- [Sample](#sample)

### Contribute To develop

Clone the repository by running the following command 
```shell
git clone https://github.com/Kanapriya/package-amazonec2.git
```

### Working with Amazon ec2 Connector 

First, import the `kana/amazonec2` package into the Ballerina project.

```ballerina
import kana/amazonec2;
```

In order for you to use the Amazon ec2 Connector, first you need to create a Amazonec2 Client endpoint.

```ballerina
   endpoint amazonec2:Client amazonEC2Client {
        accessKeyId: "",
        secretAccessKey: "",
        region: "",
        clientConfig:{}
    };
```

##### Sample

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

    string[] instanceArray = ["i-cddfe0", "i-12356"];
    var terminateInstancesResponse = amazonEC2Client->terminateInstances(instanceArray);
    match terminateInstancesResponse {
        amazonec2:InstanceList instance => {
            io:println(" Successfully terminate the instance : ");
            string instanceId = (instance.instanceSet[0].instanceId);
            io:println("Instance Id : " + instanceId);
        }
        amazonec2:AmazonEC2Error e => io:println(e);
    }
}
```