<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
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
		<div id="wrap" class="clear-block">
			<div id="header"><jsp:include page="header.jsp"/></div>
			<h3>log in</h3>
            <div class="login">
                <div class="text">Please enter your email and password below</div>
                <table>
                    <tfoot>
                        <tr>
                            <td>&nbsp;</td>
                            <td><a href="#" class="btn"><span>log in</span></a></td>
                        </tr>
                    </tfoot>
                    <tbody>
                        <tr>
                            <td width="150">Email:</td>
                            <td><input type="text" name="" id="" class="textInput" /></td>
                        </tr>
                        <tr>
                            <td>Password:</td>
                            <td><input type="text" name="" id="" class="textInput" /></td>
                        </tr>
                    </tbody>
                </table>
            </div>
			<div id="footer"><jsp:include page="aboutUs.jsp"/></div>
		</div>
	</body>
</html>