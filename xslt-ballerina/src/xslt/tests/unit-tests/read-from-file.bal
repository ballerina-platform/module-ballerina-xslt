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
import ballerina/stringutils;

@test:Config {}
function testReadFromFile() {
    string xmlFilePath = "src/xslt/tests/resources/datafiles/cd_catalog.xml";
    string xslFilePath = "src/xslt/tests/resources/datafiles/cd_catalog.xsl";
    xml|error result = readFromFile(xmlFilePath, xslFilePath);
    if (result is xml) {
        xml|error expected = readXml("src/xslt/tests/resources/datafiles/read_from_file_result.xml");
        if (expected is xml) {
            test:assertEquals(result, expected);
        } else {
            test:assertFail(expected.message());
        }
    } else {
        test:assertFail(result.message());
    }
}

@test:Config {
    enable: false
}
function testReadFromSource() {
    string xmlFilePath = "src/xslt/tests/resources/datafiles/source.xml";
    string xslFilePath = "src/xslt/tests/resources/datafiles/source.xsl";
    xml|error result = readFromFile(xmlFilePath, xslFilePath);
    if (result is xml) {
        xml|error expected = readXml("src/xslt/tests/resources/datafiles/read_from_source_result.xml");
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
    string xmlFilePath = "src/xslt/tests/resources/datafiles/cd_catalog.xml";
    string xslFilePath = "src/xslt/tests/resources/datafiles/cd_catalog_multi.xsl";
    xml|error result = readMultiRootedXml(xmlFilePath, xslFilePath);
    if (result is xml) {
        xml|error expected = readXml("src/xslt/tests/resources/datafiles/read_from_multi_rooted_result.xml");
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
        test:assertTrue(stringutils:contains(result.message(), "Unexpected character 'H' (code 72) in prolog; expected '<'"));
    }
}

function readXml(string filePath) returns @tainted xml|error {
    var byteChannel = io:openReadableFile(filePath);
    if (byteChannel is io:ReadableByteChannel) {
        io:ReadableCharacterChannel rch = <@untainted> new io:ReadableCharacterChannel(byteChannel, "UTF-8");
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

function readFromFile(string xmlFilePath, string xslFilePath) returns @tainted xml|error {
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

function readMultiRootedXml(string xmlFilePath, string xslFilePath) returns @tainted xml|error {
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

function transformXml() returns @tainted xml|error {
    xml xmlValue = xml `Hello, World!`;
    xml xslValue = xml `<name>Book1</name>`;
    var result = transform(xmlValue, xslValue);
    if (result is xml) {
        return result;
    } else {
        return result;
    }
}
