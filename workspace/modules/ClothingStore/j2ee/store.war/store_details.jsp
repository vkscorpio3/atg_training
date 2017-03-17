<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib uri="http://www.atg.com/taglibs/daf/dspjspTaglib1_0"
	prefix="dsp"%>

<html xmlns="http://www.w3.org/1999/xhtml">
<body>
	<div>
		<p>Details of the Store</p>
		<dsp:droplet name="clothing/store/StoreLookup">
			<dsp:param name="id" param="storeID" />
			<dsp:oparam name="output">
			Store Name:	<dsp:valueof param="element.storeName" />
				</br>
			Store Number: <dsp:valueof param="element.storeNumber" />
				</br>
			Store Size: <dsp:valueof param="element.storeSize" />
				</br>
			</dsp:oparam>
		</dsp:droplet>
	</div>
</body>
</html>