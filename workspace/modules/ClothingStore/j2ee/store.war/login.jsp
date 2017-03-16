<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.atg.com/taglibs/daf/dspjspTaglib1_0" prefix="dsp" %>
<dsp:importbean bean="/atg/userprofiling/ProfileFormHandler" />
<dsp:importbean bean="/atg/dynamo/droplet/ErrorMessageForEach"/>
<html xmlns="http://www.w3.org/1999/xhtml">
   <head>
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
      <link href="styles/layout.css" rel="stylesheet" type="text/css" media="all" />
      <link href="styles/base.css" rel="stylesheet" type="text/css" media="all" />
      <link href="styles/content.css" rel="stylesheet" type="text/css" media="all" />
      <link href="styles/jquery_ui.css" rel="stylesheet" type="text/css" media="all" />
      <title>demo</title>
   </head>
   <body>
      <dsp:page>
         <div id="wrap" class="clear-block">
         <div id="header">
            <jsp:include page="header.jsp"/>
         </div>
         <h3>log in</h3>
         <div class="login">
            <div class="text">Please enter your email and password below</div>
            <dsp:form id="loginForm" method="post" action="login.jsp" >
               <div>
                  <table>
                     <tbody>
                        <tr>
                           <td width="150">Email:</td>
                           <td>
                              <dsp:input bean="ProfileFormHandler.value.login" maxlength="30" size="25" type="text" required="true"  />
                           </td>
                        </tr>
                        <tr>
                           <td>Password:</td>
                           <td>
                              <dsp:input bean="ProfileFormHandler.value.password" maxlength="30" size="25" type="password" required="true"  />
                           </td>
                        </tr>
                        <tr>
                           <td>
                              <dsp:input bean="ProfileFormHandler.login" type="submit" value="LOG IN" />
                              <dsp:input bean="ProfileFormHandler.loginSuccessURL" type="hidden" value="index.jsp" />
                           </td>
                        </tr>
                        <tr>
                           <td colspan="2">
                              <ul>
                                 <dsp:droplet name="ErrorMessageForEach">
                                    <dsp:param bean="ProfileFormHandler.formExceptions" name="exceptions"/>
                                    <dsp:oparam name="output">
                                       <li>
                                          <dsp:valueof param="message"/>
                                       </li>
                                    </dsp:oparam>
                                 </dsp:droplet>
                              </ul>
                           </td>
                        </tr>
                     </tbody>
                  </table>
               </div>
            </dsp:form>
         </div>
      </dsp:page>
   </body>
</html>