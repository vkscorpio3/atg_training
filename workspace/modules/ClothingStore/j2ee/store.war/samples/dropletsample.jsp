<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="dsp" uri="http://www.atg.com/taglibs/daf/dspjspTaglib1_1" %>

<dsp:page>
<dsp:importbean bean="/atg/userprofiling/Profile" />
<dsp:importbean bean="/atg/dynamo/droplet/IsNull" />
<dsp:importbean bean="/atg/dynamo/droplet/IsEmpty" />
<dsp:importbean bean="/atg/dynamo/droplet/multisite/SiteIdForItem" />
<dsp:importbean bean="/atg/dynamo/droplet/multisite/SiteLinkDroplet" />
<dsp:importbean bean="/atg/multisite/Site" />
<jsp:useBean id="me" class="com.clothingStore.test.SampleBean" scope="session" />
<head>


<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Droplets are Cool!!!</title>
</head>

<body>

 
<h1>Using ATG Droplets</h1>

<h2>ForEach droplet example</h2>
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

<h2>Switch droplet example</h2>
<dsp:droplet name="/atg/dynamo/droplet/Switch">
  <dsp:param name="value" bean="Profile.transient"/>        
  <dsp:oparam name="false">
    <p>How are you today, <dsp:valueof bean="Profile.login"/></p>
  </dsp:oparam>
  <dsp:oparam name="true">
    <p>Who are you?</p>
  </dsp:oparam>  
</dsp:droplet>
  

<h2>IsEmpty droplet example</h2>

<dsp:droplet name="IsEmpty">
  <dsp:param bean="Profile.creditCards" name="value"/>
  <dsp:oparam name="true">
     <p>no credit cards provided in user profile</p>
  </dsp:oparam>
  <dsp:oparam name="false">

    <dsp:droplet name="/atg/dynamo/droplet/ForEach">
      <dsp:param name="array" bean="Profile.creditCards" />

      <dsp:oparam name="outputStart">
        <table border="1">
          <tr>
            <th>Credit card nickname</th>      
            <th>Credit card type</th>
            <th>Credit card number</th>
           <th>Credit card Exp Date</th>        
          </tr>
      </dsp:oparam>

      <%-- display this output for each credit card: --%>
      <dsp:oparam name="output">
        <tr>
          <td><dsp:valueof param="key"/></td>
          <td><dsp:valueof param="element.creditCardType"/></td>
          <td><dsp:valueof param="element.creditCardNumber" converter="CreditCard" groupingsize="4" maskcharacter="*" numcharsunmasked="4"/></td>
          <td><dsp:valueof param="element.expirationMonth"/>/<dsp:valueof param="element.expirationDayOfMonth"/>/<dsp:valueof param="element.expirationYear"/>
        </tr>
      </dsp:oparam>
  
      <%-- Display this after looping thru all students in the array: --%>
      <dsp:oparam name="outputEnd">
          <tr>
            <td><strong>Total number of credit cards</strong></td>
            <td><dsp:valueof param="size"/></td>
          </tr>
        </table>
      </dsp:oparam>
    </dsp:droplet>

  </dsp:oparam>
</dsp:droplet>

<h2>IsNull droplet example</h2>

<dsp:droplet name="IsNull">
  <dsp:param bean="Profile.email" name="value"/>
  <dsp:oparam name="true">
     <p>no email address provided in user profile</p>
  </dsp:oparam>
  <dsp:oparam name="false">
    <p>email address is <dsp:valueof bean="Profile.email"/></p>
  </dsp:oparam>
</dsp:droplet>

<h2>RQLQueryForEach droplet example</h2>

<dsp:droplet name="/atg/dynamo/droplet/RQLQueryForEach">
  <dsp:param name="queryRQL" value="enabled=true"/>
  <dsp:param name="repository" value="/atg/multisite/SiteRepository"/>
  <dsp:param name="itemDescriptor" value="siteConfiguration"/>
  <dsp:oparam name="outputStart">
    <table border="1">
        <tr>
        <th>Site ID</th>      
        <th>Site Name</th>
        <th>Site Description</th>
        <th>Site Creation date</th> 
        <th>Site Default Catalog </th> 
      </tr>
  </dsp:oparam>
  <dsp:oparam name="output">
    <tr>
      <td><dsp:valueof param="element.id"/></td>
      <td><dsp:valueof param="element.name"/></td>
      <td><dsp:valueof param="element.description"/></td>
      <td><dsp:valueof param="element.creationTime" date="M/dd/yyyy" /></td>
      <td><dsp:valueof param="element.defaultCatalog.displayName"/></td>
    </tr>
  </dsp:oparam>
  <dsp:oparam name="outputEnd">
    </table>
  </dsp:oparam>
</dsp:droplet>

<h2>Current site is <dsp:valueof bean="/atg/multisite/Site.itemDisplayName"/><h2>

<h2>Check Site closure</h2>
<dsp:droplet name="/atg/dynamo/droplet/multisite/GetSiteDroplet">
  <dsp:param name="siteId" value="100001"/>
  <dsp:oparam name="output">
    <dsp:getvalueof var="closeDate" param="site.closingDate" vartype="java.util.Date">
      <dsp:droplet name="IsEmpty">
        <dsp:param name="value" param="site.closingDate"/>
        <dsp:oparam name="true">
          <p>Closing Date is empty. Site never closes</p>
        </dsp:oparam>
        <dsp:oparam name="false">
          <c:choose>
            <c:when test="${System.currentTimeMillis() > closeDate.getTimeInMillis()}" >
              Site <dsp:valueof param="site.name"/> is still active
            </c:when>
            <c:otherwise> 
              <p>Site <dsp:valueof param="site.name"/> is no longer active.
              Closing Date was <dsp:valueof param="site.closingDate" date="MMM d, yyyy"/></p>
            </c:otherwise>
          </c:choose>
        </dsp:oparam>
      </dsp:droplet>
    </dsp:getvalueof>
  </dsp:oparam>
</dsp:droplet>


<h2>Active Sites</h2>
<p><dsp:valueof bean="/atg/multisite/Site.id"/> </p>


<dsp:getvalueof var="currentSiteId" bean="/atg/multisite/Site.id" vartype="java.lang.String">

<dsp:droplet name="/atg/dynamo/droplet/ForEach">
  <dsp:param name="array" bean="/atg/multisite/SiteManager.activeSites"/>
  <dsp:oparam name="outputStart">
    |
  </dsp:oparam>
  <dsp:oparam name="output">
      <dsp:getvalueof var="nextSiteId" param="element.id" vartype="java.lang.String">
        <c:choose>
          <c:when test="${currentSiteId == nextSiteId}" >
            <dsp:valueof param="element.name"/>
          </c:when>
          <c:otherwise> 
            <dsp:droplet name="SiteLinkDroplet">
              <dsp:param name="siteId" value="${nextSiteId}"/>
              <dsp:oparam name="output">
                <dsp:getvalueof var="newUrl" param="url" vartype="java.lang.String">
                  <dsp:a href="${newUrl}>">
                    <dsp:valueof param="element.name"/>         
                  </dsp:a>
                </dsp:getvalueof>
              </dsp:oparam>
            </dsp:droplet>
          </c:otherwise>
        </c:choose>
      </dsp:getvalueof>
  </dsp:oparam>
  <dsp:oparam name="outputEnd">
   |
  </dsp:oparam>
</dsp:droplet>

</dsp:getvalueof>

  
</dsp:page>
</html>

