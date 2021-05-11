## Module Overview

This module provides a function to transform the XML content to another XML/HTML/plain text using XSL transformations.

The Extensible Stylesheet Language Transformations (XSLT) is used to obtain alternative XML representations and especially for generating HTML documents.

Usage of the XSLT API is as follows:
```ballerina
xml target = check xslt:transform(sourceXml, xsl);
```
