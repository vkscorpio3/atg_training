<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link href="styles/layout.css" rel="stylesheet" type="text/css" media="all" />
<link href="styles/base.css" rel="stylesheet" type="text/css" media="all" />
<link href="styles/content.css" rel="stylesheet" type="text/css" media="all" />
<link href="styles/jquery_ui.css" rel="stylesheet" type="text/css" media="all" />
<title>demo</title>
</head>	
	<body>
		<div id="wrap" class="clear-block">
			<div id="header"><jsp:include page="header.jsp"/></div>
			<h3>shopping cart</h3>
            <div class="shoppingCart">
                <div class="listBox">
                    <ul class="head">
                        <li class="item">Item</li>
                        <li class="qty">Quantity</li>
                        <li class="price">Total Price</li>
                    </ul>
                </div>
                
                <div class="listBox">
                    <ul>
                        <li class="item">
                            <p class="name"><a href="">Lee Men's Fit Stretch Jeans</a></p>
                            <p>SKU: <span>#123456</span></p>
                        </li>
                        <li class="qty"><input type="text" name="" id="" class="textInput" value="1" /></li>
                        <li class="price">$199.00</li>
                    </ul>
                </div>
                
                <div class="subTotal">Sub Total: $199.00</div>
                
                <div class="btnBox"><a href="checkout.jsp" class="btn"><span>checkout</span></a></div>
                
            </div>
			<div id="footer"><jsp:include page="footer.jsp"/></div>
		</div>
	</body>
</html>