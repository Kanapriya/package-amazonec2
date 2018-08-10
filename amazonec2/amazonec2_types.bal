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

public type InstanceState "pending"|"running"|"shutting-down"|"terminated"|"stopping"|"stopped";

@final public InstanceState ISTATE_PENDING = "pending";
@final public InstanceState ISTATE_RUNNING = "running";
@final public InstanceState ISTATE_SHUTTING_DOWN = "shutting-down";
@final public InstanceState ISTATE_TERMINATED = "terminated";
@final public InstanceState ISTATE_STOPPING = "stopping";
@final public InstanceState ISTATE_STOPPED = "stopped";

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
        R{{}} - If success, returns InstanceList of launched instances, else returns AmazonEC2Error object.}
    public function runInstances(string imgId, int maxCount, int minCount) returns EC2Instance[]|AmazonEC2Error;

    documentation {
        Describes one or more of your instances.
        R{{}} If successful, returns EC2Instance[] with zero or more instances, else returns an AmazonEC2Error.}
    public function describeInstances() returns EC2Instance[]|AmazonEC2Error;

    documentation {
        Shuts down one or more instances.
        P{{instanceArray}} - One or more instance IDs
        R{{}} - If success, returns TerminationInstanceList with terminated instances, else returns AmazonEC2Error object.}
    public function terminateInstances(string[] instanceArray) returns EC2Instance[]|AmazonEC2Error;
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
    Define the Instance object details
    F{{instanceSet}} - Instance set with instance ids
    F{{requestId}} - request id
}
public type InstanceList record {
    InstanceSet[] instanceSet;
    string requestId;
};

documentation {
    Define the termination instance object details
    F{{instanceSet}} - Instance set with terminated instance ids
    F{{requestId}} - request id
}
public type TerminationInstanceList record {
    TerminateInstanceSet[] instanceSet;
    string requestId;
};

documentation {
    Define the Instance set with instane id's for termination
    F{{instanceId}} - Instance set of with instance id
    F{{currentState}} - Current state of instances for the termination request
    F{{previousState}} - previuos state of the instances for the termination
}
public type TerminateInstanceSet record {
    string instanceId;
    StateSet[] currentState;
    StateSet[] previousState;
};

documentation {
    Define the Instance set with instane id's for launch the isntance
    F{{instanceId}} - Instance id
    F{{instanceState}} - State of the launched instance
    F{{instanceType}} - Type of the instance
    F{{reason}} - The reason
    F{{imageId}} - The imageId of the launched instance
}
public type InstanceSet record {
    string instanceId;
    StateSet[] instanceState;
    string instanceType;
    string reason;
    string imageId;
};

documentation {
    Define the DescribeInstance object details
    F{{instanceSet}} - Reservation set with instance details.
    F{{requestId}} - request id
}
public type DescribeInstanceList record {
    DescribeInstanceSet[] instanceSet;
    string requestId;
};

documentation {
    Define the describe instance  set with instance id's
    F{{instanceId}} - Instance id
    F{{imageId}} - Image id
    F{{instanceType}} - Instance type
    F{{reason}} - Reason for launch an instance
    F{{launchTime}} - Launch time
    F{{privateIpAddress}} - Private IP address of launched instance
    F{{ipAddress}} - Ip address
    F{{instanceState}} - State of the instances
    F{{monitoring}} - Monitoring details of instances
    F{{placement}} - Placement details of instances
}
public type DescribeInstanceSet record {
    string instanceId;
    string imageId;
    string instanceType;
    string reason;
    string launchTime;
    string privateIpAddress;
    string ipAddress;
    StateSet[] instanceState;
    MonitoringList[] monitoring;
    PlacementList[] placement;
};

documentation {
    Define the state set with code and name
    F{{code}} - Code
    F{{name}} - Name
}
public type StateSet record {
    string code;
    string name;
};

documentation {
    Define the monitoring information of an instance
    F{{state}} - state
}
public type MonitoringList record {
    string state;
};

documentation {
    Define the placement details of an instance
    F{{availabilityZone}} - The availabilityZone of the instance
    F{{groupName}} - Group name of the instance
    F{{tenancy}} - Tenancy of the instance
}
public type PlacementList record {
    string availabilityZone;
    string groupName;
    string tenancy;
};

documentation {
    Amazon ec2 Client Error
    F{{message}} - Error message of the response
    F{{cause}} - The error which caused the error
    F{{statusCode}} - Status code of the response
}
public type AmazonEC2Error record {
    string message;
    error? cause;
    int statusCode;
};
