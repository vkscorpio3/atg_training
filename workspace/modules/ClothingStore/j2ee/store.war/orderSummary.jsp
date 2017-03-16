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
            <div class="checkout">
                <h3>Checkout</h3>
                
                <div class="orderSummary">
                    <h4>review order:</h4>
                    <p style="padding-top: 8px;">Your order will not be processed until you review the information below and hit the <span class="blod uppercase">submit order</span> button.</p>
                    <div class="listBox">
                        <ul class="head">
                            <li class="item">Item</li>
                            <li class="qty">Quantity</li>
                            <li class="price">Amount</li>
                        </ul>
                    </div>
                    
                    <div class="listBox">
                        <ul>
                            <li class="item">
                                <p class="name"><a href="">Lee Men's Fit Stretch Jeans</a></p>
                            </li>
                            <li class="qty">1</li>
                            <li class="price">$199.00</li>
                        </ul>
                    </div>
                    
                    <div class="subTotal">Sub Total: $199.00</div>
                    <div class="total">Total: $199.00</div>
                </div>
                
                <div class="paymentInfo">
                    <h4>Payment Information</h4>
                    <p><span class="blod">Credit Card:</span>Visa</p>
                    <p><span class="blod">Number:</span>1000 0001 1000 1110</p>
                </div>
                
                <div class="shipping">
                    <h4>Ship To</h4>
                    <div class="info">
                        <p class="name">Joe Bruin</p>
                        <p>500 Oracle Parkway</p>
                        <p>Redwood Shores, CA 94065</p>
                        <p>USA</p>
                    </div>
                </div>
                
                <div class="btnBox">
                	<a href="checkout.jsp" class="btn"><span>back to checkout</span></a>
                    <a href="orderConfirmation.jsp" class="btn"><span>submit order</span></a>
                </div>
                
            </div>
            
            <div id="footer"><p><a href="#">about us</a></p></div>
		</div>
	</body>
</html>