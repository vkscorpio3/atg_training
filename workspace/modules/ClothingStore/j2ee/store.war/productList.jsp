<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
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
	<div id="wrap" class="clear-block">
		<div id="header"><jsp:include page="header.jsp" /></div>
		<div id="main">
			<div class="J_tabs">
				<ul>
					<li class="J_tab_default"><a href="catgory.jsp">category
							one</a></li>
					<span class="cutline">|</span>
					<li><a href="#">category two</a></li>
					<span class="cutline">|</span>
					<li><a href="#">category three</a></li>
				</ul>
			</div>

			<div class="J_tab_panel">
				<h3 class="green">jackets &amp; vests</h3>
				<div class="prodlist">
					<dsp:droplet name="/atg/commerce/catalog/CategoryLookup">
						<dsp:param param="subCategoryId" name="id" />

						<dsp:oparam name="output">
							<dsp:droplet name="/atg/dynamo/droplet/ForEach">
								<dsp:param name="array" param="element.childProducts" />
								<dsp:oparam name="output">
									<dsp:tomap var="item" param="element" recursive="false" />
									<ul>
										<dsp:a href="productDetail.jsp">
											<b>${item.displayName}</b>
											<dsp:param name="productId" value="${item.id}" />
										</dsp:a>

										<dsp:droplet name="/atg/dynamo/droplet/Switch">
											<dsp:param name="value" param="element.childSKUs[0].onSale" />
											<dsp:oparam name="true">
												<dsp:valueof param="element.childSKUs[0].salePrice" />
											</dsp:oparam>
											<dsp:oparam name="false">
												<strike> <dsp:valueof
														param="element.childSKUs[0].listPrice" />
												</strike>
											</dsp:oparam>
										</dsp:droplet>
									</ul>
								</dsp:oparam>
							</dsp:droplet>
						</dsp:oparam>
					</dsp:droplet>
				</div>
			</div>

		</div>
		<div id="footer"><jsp:include page="footer.jsp" /></div>
	</div>
</body>
</html>