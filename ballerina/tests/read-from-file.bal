// Copyright (c) 2020 WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
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
import ballerina/test;

@test:Config {}
function testReadFromFile() {
    string xmlFilePath = "tests/resources/datafiles/cd_catalog.xml";
    string xslFilePath = "tests/resources/datafiles/cd_catalog.xsl";
    xml|error result = readFromFile(xmlFilePath, xslFilePath);
    if (result is xml) {
        xml|error expected = readXml("tests/resources/datafiles/read_from_file_result.xml");
        if (expected is xml) {
            test:assertEquals(result, expected);
        } else {
            test:assertFail(expected.message());
        }
    } else {
        test:assertFail(result.message());
    }
}

@test:Config {}
function testReadFromFileWithParams() returns error? {
    string xmlFilePath = "tests/resources/datafiles/cd_catalog.xml";
    string xslFilePath = "tests/resources/datafiles/cd_catalog_with_params.xsl";
    string strParam = "Music CD Collection With Artist";
    decimal intParam = 5;
    xml xmlParam = xml `<element>"value"</element>`;
    map<anydata> params = {"param1":strParam, "param2": intParam, "param3": xmlParam};
    xml result = check readFromFileWithParams(xmlFilePath, xslFilePath, params);
    xml expected = check readXml("tests/resources/datafiles/read_from_file_with_params_result.xml");
    test:assertEquals(result, expected);
}

function readFromFileWithParams(string xmlFilePath, string xslFilePath, map<anydata> params) returns xml|error {
    xml xmlValue = check readXml(xmlFilePath);
    xml xslValue = check readXml(xslFilePath);
    return transform(xmlValue, xslValue, params);
}

@test:Config {
    enable: false
}
function testReadFromSource() {
    string xmlFilePath = "tests/resources/datafiles/source.xml";
    string xslFilePath = "tests/resources/datafiles/source.xsl";
    xml|error result = readFromFile(xmlFilePath, xslFilePath);
    if (result is xml) {
        xml|error expected = readXml("tests/resources/datafiles/read_from_source_result.xml");
        if (expected is xml) {
            test:assertEquals(result, expected);
        } else {
            test:assertFail(expected.message());
        } 
    } else {
        test:assertFail(result.message());
    }
}

@test:Config {}
function testReadMultiRootedXml() {
    string xmlFilePath = "tests/resources/datafiles/cd_catalog.xml";
    string xslFilePath = "tests/resources/datafiles/cd_catalog_multi.xsl";
    xml|error result = readMultiRootedXml(xmlFilePath, xslFilePath);
    if (result is xml) {
        xml|error expected = readXml("tests/resources/datafiles/read_from_multi_rooted_result.xml");
        if (expected is xml) {
            test:assertEquals(result, expected);
        } else {
            test:assertFail(expected.message());
        }
    } else {
        test:assertFail(result.message());
    }
}

@test:Config {}
function testDirectInvoke() {
    xml|error result = transformXml();
    if (result is xml) {
        test:assertFail("Expected an error. But found the xml");
    } else {        
        test:assertTrue(result.message().includes("Unexpected character 'H' (code 72) in prolog; expected '<'"));
    }
}

function readXml(string filePath) returns xml|error {
    var byteChannel = io:openReadableFile(filePath);
    if (byteChannel is io:ReadableByteChannel) {
        io:ReadableCharacterChannel rch = new io:ReadableCharacterChannel(byteChannel, "UTF-8");
        var result = rch.readXml();
        if (result is xml) {
            return result;
        } else {
            return result;
        }
    } else {
        return byteChannel;
    }
}

function readFromFile(string xmlFilePath, string xslFilePath) returns xml|error {
    var xmlValue = readXml(xmlFilePath);
    if (xmlValue is xml) {
        var xslValue = readXml(xslFilePath);
        if (xslValue is xml) {
            var result = transform(xmlValue, xslValue);
            if (result is xml) {
                return result;
            } else {
                return result;
            }
        } else {
            return xslValue;
        }
    } else {
        return xmlValue;
    }
}

function readMultiRootedXml(string xmlFilePath, string xslFilePath) returns xml|error {
    var xmlValue = readXml(xmlFilePath);
    if (xmlValue is xml) {
        var xslValue = readXml(xslFilePath);
        if (xslValue is xml) {
            var result = transform(xmlValue/*, xslValue);
            if (result is xml) {
                return result;
            } else {
                return result;
            }
        } else {
            return xslValue;
        }
    } else {
        return xmlValue;
    }
}

function transformXml() returns xml|error {
    xml xmlValue = xml `Hello, World!`;
    xml xslValue = xml `<name>Book1</name>`;
    var result = transform(xmlValue, xslValue);
    if (result is xml) {
        return result;
    } else {
        return result;
    }
}
