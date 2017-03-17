<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib uri="http://www.atg.com/taglibs/daf/dspjspTaglib1_0"
	prefix="dsp"%>

<html xmlns="http://www.w3.org/1999/xhtml">
<body>
	<div>
		<p>Details of the Store</p>
		<%-- <dsp:droplet name="/atg/dynamo/droplet/ItemLookupDroplet">
			<dsp:param name="id" param="storeID" />
			<dsp:param name="repository" value="/clothing/store/StoreRepository" />
			<dsp:param name="itemDescriptor" value="BricsMorter" />

			<dsp:oparam name="output">
				<dsp:tomap var="item" param="element" recursive="false" />
				<b>Store Name: ${item.storeName }</b>
			</dsp:oparam>
			<p>--End--</p>
		</dsp:droplet> --%>
		
		<dsp:droplet name="clothing/store/StoreLookup">
			<dsp:param name="id" param="storeID" />
		</dsp:droplet>
	</div>
</body>
</html>