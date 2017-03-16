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
                    <h3 class="green">Lee Men's Fit Stretch Jeans</h3>
                    <div class="prodDetail">
                        <div class="img"><img src="images/prods/prod_400_389_01.jpg" alt="" /></div>
                        
                        <div class="textInfo">
                            product detail information, product detail information, product detail information, product detail information, product detail information, product detail information, product detail information, product detail information, product detail information, product detail information, product detail information, product detail information, product detail information, product detail information, <br /><br />product detail information, product detail information, product detail information, product detail information, product detail information, product detail information, product detail information, product detail information, product detail information, product detail information, product detail information, product detail information, product detail information, product detail information, product detail information, product detail information, product detail information, product detail information, product detail information, product detail information, product detail information, product detail information
                        </div>
                        
                        <div class="availability"><span class="grey">Availability:</span>In Stock / Back orderable / Out of Stock</div>
                      
                        <div class="info">
                            <h2>Lee Men's Fit Stretch Jeans</h2>
                            <p class="price">
                                <span class="blod">Price:</span>
                                <span>$199.00</span>
                            </p>
                            <p class="price">
                                <span class="blod">List Price:</span>
                                <span class="was" style="margin-right: 10px;">$100.00</span>
                                <span class="blod">Discount Price:</span>
                                <span class="now">$85.00</span>
                            </p>
                            <p class="qty">
                                <span class="blod">Qty:</span>
                                <input type="text" name="" id="" class="textInput" />
                            </p>
                            <p class="btnBox">
                                <a href="#" class="btn"><span>Add to Cart Button</span></a>
                            </p>
                        </div>
                      
                    </div>
				</div>
				
			</div>
			<div id="footer"><jsp:include page="footer.jsp"/></div>
		</div>
	</body>
</html>