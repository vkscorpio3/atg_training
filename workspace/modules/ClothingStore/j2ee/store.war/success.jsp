<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="dsp"
	uri="http://www.atg.com/taglibs/daf/dspjspELTaglib1_0"%>
<dsp:importbean bean="/atg/commerce/ShoppingCart" />
<dsp:importbean bean="/atg/dynamo/droplet/ForEach" />
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
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
		<div class="shoppingCart">
			<h3>shopping cart</h3>
			<dsp:droplet name="ForEach">
				<dsp:param name="array" bean="ShoppingCart.current.commerceItems" />
				<dsp:oparam name="outputStart">
					<div class="listBox">
						<ul class="head">
							<li class="item">Item</li>
							<li class="qty">Quantity</li>
							<li class="price">Total Price</li>
							<li class="site">Site</li>
						</ul>
					</div>
				</dsp:oparam>
				<dsp:oparam name="output">
					<dsp:param name="commerceItem" param="element" />
					<div class="listBox">
						<ul>
							<li class="item">
								<p class="name">
									<dsp:valueof
										param="commerceItem.auxiliaryData.productRef.displayName" />
								</p>
								<p>
									SKU: <span><dsp:valueof
											param="commerceItem.catalogRefId" /></span>
								</p>
							</li>
							<li class="qty"><dsp:valueof param="commerceItem.quantity" />
							</li>
							<li class="price"><dsp:valueof
									param="commerceItem.priceInfo.amount" converter="currency" />
							</li>
							<li>
							<dsp:droplet
									name="/atg/dynamo/droplet/multisite/GetSiteDroplet">
									<dsp:param name="siteId" param="commerceItem.auxiliaryData.siteId" />
									<dsp:oparam name="output">
										<dsp:valueof param="site.name" />
									</dsp:oparam>
							</dsp:droplet></li>
						</ul>
					</div>
				</dsp:oparam>
			</dsp:droplet>

			<div class="subTotal">
				<dsp:valueof bean="ShoppingCart.current.priceInfo.amount"
					converter="currency" />
			</div>

			<div class="btnBox">
				<a href="checkout.jsp" class="btn"><span>checkout</span></a>
			</div>

		</div>

		<div id="footer"><jsp:include page="footer.jsp" /></div>
	</div>
</body>
</html>