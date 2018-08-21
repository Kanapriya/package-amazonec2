//
// Copyright (c) 2018, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
//
// WSO2 Inc. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.
//

import ballerina/io;
import ballerina/time;

documentation {
    The supported instance state by this package.
}
public type InstanceState "pending"|"running"|"shutting-down"|"terminated"|"stopping"|"stopped";

documentation {
    The supported volume type by this package.
}
public type VolumeType "standard"|"io1"|"gp2"|"sc1"|"st1";

documentation {
    The supported volume attachment status by this package.
}
public type VolumeAttachmentStatus "attaching"|"attached"|"detaching"|"detached"|"busy";

@final public InstanceState ISTATE_PENDING = "pending";
@final public InstanceState ISTATE_RUNNING = "running";
@final public InstanceState ISTATE_SHUTTING_DOWN = "shutting-down";
@final public InstanceState ISTATE_TERMINATED = "terminated";
@final public InstanceState ISTATE_STOPPING = "stopping";
@final public InstanceState ISTATE_STOPPED = "stopped";

@final public VolumeType TYPE_STANDARD = "standard";
@final public VolumeType TYPE_IO1 = "io1";
@final public VolumeType TYPE_GP2 = "gp2";
@final public VolumeType TYPE_SC1 = "sc1";
@final public VolumeType TYPE_ST1 = "st1";

@final public VolumeAttachmentStatus ATTACHING = "attaching";
@final public VolumeAttachmentStatus ATTACHED = "attached";
@final public VolumeAttachmentStatus DETACHING = "detaching";
@final public VolumeAttachmentStatus DETACHED = "detached";
@final public VolumeAttachmentStatus BUSY = "busy";

documentation {
    Define the AmazonEC2 Connector.
    E{{}}
    F{{amazonEC2Config}} - AmazonEC2 connector configurations
    F{{amazonEC2Connector}} - AmazonEC2 Connector object
}
public type Client object {

    public AmazonEC2Configuration amazonEC2Config = {};
    public AmazonEC2Connector amazonEC2Connector = new;

    documentation {
        AmazonEC2 connector endpoint initialization function
        P{{config}} - AmazonEC2 connector configuration
    }
    public function init(AmazonEC2Configuration config);

    documentation {
        Return the AmazonEC2 connector client
        R{{}} - AmazonEC2 connector client
    }
    public function getCallerActions() returns AmazonEC2Connector;

};

documentation {
        Define the Amazon ec2 connector.
        F{{uri}} - The Amazon ec2 endpoint
        F{{accessKeyId}} - The access key of Amazon ec2 account
        F{{secretAccessKey}} - The secret key of the Amazon ec2 account
        F{{region}} - The AWS region
        F{{clientEndpoint}} - HTTP client endpoint
}
public type AmazonEC2Connector object {
    string uri;
    public string accessKeyId;
    public string secretAccessKey;
    public string region;
    public http:Client clientEndpoint = new;

    documentation {
        Launches the specified number of instances using an AMI for which you have permissions.
        P{{imgId}} -  The ID of the AMI which is required to launch an instance
        P{{maxCount}} - The maximum number of instances to launch
        P{{minCount}} - The minimum number of instances to launch
        P{{securityGroup}} - [EC2-Classic, default VPC] One or more security group names
        P{{securityGroupId}} - One or more security group IDs
        R{{}} - If success, returns EC2Instance of launched instances, else returns AmazonEC2Error object.}
    public function runInstances(string imgId, int maxCount, int minCount, string[]? securityGroup = (),
                                 string[]? securityGroupId = ()) returns EC2Instance[]|AmazonEC2Error;

    documentation {
        Describes one or more of your instances.
        R{{}} If successful, returns EC2Instance[] with zero or more instances, else returns an AmazonEC2Error.}
    public function describeInstances(string... instanceIds) returns EC2Instance[]|AmazonEC2Error;

    documentation {
        Shuts down one or more instances.
        R{{}} - If success, returns EC2Instance with terminated instances, else returns AmazonEC2Error object.}
    public function terminateInstances(string... instanceArray) returns EC2Instance[]|AmazonEC2Error;

    documentation {
        Create image.
        P{{instanceId}} -  The ID of the instance which is created with the particular image id
        P{{name}} - The name of the image
        R{{}} If successful, returns Image with image id, else returns an AmazonEC2Error.}
    public function createImage(string instanceId, string name) returns Image|AmazonEC2Error;

    documentation {
        Describe images.
        R{{}} If successful, returns Image[] with image details, else returns an AmazonEC2Error.}
    public function describeImages(string... imageIdArr) returns Image[]|AmazonEC2Error;

    documentation {
        Deregisters the specified AMI. After you deregister an AMI, it can't be used to launch new instances; however,
        it doesn't affect any instances that you've already launched from the AMI.
        P{{imageId}} The ID of the AMI
        R{{}} If successful, returns success response, else returns an AmazonEC2Error.}
    public function deRegisterImage(string imageId) returns EC2ServiceResponse|AmazonEC2Error;

    documentation {
        Describes the specified attribute of the specified AMI. You can specify only one attribute at a time.
        P{{imageId}} The ID of the AMI
        P{{attribute}} The specific attribute of the image.
        R{{}} If successful, returns success response, else returns an AmazonEC2Error.}
    public function describeImageAttribute(string imageId, string attribute) returns ImageAttribute |AmazonEC2Error;

    documentation {
        Initiates the copy of an AMI from the specified source region to the current region.
        P{{name}} The name of the new AMI in the destination region
        P{{sourceImageId}} The ID of the AMI to copy
        P{{sourceRegion}} The name of the region that contains the AMI to copy
        R{{}} If successful, returns Image object, else returns an AmazonEC2Error.}
    public function copyImage(string name, string sourceImageId, string sourceRegion) returns Image |AmazonEC2Error;

    documentation {
        Creates a security group.
        P{{groupName}} The name of the security group
        P{{groupDescription}} A description for the security group
        P{{vpcId}} The ID of the VPC, Required for EC2-VPC
        R{{}} If successful, returns SecurityGroup object with groupId, else returns an AmazonEC2Error.}
    public function createSecurityGroup(string groupName, string groupDescription, string? vpcId = ())
                        returns SecurityGroup |AmazonEC2Error;

    documentation {
        Deletes a security group. Can specify either the security group name or the security group ID.
        But group id is required for a non default VPC.
        P{{groupId}} The id of the security group
        P{{groupName}} The name of the security group
        R{{}} If successful, returns success response, else returns an AmazonEC2Error.}
    public function deleteSecurityGroup(string? groupId = (), string? groupName = ())
                        returns EC2ServiceResponse |AmazonEC2Error;

    documentation {
        Creates an EBS volume that can be attached to an instance in the same Availability Zone.
        P{{availabilityZone}} The Availability Zone in which to create the volume
        P{{size}} The size of the volume, in GiBs
        P{{snapshotId}} The snapshot from which to create the volume
        P{{volumeType}} The volume type
        R{{}} If successful, returns Volume object with created volume details, else returns an AmazonEC2Error.}
    public function createVolume(string availabilityZone, int? size = (), string? snapshotId = (),
                                 string? volumeType = ()) returns Volume|AmazonEC2Error;

    documentation {
        Attaches an EBS volume to a running or stopped instance and exposes it to the instance with the
        specified device name.
        P{{device}} The device name
        P{{instanceId}} The ID of the instance
        P{{volumeId}} The ID of the EBS volume. The volume and instance must be within the same Availability Zone
        R{{}} If successful, returns Attachment information, else returns an AmazonEC2Error.}
    public function attachVolume(string device, string instanceId, string volumeId) returns AttachmentInfo|AmazonEC2Error;

    documentation {
        Detaches an EBS volume from an instance.
        P{{force}} Forces detachment if the previous detachment attempt did not occur cleanly
        P{{volumeId}} The ID of the volume
        R{{}} If successful, returns detached volume information, else returns an AmazonEC2Error.}
    public function detachVolume(boolean force = false, string volumeId) returns AttachmentInfo|AmazonEC2Error;
};

documentation {
        Define the configurations for Amazon ec2 connector.
        F{{uri}} - The Amazon ec2 endpoint
        F{{accessKeyId}} - The access key of Amazon ec2 account
        F{{secretAccessKey}} - The secret key of the Amazon ec2 account
        F{{region}} - The AWS region
        F{{clientConfig}} - HTTP client endpoint config
}
public type AmazonEC2Configuration record {
    string uri;
    string accessKeyId;
    string secretAccessKey;
    string region;
    http:ClientEndpointConfig clientConfig = {};
};

documentation {
    Representation of an EC2 instance.

    F{{id}} The ID of the EC2 instance
    F{{imageId}} The ID of the image used to create the instance
    F{{state}} The current state of the instance
    F{{iType}} The type of the instance (e.g., t2.micro)
    F{{zone}} The zone in which the instance resides
    F{{privateIpAddress}} The private IP address of the instance
    F{{ipAddress}} The public IP address of the instance (if assigned one)
}
public type EC2Instance record {
    string id,
    string imageId,
    InstanceState? state,
    string iType, // instance type - e.g., t2.micro
    string zone,
    string privateIpAddress,
    string ipAddress,
};

documentation {
    Define an Image details
    F{{description}} - Image description
    F{{creationDate}} - Image creation date
    F{{imageId}} - Id of the image
    F{{imageLocation}} - Location of the image
    F{{imageState}} - State of the image
    F{{imageType}} - Type of the image
    F{{name}} - name of the image
}

public type Image record {
    string description;
    string creationDate;
    string imageId;
    string imageLocation;
    string imageState;
    string imageType;
    string name;
};

documentation {
    Define an EC2 service response, it will return boolean value based on the service status.
    F{{success}} - If the service request get succeed then the value will be true or flase
}
public type EC2ServiceResponse record {
    boolean success; //The Boolean value.
};

documentation {
    Define an ImageAttribute, based on these attributes type, an image will be described.
}
public type ImageAttribute DescriptionAttribute|KernelAttribute|LaunchPermissionAttribute[]|RamdiskAttribute|
ProductCodeAttribute[]|BlockDeviceMapping[]|SriovNetSupportAttribute;

documentation {
    Define description image attribute, based on this attribute type, an image will be described.
    F{{description}} - Value of the description
}
public type DescriptionAttribute record {
    string description;
};

documentation {
    Define kernel image attribute, based on this attribute type, an image will be described.
    F{{kernelId}} - id of the kernel
}
public type KernelAttribute record {
    string kernelId;
};

documentation {
    Define launch permission image attribute, based on this attribute type, an image will be described.
    F{{groupName}} - The name of the group
    F{{userId}} - The AWS account ID
}
public type LaunchPermissionAttribute record {
    string groupName;
    string userId;
};

documentation {
    Define ram disk image attribute, based on this attribute type, an image will be described.
    F{{ramDiskValue}} - The RAM disk ID.
}
public type RamdiskAttribute record {
    string ramDiskValue;
};

documentation {
    Define product code image attribute, based on this attribute type, an image will be described.
    F{{productCode}} - The product code
    F{{productType}} - The type of product code
}
public type ProductCodeAttribute record {
    string productCode;
    string productType;
};

documentation {
    Define  block device mapping image attribute, based on this attribute type, an image will be described.
    F{{deviceName}} - The device name
    F{{noDevice}} - Suppresses the specified device included in the block device mapping of the AMI
    F{{virtualName}} - The virtual device name
}
public type BlockDeviceMapping record {
    string deviceName;
    string noDevice;
    string virtualName;
};

documentation {
    Define sriovNetSupport image attribute, based on this attribute type, an image will be described.
    F{{sriovNetSupportValue}} - Indicates whether enhanced networking with the Intel 82599 Virtual Function
    interface is enabled
}
public type SriovNetSupportAttribute record {
    string sriovNetSupportValue;
};

documentation {
    Defines whether security group is successfully created or not.
    F{{groupId}} - The id of the group
}
public type SecurityGroup record {
    string groupId;
};

documentation {
    Describe the volume details.
    F{{availabilityZone}} - The Availability Zone for the volume
    F{{volumeId}} - The ID of the volume
    F{{size}} - The size of the volume, in GiBs
    F{{volumeType}} - The volume type
}
public type Volume record {
    string availabilityZone;
    int size;
    string volumeId;
    VolumeType? volumeType;
};

documentation {
    Define an attachment details of an EBS volume which is attached to a running or stopped instance.
    F{{attachTime}} - The time stamp when the attachment initiated
    F{{device}} - The device name
    F{{instanceId}} - The ID of the instance
    F{{status}} - The attachment state of the volume
    F{{volumeId}} - The ID of the volume
}
public type AttachmentInfo record {
    string attachTime;
    string device;
    string instanceId;
    VolumeAttachmentStatus? status;
    string volumeId;
};

documentation {
    Amazon ec2 Client Error
    F{{message}} - Error message of the response
    F{{cause}} - The error which caused the error
}
public type AmazonEC2Error record {
    string message;
    error? cause;
};
