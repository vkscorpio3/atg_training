<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.clothingStore.test.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<dsp:page>
<dsp:importbean bean="/atg/userprofiling/Profile"/>
<dsp:importbean bean="/atg/dynamo/droplet/Switch"/> 
<dsp:importbean bean="/bogus/multisite/SitePopupSwitchDroplet"/>
<jsp:useBean id="me" class="com.clothingStore.test.SampleBean" scope="session" />
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Hello</title>
</head>

    <body>     
<%
   com.clothingStore.test.SampleBean sampleBean = (com.clothingStore.test.SampleBean)request.getAttribute("you");
   if (sampleBean == null) {
     sampleBean = new com.clothingStore.test.SampleBean();
   }
%>

      <dsp:droplet name="Switch">
        <dsp:param name="value" bean="Profile.transient"/>
        <dsp:oparam name="false">
	       Welcome, <dsp:valueof bean="Profile.firstName“ />x
	    </dsp:oparam>
	    <dsp:oparam name="true">
	       Estudante Bem-vindo!
        </dsp:droplet>
      </dsp:droplet>
      <div>
        String: <jsp:getProperty name="me" property="samplePropertyString"/>
      </div>
      <div>
        Int: <jsp:getProperty name="me" property="samplePropertyInt"/>
      </div>
    </body>

  </dsp:page>
</html>
