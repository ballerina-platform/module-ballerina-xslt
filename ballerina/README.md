## Overview

This module provides an API to transform XML content to another XML/HTML/plain text format using XSL transformations, based on the Extensible Stylesheet Language Transformations (XSLT) standard. This module supports XSLT version 1.0.

## Key Features

- Transform XML content into XML, HTML, or plain text using XSL stylesheets

The usage of the XSLT API is as follows:

```ballerina
xml target = check xslt:transform(sourceXml, xsl);
```
