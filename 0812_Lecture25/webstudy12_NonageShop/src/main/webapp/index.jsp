<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>
	<div class="clear"></div>

	<div id="main_img">
		<img alt="" src="images/main_img.jpg">
	</div>
	
	<div id="front">
		<h2>New Items</h2>
		<div id="bestProduct">
			<c:forEach var="productVO" items="${newProductList }">
				<div id="item">
					<a href="NonageServlet?command=product_detail&pseq=${productVO.pseq }">
						<img src="product_images/${productVO.image }">
						<h3>${productVO.name }</h3>
						<p>${productVO.price2 }</p>
					</a>
				</div>
			</c:forEach>
		</div>
	
		<div class="clear"></div>
	
		<h2>Best Items</h2>
		<div id="bestProduct">
			<c:forEach var="productVO" items="${bestProductList }">
				<div id="item">
					<a href="NonageServlet?command=product_detail&pseq=${productVO.pseq }">
						<img src="product_images/${productVO.image }">
						<h3>${productVO.name }</h3>
						<p>${productVO.price2 }</p>
					</a>
				</div>
			</c:forEach>
		</div>
	
		<div class="clear"></div>
	
	</div>


<%@ include file="../footer.jsp"%>