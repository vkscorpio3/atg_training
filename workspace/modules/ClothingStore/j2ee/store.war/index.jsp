<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.atg.com/taglibs/daf/dspjspTaglib1_0"
	prefix="dsp"%>


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
				<div class="J_tabs">
					<dsp:droplet name="/atg/dynamo/droplet/ForEach">
						<dsp:param name="array"
							bean="/atg/userprofiling/Profile.catalog.allRootCategories" />
						<dsp:oparam name="output">
							<dsp:tomap var="item" param="element" recursive="false" />
							<dsp:a href="category.jsp">
								<b>${item.displayName}</b>
								<dsp:param name="categoryId" value="${item.id}" />
								<span> | </span>
							</dsp:a>
						</dsp:oparam>
					</dsp:droplet>
				</div>

				<div class="J_tab_panel">
					<div class="bannerBox">
						<a href="index.jsp"><img src="images/banners/b_catg_960.jpg"
							alt="" /></a>
					</div>
				</div>

			</div>
			<div>

				<dsp:droplet name="/atg/targeting/TargetingForEach">
					<dsp:param bean="/atg/registry/Slots/MensClothingDiscountSlot" name="targeter" />
					<dsp:oparam name="output">
						<img src='<dsp:valueof param="element.url"/>' />
					</dsp:oparam>
				</dsp:droplet>
				
			</div>
			<div id="footer"><jsp:include page="aboutUs.jsp" /></div>
		</div>
	</dsp:page>
</body>
</html>
