/*
 * Copyright (c) 2019, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
 *
 * WSO2 Inc. licenses this file to you under the Apache License,
 * Version 2.0 (the "License"); you may not use this file except
 * in compliance with the License.
 * You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */

package io.ballerina.stdlib.xslt;

import io.ballerina.runtime.api.creators.ErrorCreator;
import io.ballerina.runtime.api.creators.ValueCreator;
import io.ballerina.runtime.api.types.XmlNodeType;
import io.ballerina.runtime.api.utils.StringUtils;
import io.ballerina.runtime.api.utils.XmlUtils;
import io.ballerina.runtime.api.values.BArray;
import io.ballerina.runtime.api.values.BError;
import io.ballerina.runtime.api.values.BIterator;
import io.ballerina.runtime.api.values.BMap;
import io.ballerina.runtime.api.values.BString;
import io.ballerina.runtime.api.values.BXml;
import io.ballerina.runtime.api.values.BXmlItem;
import io.ballerina.runtime.api.values.BXmlSequence;
import net.sf.saxon.BasicTransformerFactory;
import org.apache.axiom.om.OMElement;
import org.apache.axiom.om.util.AXIOMUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.PrintStream;
import java.io.StringWriter;

import javax.xml.namespace.QName;
import javax.xml.stream.XMLStreamException;
import javax.xml.transform.Transformer;
import javax.xml.transform.stax.StAXSource;
import javax.xml.transform.stream.StreamResult;

import static io.ballerina.stdlib.xslt.ModuleUtils.getModule;
import static io.ballerina.stdlib.xslt.XsltConstants.XSLT_TRANSFORM_ERROR;

/**
 * Transforms XML to another XML/HTML/plain text using XSLT.
 *
 * @since 0.995.0
 */
public class XsltTransformer {

    private static final Logger log = LoggerFactory.getLogger(XsltTransformer.class);
    private static final PrintStream errStream = System.err;
    private static final String OPERATION = "Failed to perform XSL transformation: ";

    public static Object transform(BXml xmlInput, BXml xslInput, BMap<BString, Object> paramInput) {

        try {
            boolean unwrap = false;
            if (xmlInput.getNodeType() == XmlNodeType.SEQUENCE) {
                BXmlItem wrapper = ValueCreator.createXmlItem(new QName("root"), (BXmlSequence) xmlInput);
                xmlInput = wrapper;
                unwrap = true;
            }
            String input = xmlInput.toString();
            // Remove <root></root> wrapper
            if (unwrap) {
                input = input.substring(6, input.length() - 7).trim();
            }

            String xsl = xslInput.toString();
            OMElement omXML = AXIOMUtil.stringToOM(input);
            OMElement omXSL = AXIOMUtil.stringToOM(xsl);

            StAXSource xmlSource = new StAXSource(omXML.getXMLStreamReader());
            StAXSource xslSource = new StAXSource(omXSL.getXMLStreamReader());

            StringWriter stringWriter = new StringWriter();
            StreamResult streamResult = new StreamResult(stringWriter);

            Transformer transformer = new BasicTransformerFactory().newInstance().newTransformer(xslSource);
            transformer.setOutputProperty("omit-xml-declaration", "yes");
            applyParameters(transformer, paramInput);
            transformer.transform(xmlSource, streamResult);

            String resultStr = stringWriter.getBuffer().toString().trim();
            if (log.isDebugEnabled()) {
                log.debug("Transformed result : {}", resultStr);
            }

            if (resultStr.isEmpty()) {
                return createTransformError(OPERATION + "empty result");
            } else {
                return parseToXML(resultStr);
            }

        } catch (ClassCastException e) {
            return createTransformError(OPERATION + "invalid inputs(s)");
        } catch (Exception e) {
            String errMsg = e.getCause() != null ? e.getCause().getMessage() : e.getMessage();
            return createTransformError(OPERATION + errMsg);
        }
    }

    /**
     * Apply template parameters to the transformer.
     *
     * @param transformer The transformer to be used
     * @param paramInput The input parameter map
     */
    private static void applyParameters(Transformer transformer, BMap<BString, Object> paramInput) {
        BIterator<?> iterator = paramInput.getIterator();
        while (iterator.hasNext()) {
            BArray next = (BArray) iterator.next(); //Doing hard casts here, may need to check types
            BString key = (BString) next.get(0); //Doing hard casts here, may need to check types
            Object value = next.get(1);
            // Note that you can add any value as long as toString method of that value works properly,
            // Only support string and int at the moment, may be able to improve the logic to support
            // xml as well, but current XmlItem ballerina runtime value toString method does not return
            // the value expected by the transformer, so not supporting that at the moment
            // And here, no need to check the types of the values as the compiler will make sure
            // only viable types of values will arrive here
            transformer.setParameter(key.getValue(), value);
        }
    }

    /**
     * Converts the given string to a BXmlSequence object.
     *
     * @param xmlStr The string to be converted
     * @return The result BXmlSequence object
     */
    private static BXmlSequence parseToXML(String xmlStr) throws XMLStreamException {

        return (BXmlSequence) XmlUtils.parse(xmlStr);
    }

    private static BError createTransformError(String errMsg) {

        return ErrorCreator.createDistinctError(XSLT_TRANSFORM_ERROR, getModule(), StringUtils.fromString(errMsg));
    }
}
