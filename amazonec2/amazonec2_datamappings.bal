// Copyright (c) 2018 WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
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
// under the License

function converToInstanceList(xml response) returns InstanceList {
    InstanceList instancesList = {};
    instancesList.requestId = response["requestId"].getTextValue();
    xml instances = response["instancesSet"]["item"];
    InstanceSet[] list;
    int j = 0;
    int k = 0;
    foreach i, x in instances {
        StateSet stateSet = {};
        StateSet [] setList;
        xml content = x.elements();
        InstanceSet instanceSet = {};
        instanceSet.instanceId = content["instanceId"].getTextValue();
        instanceSet.imageId = content["imageId"].getTextValue();
        instanceSet.instanceType = content["instanceType"].getTextValue();
        instanceSet.reason = content["reason"].getTextValue();
        xml instanceStates = content["instanceState"];
        foreach a, y in instanceStates {
            xml stateContent = y.elements();
            stateSet.code = stateContent["code"].getTextValue();
            stateSet.name = stateContent["name"].getTextValue();
            setList[k] = stateSet;
        }
        instanceSet.instanceState = setList;
        list[j] = instanceSet;
        j = j + 1;
    }
    instancesList.instanceSet = list;
    return instancesList;
}

function converToTerminationInstanceList(xml response) returns TerminationInstanceList {
    TerminationInstanceList instancesList = {};
    instancesList.requestId = response["requestId"].getTextValue();
    xml instances = response["instancesSet"]["item"];
    TerminateInstanceSet[] list;
    int j = 0;
    int k = 0;
    int m = 0;
    foreach i, x in instances {
        StateSet stateSet = {};
        StateSet [] setList;
        xml content = x.elements();
        TerminateInstanceSet instanceSet = {};
        instanceSet.instanceId = content["instanceId"].getTextValue();
        xml currentStates = content["currentState"];
        foreach a, y in currentStates {
            xml stateContent = y.elements();
            stateSet.code = stateContent["code"].getTextValue();
            stateSet.name = stateContent["name"].getTextValue();
            setList[k] = stateSet;
        }
        instanceSet.currentState = setList;
        xml previousStates = content["previousState"];
        foreach b, z in previousStates {
            xml previousStateContent = z.elements();
            stateSet.code = previousStateContent["code"].getTextValue();
            stateSet.name = previousStateContent["name"].getTextValue();
            setList[m] = stateSet;
        }
        instanceSet.previousState = setList;
        list[j] = instanceSet;
        j = j + 1;
    }
    instancesList.instanceSet = list;
    return instancesList;
}

function converToReservationList(xml response) returns DescribeInstanceList {
    DescribeInstanceList reservationList = {};
    InstanceList instanceList = {};
    reservationList.requestId = response["requestId"].getTextValue();
    xml reservations = response["reservationSet"]["item"]["instancesSet"]["item"];
    DescribeInstanceSet [] list;
    StateSet [] setList;
    MonitoringList[] monitoringList;
    PlacementList[] placementList;
    int j = 0;
    int k = 0;
    int l = 0;
    int n = 0;
    foreach i, x in reservations {
        xml content = x.elements();
        StateSet stateSet = {};
        MonitoringList monitoringElement = {};
        PlacementList placementElement = {};
        DescribeInstanceSet instanceSet = {};
        instanceSet.instanceId = content["instanceId"].getTextValue();
        instanceSet.imageId = content["imageId"].getTextValue();
        instanceSet.instanceType = content["instanceType"].getTextValue();
        instanceSet.reason = content["reason"].getTextValue();
        instanceSet.launchTime = content["launchTime"].getTextValue();
        instanceSet.privateIpAddress = content["privateIpAddress"].getTextValue();
        instanceSet.ipAddress = content["ipAddress"].getTextValue();
        xml instanceStates = content["instanceState"];
        foreach a, y in instanceStates {
            xml stateContent = y.elements();
            stateSet.code = stateContent["code"].getTextValue();
            stateSet.name = stateContent["name"].getTextValue();
            setList[k] = stateSet;
        }
        instanceSet.instanceState = setList;
        xml monitoring = content["monitoring"];
        foreach b, w in monitoring {
            xml monitoringElements = w.elements();
            monitoringElement.state = monitoringElements["state"].getTextValue();
            monitoringList[l] = monitoringElement;
        }
        instanceSet.monitoring = monitoringList;
        xml placement = content["placement"];
        foreach c, d in placement {
            xml placementElements = d.elements();
            placementElement.availabilityZone = placementElements["availabilityZone"].getTextValue();
            placementElement.groupName = placementElements["groupName"].getTextValue();
            placementElement.tenancy = placementElements["tenancy"].getTextValue();
            placementList[n] = placementElement;
        }
        instanceSet.placement = placementList;
        list[j] = instanceSet;
        j = j + 1;
    }
    reservationList.instanceSet = list;
    return reservationList;
}

function getInstanceList(xml response) returns EC2Instance[] {
    EC2Instance[] list = [];
    int i = 0;
    xml reservationSet = response["reservationSet"]["item"];

    foreach reservation in reservationSet {
        xml instances = reservation.elements();

        foreach inst in instances["instancesSet"]["item"] {
            list[i] = getInstance(inst.elements());
            i++;
        }
    }

    return list;
}

function getSpawnedInstancesList(xml response) returns EC2Instance[] {
    EC2Instance[] list = [];
    int i = 0;
    xml spawnedInstances = response["instancesSet"]["item"];

    foreach inst in spawnedInstances {
        list[i] = getInstance(inst.elements());
        i++;
    }

    return list;
}

function getTerminatedInstancesList(xml response) returns EC2Instance[] {
    EC2Instance[] list = [];
    int i = 0;
    xml terminatedInstances = response["instancesSet"]["item"];

    foreach inst in terminatedInstances {
        xml content = inst.elements();
        EC2Instance instance = {};
        instance.id = content["instanceId"].getTextValue();
        instance.state = getInstanceState(check <int>content["currentState"]["code"].getTextValue());
        instance.previousState = getInstanceState(check <int>content["previousState"]["code"].getTextValue());
        list[i] = instance;
        i++;
    }

    return list;
}

function getInstance(xml content) returns EC2Instance {
    EC2Instance instance = {};
    instance.id = content["instanceId"].getTextValue();
    instance.imageId = content["imageId"].getTextValue();
    instance.iType = content["instanceType"].getTextValue();
    instance.zone = content["placement"]["availabilityZone"].getTextValue();
    instance.state = getInstanceState(check <int>content["instanceState"]["code"].getTextValue());
    instance.privateIpAddress = content["privateIpAddress"].getTextValue();
    instance.ipAddress = content["ipAddress"].getTextValue();
    return instance;
}

function getInstanceState(int status) returns InstanceState {
    if (status == 0) {
        return ISTATE_PENDING;
    } else if (status == 16) {
        return ISTATE_RUNNING;
    } else if (status == 32) {
        return ISTATE_SHUTTING_DOWN;
    } else if (status == 48) {
        return ISTATE_TERMINATED;
    } else if (status == 64) {
        return ISTATE_STOPPING;
    } else if (status == 80) {
        return ISTATE_STOPPED;
    } else {
        error e = {message: "Invalid EC2 instance state: " + status}; // This shouldn't happen
        throw e;
    }
}
