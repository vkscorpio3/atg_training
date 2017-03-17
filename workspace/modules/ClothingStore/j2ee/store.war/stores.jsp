<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib uri="http://www.atg.com/taglibs/daf/dspjspTaglib1_0"
	prefix="dsp"%>

<html xmlns="http://www.w3.org/1999/xhtml">
<body>
	<div>
		<h1>Available Stores</h1>


		<dsp:droplet name="/atg/dynamo/droplet/RQLQueryForEach">
			<dsp:param name="repository" value="/clothing/store/StoreRepository" />
			<dsp:param name="itemDescriptor" value="BricsMorter" />
			<dsp:param name="queryRQL" value="ALL" />
			<dsp:oparam name="output">
				<dsp:tomap var="item" param="element" recursive="false" />
				<ul>
					<dsp:a href="store_details.jsp">
						<b>${item.storeName}</b>
						<dsp:param name="storeID" value="${ item.storeID }" />
					</dsp:a>
				</ul>
			</dsp:oparam>
		</dsp:droplet>
		<h1>Available Stores</h1>
	</div>
</body>
</html>