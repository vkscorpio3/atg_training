<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
			<div id="main">
				<div class="J_tabs">
					<ul>
						<li class="J_tab_default"><a href="catgory.jsp">category one</a></li>
						<span class="cutline">|</span>
						<li><a href="#">category two</a></li>
						<span class="cutline">|</span>
						<li><a href="#">category three</a></li>
					</ul>
				</div>
				
				<div class="J_tab_panel">
                    <h3 class="green">jackets &amp; vests</h3>
                    <div class="prodlist">
                        <div class="box first">
                            <div class="img">
                                <a href="productDetail.jsp">
                                    <img src="images/prods/subCatg_172_167_01.jpg" alt="" />
                                </a>
                            </div>
                            <div class="info">
                                <p class="name"><a href="productDetail.jsp">Lee Men's Fit Stretch Jeans</a></p>
                            </div>
                            <div class="price">
                                <p>$199.99</p>
                            </div>
                        </div>
                        
                        <div class="box">
                            <div class="img">
                                <a href="#">
                                    <img src="images/prods/subCatg_172_167_02.jpg" alt="" />
                                </a>
                            </div>
                            <div class="info">
                                <p class="name"><a href="">Lee Men's Fit Stretch Jeans 2</a></p>
                            </div>
                            <div class="price">
                                <p>
                                    <span class="was">$249.99</span>
                                    <span class="now">$199.99</span>
                                </p>
                            </div>
                        </div>
                        
                    </div>
				</div>
				
			</div>
			<div id="footer"><jsp:include page="footer.jsp"/></div>
		</div>
	</body>
</html>