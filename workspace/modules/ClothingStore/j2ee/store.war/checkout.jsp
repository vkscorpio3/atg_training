<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="dsp"
	uri="http://www.atg.com/taglibs/daf/dspjspELTaglib1_0"%>
<dsp:importbean bean="/clothing/store/MyFormHandler" />
<dsp:importbean bean="/atg/dynamo/droplet/ErrorMessageForEach" />

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
	<dsp:form>
		<div id="wrap" class="clear-block">
			<div class="checkout">
				<h3>Checkout</h3>

				<div class="box">
					<h4>shipping address</h4>

					<table>
						<tbody>
							<tr>
								<td width="130">First Name *</td>
								<td><dsp:input
										bean="MyFormHandler.shippingGroup.shippingAddress.firstName"
										maxlength="30" size="25" type="text" required="true" /></td>
							</tr>
							<tr>
								<td>Last Name *</td>
								<td><dsp:input
										bean="MyFormHandler.shippingGroup.shippingAddress.lastName"
										maxlength="30" size="25" type="text" required="true" /></td>
							</tr>
							<tr>
								<td>Address Line 1 *</td>
								<td><dsp:input
										bean="MyFormHandler.shippingGroup.shippingAddress.address1"
										maxlength="30" size="25" type="text" required="true" /></td>
							</tr>
							<tr>
								<td>Address Line 2</td>
								<td><dsp:input
										bean="MyFormHandler.shippingGroup.shippingAddress.address2"
										maxlength="30" size="25" type="text" required="true" /></td>
							</tr>
							<tr>
								<td>City *</td>
								<td><dsp:input
										bean="MyFormHandler.shippingGroup.shippingAddress.city"
										maxlength="30" size="25" type="text" required="true" /></td>
							</tr>
							<tr>
								<td>State *</td>
								<td><dsp:input
										bean="MyFormHandler.shippingGroup.shippingAddress.state"
										maxlength="30" size="25" type="text" required="true" /></td>
							</tr>
							<tr>
								<td>Country *</td>
								<td><dsp:input
										bean="MyFormHandler.shippingGroup.shippingAddress.country"
										maxlength="30" size="25" type="text" required="true" /></td>
							</tr>
							<tr>
								<td>Postal Code *</td>
								<td><dsp:input
										bean="MyFormHandler.shippingGroup.shippingAddress.postalCode"
										maxlength="30" size="25" type="text" required="true" /></td>
							</tr>
						</tbody>
					</table>

				</div>

				<div class="box">
					<h4>payment information</h4>
					<table>
						<tbody>
							<tr>
								<td width="130">First Name *</td>
								<td><dsp:input
										bean="MyFormHandler.paymentGroup.billingAddress.firstName"
										maxlength="30" size="25" type="text" required="true" /></td>
							</tr>
							<tr>
								<td>Last Name *</td>
								<td><dsp:input
										bean="MyFormHandler.paymentGroup.billingAddress.lastName"
										maxlength="30" size="25" type="text" required="true" /></td>
							</tr>
							<tr>
								<td>Address Line 1 *</td>
								<td><dsp:input
										bean="MyFormHandler.paymentGroup.billingAddress.address1"
										maxlength="30" size="25" type="text" required="true" /></td>
							</tr>
							<tr>
								<td>Address Line 2</td>
								<td><dsp:input
										bean="MyFormHandler.paymentGroup.billingAddress.address2"
										maxlength="30" size="25" type="text" required="true" /></td>
							</tr>
							<tr>
								<td>City *</td>
								<td><dsp:input
										bean="MyFormHandler.paymentGroup.billingAddress.city"
										maxlength="30" size="25" type="text" required="true" /></td>
							</tr>
							<tr>
								<td>State *</td>
								<td><dsp:input
										bean="MyFormHandler.paymentGroup.billingAddress.state"
										maxlength="30" size="25" type="text" required="true" /></td>
							</tr>
							<tr>
								<td>Country *</td>
								<td><dsp:input
										bean="MyFormHandler.paymentGroup.billingAddress.country"
										maxlength="30" size="25" type="text" required="true" /></td>
							</tr>
							<tr>
								<td>Credit Card Type:</td>
								<td><dsp:input
										bean="MyFormHandler.paymentGroup.creditCardType"
										maxlength="30" size="25" type="text" required="true" /></td>

							</tr>
							<tr>
								<td>Postal Code *</td>
								<td><dsp:input
										bean="MyFormHandler.paymentGroup.billingAddress.postalCode"
										maxlength="30" size="25" type="text" required="true" /></td>
							</tr>
							<tr>
								<td>Credit Card Number *</td>
								<td><dsp:input
										bean="MyFormHandler.paymentGroup.creditCardNumber"
										maxlength="30" size="25" type="text" required="true" /></td>
							</tr>
							<tr>
								<td>Expiration Date *</td>
								<td><input type="text" name="" id="" class="textInput" /></td>
							</tr>
							<tr>
								<td>Security Code*</td>
								<td><dsp:input
										bean="MyFormHandler.paymentGroup.cardVerficationNumber"
										maxlength="30" size="25" type="text" required="true" /></td>
							</tr>
							<tr>
								<td><dsp:input
										bean="MyFormHandler.handleMoveToConfirmation" type="submit"
										value="Click" /></td>
								<td><dsp:input
										bean="MyFormHandler.handleMoveToConfirmationSuccessURL" type="hidden"
										value="index.jsp" /></td>
							</tr>
							<tr>
								<td colspan="2">
									<ul>
										<dsp:droplet name="ErrorMessageForEach">
											<dsp:param bean="MyFormHandler.formExceptions"
												name="exceptions" />
											<dsp:oparam name="output">
												<li><dsp:valueof param="message" /></li>
											</dsp:oparam>
										</dsp:droplet>
									</ul>
								</td>
							</tr>
						</tbody>
					</table>
				</div>

			</div>
		</div>
	</dsp:form>
</body>
</html>