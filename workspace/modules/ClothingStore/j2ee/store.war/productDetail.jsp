<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib prefix="dsp"
	uri="http://www.atg.com/taglibs/daf/dspjspTaglib1_1"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="styles/layout.css" rel="stylesheet" type="text/css"
	media="all" />
<link href="styles/base.css" rel="stylesheet" type="text/css"
	media="all" />
<link href="styles/content.css" rel="stylesheet" type="text/css"
	media="all" />
<link href="styles/jquery_ui.css" rel="stylesheet" type="text/css"
	media="all" />

<title>demo</title>
</head>
<body>
	<dsp:page>
		<div id="wrap" class="clear-block">
			<div id="header"><jsp:include page="header.jsp" /></div>
			<div id="main">
				<div class="J_tab_panel">
					<div class="prodDetail">
						<h1>
							Product Details for:
							<dsp:valueof param="id" />
						</h1>
						<dsp:droplet name="/atg/commerce/catalog/ProductLookup">
							<dsp:param param="id" name="id" />
							<dsp:oparam name="output">
								<dsp:getvalueof var="name" param="element.displayName" />
								<dsp:getvalueof var="imgURL" param="element.thumbnailImage.url" />
								<dsp:getvalueof var="price"
									param="element.childSKUs[0].listPrice" />
								<dsp:getvalueof var="description"
									param="element.childSKUs[0].listPrice" />
							</dsp:oparam>
						</dsp:droplet>
					</div>
				</div>
			</div>
			<div id="footer"><jsp:include page="footer.jsp" /></div>
		</div>
	</dsp:page>
</body>
</html>