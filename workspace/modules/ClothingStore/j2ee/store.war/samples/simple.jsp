<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="dsp" uri="http://www.atg.com/taglibs/daf/dspjspTaglib1_1" %>

<dsp:page>

<head>


<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>DSPs give more!!!</title>
</head>

<body>

 
<h1>testing</h1>

</body>
  <dsp:setvalue param="year" value="1066"/> 
  <p> after dsp:setvalue</p>
  
<c:set var="year" value="2525" />
  
<p>     
  <dsp:a href="jspsample.jsp">Look at the year query parameter in this URL
     <dsp:param name="year" param="year"/>
  </dsp:a> 
</p>

<p>
  <dsp:a href="jspsample.jsp">Look at the year query parameter in this URL
     <dsp:param name="whichyear" value="${param.year}"/>
  </dsp:a> 
</p>
   
<p>param.year: ${param.year}</p>
<p>pageScope.param.year: ${pageScope.param.year}</p>
<p>requestScope.param.year: ${requestScope.param.year}</p>
<p>sessionScope.param.year: ${sessionScope.param.year}</p>
<p>applicationScope.param.year: ${applicationScope.param.year}</p>
<p>pageContext.request.parameterMap.year[0]: ${pageContext.request.parameterMap.year[0]}</p>
<p>pageContext.request.attributeNames: ${pageContext.request.attributeNames}</p>
<p>requestScope.year ${requestScope.year}</p>
<p>pageScope.year: ${pageScope.year}</p>
<p>param: <dsp:valueof param="year"/></p>

</dsp:page>
</html>

