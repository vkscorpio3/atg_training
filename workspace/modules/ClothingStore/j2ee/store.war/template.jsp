<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="dsp" uri="http://www.atg.com/taglibs/daf/dspjspTaglib1_1" %>

<dsp:page>
<%-- put jsp:usebean and dsp:importbean tags here. For example --%>
<dsp:importbean bean="/atg/userprofiling/Profile" />
<dsp:importbean bean="/atg/multisite/Site" />


<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>JSP Template</title>
</head>

<body>
<h1>Welcome to ATG</h1>
        <dsp:droplet name="/atg/commerce/catalog/ProductLookup">
          <dsp:param name="id" param="itemId" />
          <dsp:oparam name="output">
            <dsp:setvalue param="product" paramvalue="element" />

            <%-- Display name --%>
            <h3 class="green">
              Product: <dsp:valueof param="product.displayName" />
            </h3>
          </dsp:oparam>
        </dsp:droplet>
</body>
  
</dsp:page>
</html>

