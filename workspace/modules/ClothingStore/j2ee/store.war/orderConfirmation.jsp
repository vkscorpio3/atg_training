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
                <h3>Thank you</h3>
                
                <div class="order"><span>Order#:</span>123456</div>
                
                <div class="orderSummary">
                    <h4>Order Summary:</h4>
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
                
                <div class="shipping">
                    <h4>Shipping</h4>
                    <div class="info">
                        <p class="name">Mr.</p>
                        <p>500 Oracle Parkway</p>
                        <p>Redwood Shores, CA 94065</p>
                        <p>USA</p>
                    </div>
                </div>
                
                <div class="payment">
                    <h4>Payment</h4>
                    <div class="info">
                        <p class="name">Mr.</p>
                        <p>Visa **** **** **** 1234 Exp. mm/year</p>
                        <p>500 Oracle Parkway</p>
                        <p>Redwood Shores, CA 94065</p>
                        <p>USA</p>
                    </div>
                </div>
                
            </div>
            
            <div id="footer"><p><a href="#">about us</a></p></div>
		</div>
	</body>
</html>