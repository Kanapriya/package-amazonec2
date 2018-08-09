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
    xml instances = response["instancesSet"];
    InstanceSet[] list;
    int j = 0;
    foreach i, x in instances {
        xml content = x.elements();
        InstanceSet instanceSet = {};
        instanceSet.instanceId = content["item"]["instanceId"].getTextValue();
        list[j] = instanceSet;
        j = j + 1;
    }
    instancesList.instanceSet = list;
    return instancesList;
}

function converToReservationList(xml response) returns ReservationList {
    ReservationList reservationList = {};
    reservationList.requestId = response["requestId"].getTextValue();
    xml reservations = response["reservationSet"];
    ReservationSet[] list;
    int j = 0;
    foreach i, x in reservations {
        xml content = x.elements();
        ReservationSet reservationSet = {};
        reservationSet.instanceId = content["item"]["reservationId"].getTextValue();
        list[j] = reservationSet;
        j = j + 1;
    }
    reservationList.reservationSet = list;
    return reservationList;
}