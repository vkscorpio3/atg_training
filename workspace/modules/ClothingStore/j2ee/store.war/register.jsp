<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.atg.com/taglibs/daf/dspjspTaglib1_0"
	prefix="dsp"%>
<dsp:importbean bean="/atg/userprofiling/ProfileFormHandler" />
<dsp:importbean bean="/atg/dynamo/droplet/ErrorMessageForEach" />
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
			<div id="header">
				<jsp:include page="header.jsp" />
			</div>
			<h3>register</h3>
			<div class="register">
				<div class="error">Please fill in all required info below in
					right format.</div>
				<dsp:form method="post" action="register.jsp">
					<table>
						<tbody>
							<tr>
								<td width="150">First Name *</td>
								<td><dsp:input bean="ProfileFormHandler.value.firstName"
										maxlength="30" size="25" type="text" required="true" /></td>
							</tr>
							<tr>
								<td>Last Name *</td>
								<td><dsp:input bean="ProfileFormHandler.value.lastName"
										maxlength="30" size="25" type="text" required="true" /></td>
							</tr>
							<tr>
								<td>Email *</td>
								<td><dsp:input bean="ProfileFormHandler.value.login"
										maxlength="30" size="25" type="text" required="true" /></td>
							</tr>
							<tr>
								<td>Password *</td>
								<td><dsp:input bean="ProfileFormHandler.value.password"
										maxlength="30" size="25" type="password" required="true" /></td>
							</tr>
							<tr>
								<td>Confirm Password *</td>
								<td><dsp:input
										bean="ProfileFormHandler.value.confirmpassword" maxlength="30"
										size="25" type="password" required="true" /></td>
							</tr>
							<tr>
								<td>Gender *</td>
								<td><dsp:input type="radio"
										bean="ProfileFormHandler.value.gender" value="male">Male</dsp:input>
									<dsp:input type="radio" bean="ProfileFormHandler.value.gender"
										value="female">Female</dsp:input></td>
							</tr>
							<tr>
								<td>Day *</td>
								<td><dsp:input bean="ProfileFormHandler.day" maxlength="30"
										size="25" type="text" required="true" /></td>
								<td>Month *</td>
								<td><dsp:input bean="ProfileFormHandler.month"
										maxlength="30" size="25" type="text" required="true" /></td>
								<td>Year *</td>
								<td><dsp:input bean="ProfileFormHandler.year"
										maxlength="30" size="25" type="text" required="true" /></td>
							</tr>
							<tr>
								<td>Favorite Store</td>
								<td><dsp:select
										bean="ProfileFormHandler.value.favoriteStore">
										<dsp:droplet name="/atg/dynamo/droplet/RQLQueryForEach">
											<dsp:param name="repository" value="/clothing/store/StoreRepository" />
											<dsp:param name="itemDescriptor" value="BricsMorter" />
											<dsp:param name="queryRQL" value="ALL" />
											<dsp:oparam name="output">
												<dsp:option>
													<dsp:valueof param="element.storeName"></dsp:valueof>
												</dsp:option>
											</dsp:oparam>
										</dsp:droplet>
									</dsp:select></td>
							</tr>
							<tr>
								<td><dsp:input bean="ProfileFormHandler.create"
										type="submit" value="Register" /> <dsp:input
										bean="ProfileFormHandler.createSuccessURL" type="hidden"
										value="index.jsp" /></td>
							</tr>
							<tr>
								<td colspan="2">
									<ul>
										<dsp:droplet name="ErrorMessageForEach">
											<dsp:param bean="ProfileFormHandler.formExceptions"
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
				</dsp:form>
			</div>
			<div id="footer">
				<jsp:include page="footer.jsp" />
			</div>
		</div>
	</dsp:page>
</body>
</html>