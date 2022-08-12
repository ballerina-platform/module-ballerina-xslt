## Overview

This module provides an API to transform XML content to another XML/HTML/plain text format using XSL transformations.

The Extensible Stylesheet Language Transformations (XSLT) is used to obtain alternative XML representations and especially for generating HTML documents. The Ballerina XSLT module support XSLT version 1.0.

The usage of the XSLT API is as follows:

```ballerina
xml target = check xslt:transform(sourceXml, xsl);
```
