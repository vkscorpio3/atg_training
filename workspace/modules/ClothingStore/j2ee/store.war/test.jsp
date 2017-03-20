<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page isELIgnored="false"%>
<%@ taglib prefix="dsp"
	uri="http://www.atg.com/taglibs/daf/dspjspTaglib1_1"%>
<dsp:page>
	<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Test JSP</title>
	</head>
	<body>
		<h1>Testing Droplet</h1>
		<dsp:droplet name="/anupam/droplets/MyDroplet">
			<dsp:param name="myinput" value="anupam" />
			<dsp:oparam name="output">
				<dsp:valueof param="myoutput" />
			</dsp:oparam>
		</dsp:droplet>
	</body>
</dsp:page>
</html>

