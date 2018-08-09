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
string imageId = config:getAsString("IMAGE_ID");
int max = config:getAsInt("MAX_COUNT");
int min = config:getAsInt("MIN_COUNT");

endpoint Client amazonEC2Client {
    accessKeyId: testAccessKeyId,
    secretAccessKey: testSecretAccessKey,
    region: testRegion
};

@test:Config
function testRunInstances() {
    log:printInfo("amazonEC2Client -> runInstances()");
    var rs = amazonEC2Client->runInstances(imageId, max, min);
    match rs {
        InstanceList instance => {
            io:println(" Successfully run the instance : ");
            string instanceId = (instance.instanceSet[0].instanceId);
            test:assertNotEquals(instanceId, null, msg = "Failed to runInstances");
        }
        AmazonEC2Error err => {
            io:println(err);
            test:assertFail(msg = err.message);
        }
    }
}

@test:Config
function testDescribeInstances() {
    log:printInfo("amazonEC2Client -> describeInstances()");
    var rs = amazonEC2Client->describeInstances();
    match rs {
        ReservationList reservations => {
            io:println(" Successfully describe the instance : ");
            string reservationId = (reservations.reservationSet[0].reservationId);
            test:assertNotEquals(reservationId, null, msg = "Failed to describeInstances");
        }
        AmazonEC2Error err => {
            io:println(err);
            test:assertFail(msg = err.message);
        }
    }
}

@test:Config
function testTerminateInstances() {
    log:printInfo("amazonEC2Client -> terminateInstances()");
    string[] instanceArray = [testInstance_2,testInstance_2];
    var rs = amazonEC2Client->terminateInstances(instanceArray);
    match rs {
        InstanceList instance => {
            io:println(" Successfully terminate the instance : ");
            string instanceId = (instance.instanceSet[0].instanceId);
            test:assertNotEquals(instanceId, null, msg = "Failed to terminateInstances");
        }
        AmazonEC2Error err => {
            io:println(err);
            test:assertFail(msg = err.message);
        }
    }
}