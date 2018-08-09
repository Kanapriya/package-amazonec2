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
// under the License.

import ballerina/io;
import ballerina/http;
import ballerina/time;
import ballerina/crypto;

function AmazonEC2Connector::startInstances(string[] instanceArray) returns InstanceList|AmazonEC2Error {

    endpoint http:Client clientEndpoint = self.clientEndpoint;
    AmazonEC2Error amazonEC2Error = {};
    string httpMethod = "GET";
    string requestURI = "/";
    string host = SERVICE_NAME + "." + self.region + "." + "amazonaws.com";
    string amazonEndpoint = "https://" + host;
    http:Request request = new;
    string canonicalQueryString = "Action=StartInstances&";
    int i = 1;
    foreach instances in instanceArray {
        canonicalQueryString = canonicalQueryString + "InstanceId." + i + "=" + instances + "&";
        i = i + 1;
    }
    canonicalQueryString = canonicalQueryString + "Version" + "=" + API_VERSION;
    string constructCanonicalString = "/?" + canonicalQueryString;
    generateSignature(request, self.accessKeyId, self.secretAccessKey, self.region, GET, requestURI, "",
        canonicalQueryString);
    var httpResponse = clientEndpoint->get(constructCanonicalString, message = request);
    match httpResponse {
    error err => {
        amazonEC2Error.message = err.message;
            return amazonEC2Error;
        }
        http:Response response => {
            int statusCode = response.statusCode;
            var amazonResponse = response.getXmlPayload();
            match amazonResponse {
                error err => {
                    amazonEC2Error.message = err.message;
                    return amazonEC2Error;
                }
                xml xmlResponse => {
                    if (statusCode == 200) {
                        return converTotInstanceList(xmlResponse);
                    } else {
                        amazonEC2Error.message = xmlResponse["Message"].getTextValue();
                        amazonEC2Error.statusCode = statusCode;
                        return amazonEC2Error;
                    }
                }
            }
        }
    }
}

function AmazonEC2Connector::monitorInstances(string[] instanceArray) returns InstanceList|AmazonEC2Error {

    endpoint http:Client clientEndpoint = self.clientEndpoint;
    AmazonEC2Error amazonEC2Error = {};
    string httpMethod = "GET";
    string requestURI = "/";
    string host = SERVICE_NAME + "." + self.region + "." + "amazonaws.com";
    string amazonEndpoint = "https://" + host;
    http:Request request = new;
    string canonicalQueryString = "Action=MonitorInstances&";
    int i = 1;
    foreach instances in instanceArray {
        canonicalQueryString = canonicalQueryString + "InstanceId." + i + "=" + instances + "&";
        i = i + 1;
    }
    canonicalQueryString = canonicalQueryString + "Version" + "=" + API_VERSION;
    string constructCanonicalString = "/?" + canonicalQueryString;
    generateSignature(request, self.accessKeyId, self.secretAccessKey, self.region, GET, requestURI, "",
        canonicalQueryString);
    var httpResponse = clientEndpoint->get(constructCanonicalString, message = request);
    match httpResponse {
        error err => {
            amazonEC2Error.message = err.message;
            return amazonEC2Error;
        }
        http:Response response => {
            int statusCode = response.statusCode;
            var amazonResponse = response.getXmlPayload();
            match amazonResponse {
                error err => {
                    amazonEC2Error.message = err.message;
                    return amazonEC2Error;
                }
                xml xmlResponse => {
                    if (statusCode == 200) {
                        return converTotInstanceList(xmlResponse);
                    } else {
                        amazonEC2Error.message = xmlResponse["Message"].getTextValue();
                        amazonEC2Error.statusCode = statusCode;
                        return amazonEC2Error;
                    }
                }
            }
        }
    }
}

function AmazonEC2Connector::stopInstances(string[] instanceArray) returns InstanceList|AmazonEC2Error {

    endpoint http:Client clientEndpoint = self.clientEndpoint;
    AmazonEC2Error amazonEC2Error = {};
    string httpMethod = "GET";
    string requestURI = "/";
    string host = SERVICE_NAME + "." + self.region + "." + "amazonaws.com";
    string amazonEndpoint = "https://" + host;
    http:Request request = new;
    string canonicalQueryString = "Action=StopInstances&";
    int i = 1;
    foreach instances in instanceArray {
        canonicalQueryString = canonicalQueryString + "InstanceId." + i + "=" + instances + "&";
        i = i + 1;
    }
    canonicalQueryString = canonicalQueryString + "Version" + "=" + API_VERSION;
    string constructCanonicalString = "/?" + canonicalQueryString;
    generateSignature(request, self.accessKeyId, self.secretAccessKey, self.region, GET, requestURI, "",
        canonicalQueryString);
    var httpResponse = clientEndpoint->get(constructCanonicalString, message = request);
    match httpResponse {
    error err => {
        amazonEC2Error.message = err.message;
            return amazonEC2Error;
        }
        http:Response response => {
            int statusCode = response.statusCode;
            var amazonResponse = response.getXmlPayload();
            match amazonResponse {
                error err => {
                    amazonEC2Error.message = err.message;
                    return amazonEC2Error;
                }
                xml xmlResponse => {
                    if (statusCode == 200) {
                        return converTotInstanceList(xmlResponse);
                    } else {
                        amazonEC2Error.message = xmlResponse["Message"].getTextValue();
                        amazonEC2Error.statusCode = statusCode;
                        return amazonEC2Error;
                    }
                }
            }
        }
    }
}