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
  <dsp:setvalue param="year" value="1901"/> 
  <p> after dsp:setvalue</p>
  
<p>     
  <dsp:a href="jspsample.jsp">Go to the jsp pages sample containing JSTL tags
     <dsp:param name="year" param="year"/>
  </dsp:a> 
</p>

<%
    for (java.util.Enumeration e = request.getAttributeNames(); e.hasMoreElements();) {
       String name = (String)e.nextElement();
       
       out.write("<p>");
       out.write(name);
         
       out.write(" ---> ");
       out.write("[ ");
       out.write(request.getAttribute(name).getClass().toString());
       out.write("] ");
       out.write(request.getAttribute(name).toString());
       out.write("</p>"); 
 
 /*
         out.write("<p>");
         out.write("Request Scope value -->");
         if (pageContext.getAttribute(o.toString(), pageContext.REQUEST_SCOPE) != null)         
        	 out.write((String)pageContext.getAttribute(o.toString(),pageContext.REQUEST_SCOPE).toString());
         out.write("</p>"); 
         
         out.write("<p>");
         out.write("Session Scope value -->");
         if (pageContext.getAttribute(o.toString(), pageContext.SESSION_SCOPE) != null)                  
         	out.write((String)pageContext.getAttribute(o.toString(),pageContext.SESSION_SCOPE).toString());
         out.write("</p>"); 

         out.write("<p>");
         out.write("Application Scope value -->");
         if (pageContext.getAttribute(o.toString(), pageContext.APPLICATION_SCOPE) != null)                  
         	out.write((String)pageContext.getAttribute(o.toString(),pageContext.APPLICATION_SCOPE).toString());
         out.write("</p>");                  
*/    

       out.write("</p>");       
       
    }
   
   
    out.write("<h2>Request Attribute SPD--/atg/repository/RequestPropertyDescriptorData</h2>"); 
     
    atg.repository.ScopedPropertyDescriptorData data = (atg.repository.ScopedPropertyDescriptorData) (request.getAttribute("SPD--/atg/repository/RequestPropertyDescriptorData"));
    out.write("<p> data ==&gt; ");
    out.write(data.toString());
    out.write("</p>");
    
    for (java.util.Enumeration e = ((java.util.concurrent.ConcurrentHashMap)(data.getPropertyValues())).elements(); e.hasMoreElements();) {
       String name = e.nextElement().toString();
       
       out.write("<p>");
       out.write(name);
         
       out.write(" ***> ");  
       
       
       out.write("</p>");  
    }
    
    
    
    out.write("<h2>Request Attribute atg.nucleus.WindowScopeManager.storage</h2>"); 
     
    atg.nucleus.WindowScopeContextStorage windowStorage = (atg.nucleus.WindowScopeContextStorage) (request.getAttribute("atg.nucleus.WindowScopeManager.storage"));
    out.write("<p> windowStorage ==&gt; ");
    out.write(windowStorage.toString());
    out.write("</p>");
    
    for (java.util.Enumeration e = windowStorage.listElements(); e.hasMoreElements();) {
       String name = e.nextElement().toString();
       
       out.write("<p>");
       out.write(name);
         
       out.write(" ^^^> ");  
       
       
       out.write("</p>");  
    }
            
    
    
    out.write("<h2>Request Attribute atg.servlet.pipeline.URLArguments</h2>"); 
     
    atg.core.util.ArrayDictionary pipelineData = (atg.core.util.ArrayDictionary) (request.getAttribute("atg.servlet.pipeline.URLArguments"));
    out.write("<p> pipelineData ==&gt; ");
    out.write(pipelineData.toString());
    out.write("</p>");    
    
%>

    <p>
   atg.servlet.request type is: <%= request.getAttribute("atg.servlet.request").getClass().toString() %>
    </p>
    
</dsp:page>
</html>

