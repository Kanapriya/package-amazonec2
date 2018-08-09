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

import ballerina/config;
import ballerina/http;
import ballerina/log;
import ballerina/test;

string testAccessKeyId = config:getAsString("ACCESS_KEY_ID");
string testSecretAccessKey = config:getAsString("SECRET_ACCESS_KEY");
string testRegion = config:getAsString("REGION");
string testInstance_1 = config:getAsString("INSTANCE_ID_1");
string testInstance_2 = config:getAsString("INSTANCE_ID_1");

endpoint Client amazonEC2Client {
    accessKeyId: testAccessKeyId,
    secretAccessKey: testSecretAccessKey,
    region: testRegion
};

@test:Config
function testStartInstances() {
    log:printInfo("amazonEC2Client -> startInstances()");
    string[] instanceArray = [testInstance_1,testInstance_2 ];
    var rs = amazonEC2Client->startInstances(instanceArray);
    match rs {
        InstanceList instance => {
            io:println(" Successfully start the instance : ");
            string instanceId = (instance.instanceSet[0].instanceId);
            test:assertNotEquals(instanceId, null, msg = "Failed to startInstances");
        }
        AmazonEC2Error err => {
            io:println(err);
            test:assertFail(msg = err.message);
        }
    }
}

@test:Config
function testMonitorInstances() {
    log:printInfo("amazonEC2Client -> monitorInstances()");
    string[] instanceArray = [testInstance_2];
    var rs = amazonEC2Client->monitorInstances(instanceArray);
    match rs {
        InstanceList instance => {
            io:println(" Successfully monitor the instance : ");
            string instanceId = (instance.instanceSet[0].instanceId);
            test:assertNotEquals(instanceId, null, msg = "Failed to monitorInstances");
        }
        AmazonEC2Error err => {
            io:println(err);
            test:assertFail(msg = err.message);
        }
    }
}

@test:Config
function testStopInstances() {
    log:printInfo("amazonEC2Client -> stopInstances()");
    string[] instanceArray = [testInstance_2];
    var rs = amazonEC2Client->stopInstances(instanceArray);
    match rs {
        InstanceList instance => {
            io:println(" Successfully stop the instance : ");
            string instanceId = (instance.instanceSet[0].instanceId);
            test:assertNotEquals(instanceId, null, msg = "Failed to stopInstances");
        }
        AmazonEC2Error err => {
            io:println(err);
            test:assertFail(msg = err.message);
        }
    }
}