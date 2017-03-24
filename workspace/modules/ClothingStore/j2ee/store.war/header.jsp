<!--
 * @link
 * @lastmodified    $ Date: 02-07-2012 03:19 PM $
 * @purpose         header
-->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.atg.com/taglibs/daf/dspjspTaglib1_0"
	prefix="dsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<dsp:importbean bean="/atg/multisite/SiteManager" />
<dsp:importbean bean="/atg/dynamo/droplet/ForEach" />
<dsp:importbean bean="/atg/dynamo/droplet/multisite/SiteLinkDroplet" />
<dsp:importbean bean="/atg/dynamo/droplet/Switch" />

<div class="LogoBox">
	<a href="index.jsp" class="logo">&nbsp;</a>
</div>
<div class="loginBox">
	<dsp:page>
		<p>
			<a href="login.jsp">Login</a> <span class="cutline">|</span>

			<dsp:droplet name="/atg/dynamo/droplet/Switch">
				<dsp:param name="value" bean="/atg/userprofiling/Profile.transient" />
				<dsp:oparam name="true">
					<!--Not logged in -->
				</dsp:oparam>
				<dsp:oparam name="false">
                                      Welcome
                                      <dsp:valueof
						bean="/atg/userprofiling/Profile.firstName" />
				</dsp:oparam>
			</dsp:droplet>

			<span class="cutline">|</span>

			<!-- <a href="">Logout</a> -->

			<dsp:a href="index.jsp"
				bean="/atg/userprofiling/ProfileFormHandler.logout" value="true"> Logout </dsp:a>

			<span class="cutline">|</span> <a href="register.jsp">Register</a> <span
				class="cutline">|</span> <a href="stores.jsp">Stores</a>
		</p>
		<p>
			<a href="#">Shopping Cart</a>
			<dsp:valueof
				bean="/atg/commerce/ShoppingCart.current.totalCommerceItemCount" />
		</p>
		<div>
			<div>
				<dsp:getvalueof var="curSite" bean="/atg/multisite/Site.id"
					vartype="java.lang.String">
							The current site id is : ${curSite}
						</dsp:getvalueof>
			</div>
			<dsp:droplet name="ForEach">
				<dsp:param name="array" bean="SiteManager.activeSites" />
				<dsp:oparam name="output">
					<dsp:tomap var="item" param="element" recursive="false" />
					<dsp:droplet name="SiteLinkDroplet">
						<dsp:param name="siteId" value="${item.id }" />
						<dsp:oparam name="output">
							<dsp:getvalueof var="newUrl" param="url">
								<dsp:a href="${item.name}">${item.name}</dsp:a>
							</dsp:getvalueof>
						</dsp:oparam>
					</dsp:droplet>
				</dsp:oparam>
			</dsp:droplet>
			
		</div>
	</dsp:page>
</div>
