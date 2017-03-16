<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="dsp" uri="http://www.atg.com/taglibs/daf/dspjspTaglib1_1" %>

<dsp:page>
<dsp:importbean bean="/atg/targeting/TargetingForEach" />
<dsp:importbean bean="/atg/userprofiling/Profile" />
<dsp:importbean bean="/atg/dynamo/droplet/multisite/SiteIdForItem" />
<dsp:importbean bean="/atg/dynamo/droplet/multisite/SiteLinkDroplet" />
<dsp:importbean bean="/atg/multisite/Site" />
<jsp:useBean id="me" class="com.clothingStore.test.SampleBean" scope="session" />
<head>


<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>DSPs give more!!!</title>
</head>

<body>

 
 <h1>Testing \${param.year} vs. &lt;dsp:param&gt;</h1>


</body>
  <dsp:setvalue param="year" value="1991"/> </td>
  <p> after dsp:setvalue</p>
  <table cellspacing="5" cellpadding="5" border="1">
    <tr>
      <td>
        \${param.year}
      </td>
      <td>
        ${param.year}
      </td>
    </tr>
    <tr>
      <td>
<pre>      
  &lt;dsp:a href="jspsample.jsp"&gt;Go to the jsp pages sample containing JSTL tags
     &lt;dsp:param name="year" param="year"/&gt;
  &lt/dsp:a&gt;
</pre> 
      </td>
      <td>
  <dsp:a href="jspsample.jsp">Go to the jsp pages sample containing JSTL tags
     <dsp:param name="year" param="year"/>
</dsp:a> 
      </td>
    </tr>
    <tr>
      <td>
        &lt;%=request.getParameter("year") %&gt;
      </td>
      <td>
        <%= request.getParameter("year") %>
      </td>      
    </tr>
  </table>
</dsp:page>
</html>

