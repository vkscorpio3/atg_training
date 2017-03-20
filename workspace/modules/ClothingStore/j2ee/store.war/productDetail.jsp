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
				<div class="prodDetail">
					<dsp:droplet name="/atg/commerce/catalog/ProductLookup">
						<dsp:param name="id" param="productId" />
						<dsp:oparam name="output">
							<dsp:setvalue param="product" paramvalue="element" />
							<dsp:valueof param="product.displayName" />

							<dsp:getvalueof var="imgURL" param="product.thumbnailImage.url" />
							<dsp:getvalueof var="skuItem" param="product.childSKUs[0]" />
							<dsp:getvalueof var="price" param="product.childSKUs[0].listPrice" />


							<img src="${imgURL}" />
							<br></br>
							<b>Price: ${price}</b>
							<br></br>

							<dsp:droplet name="/atg/commerce/inventory/InventoryLookup">
								<dsp:param param="product.childSKUs[0].repositoryId" name="itemId" />
								<dsp:oparam name="output">
									<b> INVENTORY: <dsp:valueof param="inventoryInfo.availabilityStatusMsg" /></b>
									<br></br>
								</dsp:oparam>
							</dsp:droplet>
							
							<dsp:droplet name="/atg/commerce/pricing/PriceItem">
								<dsp:param name="item" param="product.childSKUs[0]" />
								<dsp:param name="product" param="product" />
								
								<dsp:oparam name="output">
									<br>
										<b>Discount: <dsp:valueof param="element.priceInfo.amount" /> </b>
									</br>
								</dsp:oparam>
							</dsp:droplet>

						</dsp:oparam>
					</dsp:droplet>
				</div>
			</div>
			<div id="footer"><jsp:include page="footer.jsp" /></div>
		</div>
	</dsp:page>
</body>
</html>