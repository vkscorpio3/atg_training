<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="dsp" uri="http://www.atg.com/taglibs/daf/dspjspELTaglib1_0" %>
<dsp:importbean bean="/atg/commerce/ShoppingCart"/>
<dsp:importbean bean="/atg/dynamo/droplet/ForEach"/>
<dsp:importbean bean="/clothing/store/MyFormHandler"/>
<dsp:importbean bean="/atg/commerce/order/purchase/CommitOrderFormHandler"/>
<dsp:importbean bean="/atg/dynamo/droplet/Switch" />

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
                    <dsp:include page="cartSummary.jsp">
                        <dsp:param name="myCart" bean="/atg/commerce/ShoppingCart.current" />
                    </dsp:include>
                </div>
                
                <div class="paymentInfo">
                    <h4>Payment Information</h4>
                    <p>
                        <span class="blod">Credit Card:</span>
                        <dsp:valueof bean="MyFormHandler.paymentGroup.creditCardType"/>
                    </p>
                    <p>
                        <span class="blod">Number:</span>
                        <dsp:valueof bean="MyFormHandler.paymentGroup.creditCardNumber"
                            converter="CreditCard" groupingsize="4" />
                    </p>
                </div>
                
                <div class="shipping">
                    <h4>Ship To</h4>
                    <dsp:include page="shippingInfo.jsp">
                        <dsp:param name="shipping" bean="/atg/commerce/ShoppingCart.current.shippingGroups[0]" />
                    </dsp:include>
                </div>
                
                <div class="btnBox">
                    <dsp:form action="orderSummary.jsp" method="post">
                        <dsp:input bean="CommitOrderFormHandler.commitOrderSuccessURL" type="hidden"
                                   value="orderConfirmation.jsp">
                        </dsp:input>
                        <dsp:a href="checkout.jsp" iclass="btn"><span>back to checkout</span></dsp:a>
                        <dsp:input bean="CommitOrderFormHandler.commitOrder" type="submit" value="submit order"
                                   iclass="btn">
                        </dsp:input>
                    </dsp:form>
                </div>
                
            </div>
            
            <div id="footer"><p><a href="#">about us</a></p></div>
        </div>
    </body>
</html>