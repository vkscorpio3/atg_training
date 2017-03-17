<!--
 * @link
 * @lastmodified    $ Date: 02-07-2012 03:19 PM $
 * @purpose         header
-->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.atg.com/taglibs/daf/dspjspTaglib1_0" prefix="dsp" %>



<div class="LogoBox"><a href="index.jsp" class="logo">&nbsp;</a></div>
<div class="loginBox">
	<p>
    	<a href="login.jsp">Login</a>
        <span class="cutline">|</span>

        <dsp:droplet name="/atg/dynamo/droplet/Switch">
                        <dsp:param name="value" bean="/atg/userprofiling/Profile.transient"/>
                        <dsp:oparam name="true">
                                        <!--Not logged in -->
                        </dsp:oparam>
                        <dsp:oparam name="false">
                                      Welcome
                                      <dsp:valueof bean="/atg/userprofiling/Profile.firstName" />
                        </dsp:oparam>
        </dsp:droplet>

        <span class="cutline">|</span>

        <!-- <a href="">Logout</a> -->

        <dsp:a href="index.jsp" bean="/atg/userprofiling/ProfileFormHandler.logout" value="true" > Logout </dsp:a>

        <span class="cutline">|</span>
        <a href="register.jsp">Register</a>

        <span class="cutline">|</span>
        <a href="stores.jsp">Stores</a>
    </p>
    <p><a href="shoppingCart.jsp">Shopping Cart</a> ( <span class="orange blod">2</span> items)</p>
</div>