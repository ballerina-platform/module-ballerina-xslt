Ballerina XSLT Library
===================

  [![Build](https://github.com/ballerina-platform/module-ballerina-xslt/actions/workflows/build-timestamped-master.yml/badge.svg)](https://github.com/ballerina-platform/module-ballerina-xslt/actions/workflows/build-timestamped-master.yml)
  [![codecov](https://codecov.io/gh/ballerina-platform/module-ballerina-xslt/branch/master/graph/badge.svg)](https://codecov.io/gh/ballerina-platform/module-ballerina-xslt)
  [![Trivy](https://github.com/ballerina-platform/module-ballerina-xslt/actions/workflows/trivy-scan.yml/badge.svg)](https://github.com/ballerina-platform/module-ballerina-xslt/actions/workflows/trivy-scan.yml)
  [![GraalVM Check](https://github.com/ballerina-platform/module-ballerina-xslt/actions/workflows/build-with-bal-test-graalvm.yml/badge.svg)](https://github.com/ballerina-platform/module-ballerina-xslt/actions/workflows/build-with-bal-test-graalvm.yml)
  [![GitHub Last Commit](https://img.shields.io/github/last-commit/ballerina-platform/module-ballerina-xslt.svg)](https://github.com/ballerina-platform/module-ballerina-xslt/commits/master)
  [![Github issues](https://img.shields.io/github/issues/ballerina-platform/ballerina-standard-library/module/xslt.svg?label=Open%20Issues)](https://github.com/ballerina-platform/ballerina-standard-library/labels/module%2Fxslt)

This library provides an API to transform XML content to another XML/HTML/plain text format using XSL transformations.

The Extensible Stylesheet Language Transformations (XSLT) is used to obtain alternative XML representations and especially for generating HTML documents. The Ballerina XSLT library support XSLT version 1.0.

The usage of the XSLT API is as follows:

```ballerina
xml target = check xslt:transform(sourceXml, xsl);
```

## Issues and projects 

Issues and Projects tabs are disabled for this repository as this is part of the Ballerina Standard Library. To report bugs, request new features, start new discussions, view project boards, etc. please visit Ballerina Standard Library [parent repository](https://github.com/ballerina-platform/ballerina-standard-library). 

This repository only contains the source code for the module.

## Build from the source

### Set up the prerequisites

1. Download and install Java SE Development Kit (JDK) version 21 (from one of the following locations).

   * [Oracle](https://www.oracle.com/java/technologies/downloads/)
   
   * [OpenJDK](https://adoptium.net/)
   
        > **Note:** Set the JAVA_HOME environment variable to the path name of the directory into which you installed JDK.   
1. Export Github Personal access token with read package permissions as follows,
        
        export packageUser=<Username>
        export packagePAT=<Personal access token>
     
### Build the source

Execute the commands below to build from source.

1. To build the library:
   ```    
   ./gradlew clean build
   ```

1. To run the integration tests:
   ```
   ./gradlew clean test
   ```
1. To build the module without the tests:
   ```
   ./gradlew clean build -x test
   ```
1. To debug module implementation:
   ```
   ./gradlew clean build -Pdebug=<port>
   ./gradlew clean test -Pdebug=<port>
   ```
1. To debug the module with Ballerina language:
   ```
   ./gradlew clean build -PbalJavaDebug=<port>
   ./gradlew clean test -PbalJavaDebug=<port>
   ```
1. Publish ZIP artifact to the local `.m2` repository:
   ```
   ./gradlew clean build publishToMavenLocal
   ```
1. Publish the generated artifacts to the local Ballerina central repository:
   ```
   ./gradlew clean build -PpublishToLocalCentral=true
   ```
1. Publish the generated artifacts to the Ballerina central repository:
   ```
   ./gradlew clean build -PpublishToCentral=true
   ```

## Contribute to Ballerina

As an open source project, Ballerina welcomes contributions from the community. 

For more information, go to the [contribution guidelines](https://github.com/ballerina-platform/ballerina-lang/blob/master/CONTRIBUTING.md).

## Code of conduct

All contributors are encouraged to read the [Ballerina Code of Conduct](https://ballerina.io/code-of-conduct).

## Useful links

* Chat live with us via our [Discord server](https://discord.gg/ballerinalang).
* Post all technical questions on Stack Overflow with the [#ballerina](https://stackoverflow.com/questions/tagged/ballerina) tag.
* For more information, go to [the XSLT package](https://ballerina.io/swan-lake/learn/api-docs/ballerina/xslt/).
* For example demonstrations of the usage, go to [Ballerina By Examples](https://ballerina.io/learn/by-example/).
