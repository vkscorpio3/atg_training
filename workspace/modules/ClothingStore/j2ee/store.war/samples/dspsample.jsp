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

 
 <h1>Using the ATG DSP Tag Library</h1>

<h2>dsp:a tag</h2>
<table cellspacing="5" cellpadding="5" border="1">
  <tr>
      <td>
<pre>      
&lt;dsp:a href="jspsample.jsp"&gt;Go to the jsp pages sample containing JSTL tags
     &lt;dsp:param name="year" value="2017"/&gt;
&lt;/dsp:a&gt;
</pre>
     </td>
      <td>
<dsp:a href="jspsample.jsp">Go to the jsp pages sample containing JSTL tags
     <dsp:param name="year" value="2017"/>
</dsp:a> 
      </td>
  </tr>
  <tr>
      <td>
<pre>      
&lt;dsp:a href="jspsample.jsp"&gt;Go to the jsp pages sample containing JSTL tags
     &lt;dsp:param name="year" param="year"/&gt;
&lt;/dsp:a&gt;
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
<pre>      
&lt;dsp:a href="jspsample.jsp"&gt;Go to the jsp pages sample containing JSTL tags
     &lt;dsp:param name="year" value="\${param.year}"/&gt;
&lt;/dsp:a&gt;
</pre>
     </td>
      <td>
<dsp:a href="jspsample.jsp">Go to the jsp pages sample containing JSTL tags
     <dsp:param name="year" value="${param.year}"/>
</dsp:a> 
      </td>
  </tr>    
  <tr>
      <td>
<pre>      
&lt;dsp:a href="jspsample.jsp"&gt;Go to the jsp pages sample containing JSTL tags
     &lt;dsp:param name="id" bean="Profile.id"/&gt;
&lt;/dsp:a&gt;
</pre>
     </td>
      <td>
<dsp:a href="jspsample.jsp">Go to the jsp pages sample containing JSTL tags
     <dsp:param name="id" bean="Profile.id"/>
</dsp:a> 
      </td>
  </tr>     
</table>  


<h2>dsp:valueof</h2 examples>
<table cellspacing="5" cellpadding="5" border="1">
  <tr>
      <td>
         &lt;dsp:valueof value="Yet another constant"/&gt;
      </td>
      <td>
         <dsp:valueof value="Yet another constant"/>
      </td>
  </tr>  
  <tr>
      <td>
&lt;dsp:valueof bean="Profile.id" /&gt;
      </td>
      <td>
<dsp:valueof bean="Profile.id" />
      </td>
  </tr>
  <tr>
      <td>
<pre>      
&lt;dsp:valueof param="year" /&gt;
No year parameter specified
&lt;/dsp:valueof&gt;
</pre>
      </td>
      <td>
<dsp:valueof param="year" >
No year parameter specified
</dsp:valueof>
      </td>
  </tr>  
</table>


<h2>dsp:setvalue</h2 examples>
<table cellspacing="5" cellpadding="5" border="1">
  <tr>
    <td colspan="2" align="center"> <strong> sets ... </strong></td>
  </tr>
  <tr>
      <td colspan="2"> &lt;dsp:setvalue param="year" value="1991"/&gt; 
      <dsp:setvalue param="year" value="1991"/> </td>
  </tr>  
  <tr>
      <td colspan="2">&lt;dsp:setvalue bean="Profile.firstName" value="Tim"/&gt;
      <dsp:setvalue bean="Profile.firstName" value="Tim" /> </td>
  </tr>
  <tr>
      <td colspan="2">  &lt;dsp:setvalue param="name" beanvalue="Profile.firstName" /&gt; 
      <dsp:setvalue param="name" beanvalue="Profile.firstName" /> </td>
  </tr>  
  <tr>
    <td colspan="2" align="center"> <strong> usage ... </strong></td>
  </tr>
  <tr>
      <td>  &lt;dsp:valueof bean="Profile.firstName" /&gt; </td>
      <td> <dsp:valueof bean="Profile.firstName" /> </td>
  </tr> 
       <tr>
      <td>  &lt;dsp:valueof param="year" /&gt; </td>
      <td> <dsp:valueof param="year" /> </td>
  </tr>  
  </tr> 
       <tr>
      <td>  &lt;dsp:valueof param="name" /&gt; </td>
      <td> <dsp:valueof param="name" /> </td>
  </tr>    
  <tr>
      <td>
<pre>      
&lt;dsp:a href="jspsample.jsp"&gt;Go to the jsp pages sample containing JSTL tags
     &lt;dsp:param name="whichyear" value="\${param.year}"/&gt;
&lt;/dsp:a&gt;
</pre>
     </td>
      <td>
<dsp:a href="jspsample.jsp">Go to the jsp pages sample containing JSTL tags
     <dsp:param name="whichyear" value="${param.year}"/>
</dsp:a> 
      </td>
  </tr>      
  <tr>
      <td>
<pre>      
&lt;dsp:a href="jspsample.jsp"&gt;Go to the jsp pages sample containing JSTL tags
     &lt;dsp:param name="whichyear" param="year"/&gt;
&lt;/dsp:a&gt;
</pre>
     </td>
      <td>
<dsp:a href="jspsample.jsp">Go to the jsp pages sample containing JSTL tags
     <dsp:param name="whichyear" param="year"/>
</dsp:a> 
      </td>
  </tr>   
  <tr>
    <td>
<pre>    
&lt;dsp:getvalueof var="ayear" param="year" vartype="java.lang.String"&gt;
   &lt;p&gt;This is \${ayear}&lt;/p&gt;
&lt;/dsp:getvalueof&gt;   
</pre>
    </td>
    <td>
<dsp:getvalueof var="ayear" param="year" vartype="java.lang.String">
   <p>This is ${ayear}</p>
</dsp:getvalueof>    
    </td>
  </tr>
</table>


<h2>c:forEach droplet to get headers</h2>
<dsp:droplet name="/atg/dynamo/droplet/ForEach">
  <dsp:param name="array" value="${header}" />

  <dsp:oparam name="empty">
    <p>No headers in this request.</p>
  </dsp:oparam>

  <%-- Display a title before looping thru students in the array: --%>
  <dsp:oparam name="outputStart">
    <table border="1">
      <tr>
        <th>Name</th>
        <th>Value</th>
      </tr>
  </dsp:oparam>

  <%-- display this output for each header: --%>
  <dsp:oparam name="output">
    <tr>
      <td><dsp:valueof param="key"/></td>
      <td><dsp:valueof param="element"/></td>
    </tr>
  </dsp:oparam>
  
  <%-- Display this after looping thru all students in the array: --%>
  <dsp:oparam name="outputEnd">
      <tr>
        <td><strong>Total number of headers</strong></td>
        <td><dsp:valueof param="size"/></td>
      </tr>
    </table>
  </dsp:oparam>
</dsp:droplet>

<br />

<table cellspacing="5" cellpadding="5" border="1">  
  <c:forEach var="head" items="${header}">
    <tr>
      <td>${head.key}</td><td>${head.value}</td>
    </tr>
  </c:forEach>  
 </table>
<hr />

<h1> Using JSP Tags </h1>

<h2> Setting Properties via jsp:setProperty</h2>


<jsp:setProperty name="me" property="samplePropertyString" value="New Value" />
<jsp:setProperty name="me" property="samplePropertyInt" param="year" />

<table cellspacing="5" cellpadding="5" border="1">
  <tr>
      <td align="right">Setting String Property:</td>
      <td><jsp:getProperty name="me" property="samplePropertyString"/></td>
  </tr>
  <tr>
      <td align="right">Setting Int Property:</td>
      <td><jsp:getProperty name="me" property="samplePropertyInt"/></td>
  </tr>
</table>

<%-- WE CANNOT get to NESTED PROPERTIES with JSP tags
<h1>Nested Properties via <strong>jsp:getProperty</strong></h1>
<table cellspacing="5" cellpadding="5" border="1">
  <tr>
      <td align="right">Getting an object Property:</td>
      <td><jsp:getProperty name="me" property="samplePropertyAddress.name" /></td>
  </tr>
  <tr>
      <td align="right">Getting a Nested Property:</td>
      <td><jsp:getProperty name="me" property="samplePropertyAddress.street" /></td>
  </tr>
</table>
--%>

<h1>EL Expressions</h1>

<h2>Nested Properties via EL Expressions</h2>
<table cellspacing="5" cellpadding="5" border="1">
  <tr>
      <td align="right">\${me}</td>
      <td>${me}</td>
  </tr>
  <tr>
      <td align="right">\${me.samplePropertyInt}</td>
      <td>${me.samplePropertyInt}</td>
  </tr>
  <tr>
      <td align="right">\${me.samplePropertyAddress}</td>
      <td>${me.samplePropertyAddress}</td>
  </tr>  
  <tr>
      <td align="right">\${me.samplePropertyAddress["name"]}</td>
      <td>${me.samplePropertyAddress["name"]}</td>
  </tr>   
  <tr>
      <td align="right">\${17.5+10}:</td>
      <td>${17.5+10}</td>
  </tr>  
  <tr>
      <td align="right">10+\${param.year}:</td>
      <td>${10+param.year}</td>
  </tr>   
  <tr>
      <td align="right">\${empty param.year ? "1990" : param.year}:</td>
      <td>${empty param.year ? "1990" : param.year}</td>
  </tr>   
</table>

<h2>Accessing Implicit Objects using EL Expressions</h2>
<table cellspacing="5" cellpadding="5" border="1">
  <tr>
      <td align="right">\${param.year}</td>
      <td>${param.year}</td>
  </tr>
  <tr>
      <td align="right">\${header.accept}</td>
      <td>${header.accept}</td>
  </tr>
  <tr>
      <td align="right">\${header["accept-encoding"]}</td>
      <td>${header["accept-encoding"]}</td>
  </tr>
  <tr>
      <td align="right">\${cookie.timsCookie.value}</td>
      <td>${cookie.timsCookie.value}</td>
  </tr>  
  <tr>
      <td align="right">\${pageContext.request.method}:</td>
      <td>${pageContext.request.method}</td>
  </tr>    
  <tr>
      <td align="right">\${pageContext.session.id}</td>
      <td>${pageContext.session.id}</td>
  </tr>   
  <tr>
      <td align="right">\${pageContext.response.contentType}</td>
      <td>${pageContext.response.contentType}</td>
  </tr>    
  <tr>
      <td align="right">\${pageContext.servletContext.contextPath}</td>
      <td>${pageContext.servletContext.contextPath}</td>
  </tr>   
</table>

<h1>Using JSTL (<a href="http://docs.oracle.com/javaee/5/jstl/1.1/docs/tlddocs">doc</a>)</h1>

<table cellspacing="5" cellpadding="5" border="1">
  <tr>
      <td>c:url tag</td>
      <td align="right">&lt;a href="&lt;c:url value='/test.jsp' /&gt;"&gt;test&lt;/a&gt;</td>
      <td><a href="<c:url value='/test.jsp' />">test</a></td>
  </tr>
</table>

<h2>c:forEach tag to get cookies</h2>
<table cellspacing="5" cellpadding="5" border="1">
  <c:forEach var="kookie" items="${cookie}">
    <tr>
      <td>${kookie.key}</td><td>${kookie.value.value}</td>
    </tr>
  </c:forEach>
 </table>
   
<h2>tag to get params</h2>
<p>param = ${param}</p>
<p>paramValues = ${paramValues}</p>
<br />    
    
 
 <h2>c:forEach tag to get paramValues</h2>
<table cellspacing="5" cellpadding="5" border="1">  
  <c:forEach var="pv" items="${paramValues}">
    <tr>
    <tr>
      <td>${pv.key}</td><td>${paramValues[pv.key][0]}</td>
    </tr>    </tr>
  </c:forEach>  
 </table>
    
<p>request parameter year is <%= request.getParameter("year") %></p>
<p>request attribute year is <%= request.getAttribute("year") %></p>
     
<h2>c:forEach tag to get headers</h2>
<table cellspacing="5" cellpadding="5" border="1">  
  <c:forEach var="head" items="${header}">
    <tr>
      <td>${head.key}</td><td>${head.value}</td>
    </tr>
  </c:forEach>  
 </table>
 

 <h2>c:forEach tag to get request scoped attributes</h2>
<table cellspacing="5" cellpadding="5" border="1">  
  <c:forEach var="attr" items="${requestScope}">
    <tr>
      <td>${attr.key}</td><td>${attr.value}</td>
    </tr>
  </c:forEach>  
 </table>


 <h2>c:forEach tag to get request scoped attributes</h2>
<table cellspacing="5" cellpadding="5" border="1">  
  <c:forEach var="attr" items="${requestScope}">
    <tr>
      <td>${attr.key}</td><td>${attr.value}</td>
    </tr>
  </c:forEach>  
 </table>




  
<h2>c:forEach tag to get page scoped attributes</h2>
<table cellspacing="5" cellpadding="5" border="1">  
  <c:forEach var="attr" items="${pageScope}">
    <tr>
      <td>${attr.key}</td><td>${attr.value}</td>
    </tr>
  </c:forEach>  
 </table>
 
<h2>c:forEach tag to get session scoped attributes</h2>
<table cellspacing="5" cellpadding="5" border="1">  
  <c:forEach var="attr" items="${sessionScope}">
    <tr>
      <td>${attr.key}</td><td>${attr.value}</td>
    </tr>
  </c:forEach>  
 </table>

<h2>c:forEach tag to get application scoped attributes</h2>
<table cellspacing="5" cellpadding="5" border="1">  
  <c:forEach var="attr" items="${applicationScope}">
    <tr>
      <td>${attr.key}</td><td>${attr.value}</td>
    </tr>
  </c:forEach>  
 </table>
 
 <h2>c:forEach tag to get nucleus configPathNames</h2>
<table cellspacing="5" cellpadding="5" border="1">  
  <c:forEach var="attr" items='${applicationScope["atg.nucleus"].configPathNames}'>
    <tr>
      <td>${attr}</td>
    </tr>
  </c:forEach>  
 </table>
 <br />
 Hello ${pageContext}
<br />
Show me ${requestScope["atg.servlet.request"]}
<br />

<h2>c:if tag (with c:out)</h2>
<table cellspacing="5" cellpadding="5" border="1">
  <tr>
      <td>
		\${me.samplePropertyInt}
      </td>
      <td>
		${me.samplePropertyInt}
      </td>      
  </tr>
  <tr>      
      <td>
<pre>      
&lt;c:if test="\${me.samplePropertyInt == '1999'}"&gt;
  &lt;c.out value="We\'re going to party like it\'s \${me.samplePropertyInt}!"/&gt; 
&lt;/c:if&gt;
</pre>
      </td>
      <td>
<c:if test="${me.samplePropertyInt == 1999}">     
 <c:out value="We\'re going to party like it\'s ${me.samplePropertyInt}!"/>  
</c:if>     
      </td>
  </tr>
</table>  


<h2> c:url with c:param</h2>

<table cellspacing="5" cellpadding="5" border="1">
  <tr>
      <td>
<pre>      
&lt;c:url value="www.google.com/finance?q=aapl" /&gt;
  &lt;c:param name="q" value="aapl" /&gt;
&lt;/c:url&gt;       
</pre> 
      </td>
      <td>
        <c:url value="www.google.com/finance" >
           <c:param name="q" value="aapl" />
        </c:url>
      </td>
  </tr>
</table> 


<h2>c:choose tag with c:when and c:otherwise</h2>

<table cellspacing="5" cellpadding="5" border="1">  
    <tr>
      <td>
<pre>      
 &lt;c:choose&gt;
  &lt;c:when test="\${param.year &lt; 2000}"&gt;
     &lt;p&gt;Old Bird&lt;/p&gt; 
  &lt;/c:when&gt;
  &lt;c:when test="\${param.year == 2000}"&gt;
     &lt;p&gt;Millennium Falcon&lt;/p&gt; 
  &lt;/c:when&gt;
  &lt;c:otherwise&gt;
     &lt;p&gt;Babe in the woods.&lt;/p&gt; 
  &lt;/c:otherwise&gt;
&lt;/c:choose&gt;  
</pre>   
      </td>
      <td>
<c:choose>
  <c:when test="${param.year < 2000}">
     <p>Old Bird</p> 
  </c:when>
  <c:when test="${param.year == 2000}">
     <p>Millennium Falcon</p> 
  </c:when>
  <c:otherwise>
     <p>Babe in the woods.</p> 
  </c:otherwise>
</c:choose>      
      </td>      
    </tr>
 </table>

<h2>c:import tag</h2>
<table cellspacing="5" cellpadding="5" border="1">
  <tr>
      <td>
&lt;c:import url="http://www.google.com" /&gt;
      </td>
      <td>
<c:import url="http://www.google.com" />
      </td>
  </tr>
</table>

<h2> JSTL functions </h2>

<table cellspacing="5" cellpadding="5" border="1">
  <tr>
      <td>
\${fn:length(me.samplePropertyAddress["name"])}
      </td>
      <td>
${fn:length(me.samplePropertyAddress["name"])}
      </td>
  </tr>

  <tr>
      <td>
<pre>
|&lt;\${fm:trim("      Is this a string with a lot of leading and trailing spaces?       ")}/&gt;|
</pre>
      </td>
      <td>
|${fn:trim("      Is this a string with a lot of leading and trailing spaces?       ")}|
      </td>
  </tr>

  <tr>
      <td>
<pre>      
&lt;c:if test="\${fn:contains(me.samplePropertyAddress['name'], 'Tim')}"&gt;
   Hello Tim
&lt;/c:if&gt;
</pre>
      </td>
      <td>
<c:if test="${fn:contains(me.samplePropertyAddress['name'], 'Tim')}">
   Hello Tim
</c:if>
      </td>
  </tr>

  <tr>
      <td>
Hello \${fn:replace(me.samplePropertyAddress["name"], "Tim", "Timothy")}
      </td>
      <td>
Hello ${fn:replace(me.samplePropertyAddress["name"], "Tim", "Timothy")}
      </td>
  </tr>
</table>  



<jsp:include page="jspsamplefooter.jsp"></jsp:include>
  
</body>
  
</dsp:page>
</html>

