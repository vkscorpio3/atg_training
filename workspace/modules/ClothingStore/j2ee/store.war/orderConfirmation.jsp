<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ taglib prefix="dsp"
	uri="http://www.atg.com/taglibs/daf/dspjspELTaglib1_0"%>
<dsp:importbean bean="/clothing/store/MyFormHandler" />
<dsp:importbean bean="/atg/dynamo/droplet/ErrorMessageForEach" />
<dsp:importbean bean="/atg/commerce/ShoppingCart" />
<dsp:importbean bean="/atg/dynamo/droplet/ForEach" />
<dsp:importbean bean="/atg/commerce/ShoppingCart" />


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
		<div class="checkout">
			<h3>Thank you</h3>
			<div class="orderSummary">
				<dsp:droplet name="ForEach">
					<dsp:param name="array" bean="ShoppingCart.last.commerceItems" />
					<div class="listBox">
						<ul class="head">
							<li class="item">Item</li>
							<li class="qty">Quantity</li>
							<li class="price">Total Price</li>
						</ul>
					</div>
					<dsp:oparam name="output">
						<dsp:param name="commerceItem" param="element" />
						<div class="listBox">
							<ul>
								<li class="item">
									<p class="name">
										<dsp:valueof
											param="commerceItem.auxiliaryData.productRef.displayName" />
									</p>
								</li>
								<li class="qty"><dsp:valueof param="commerceItem.quantity" />
								</li>
								<li class="price"><dsp:valueof
										param="commerceItem.priceInfo.amount" converter="currency" />
								</li>
							</ul>
						</div>
					</dsp:oparam>
				</dsp:droplet>

			</div>

			<div class="shipping">
				<h4>Shipping</h4>

			</div>

			<div class="payment">
				<h4>Payment</h4>
			</div>

		</div>

		<div id="footer">
			<p>
				<a href="#">about us</a>
			</p>
		</div>
	</div>
</body>
</html>