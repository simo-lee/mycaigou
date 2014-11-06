<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://mysoft.com/taglib/domain" prefix="my" %>  
<%@ taglib uri="http://mysoft.com/taglib/includeHtml" prefix="html" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://mysoft.com/taglib/page" prefix="p"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
	String path = request.getContextPath();
	request.setAttribute("path", path);
%>
<%
/*
*
* Created zhangmin 2014-05-13 产品展示
* updated zhangmin 2014-05-30 资料完善中新增边框
*/
%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" >
	<meta name="Keywords" content="<c:out value="${TDKMap.keyWords}" escapeXml="true" />" />
	<meta name="Description" content="<c:out value="${TDKMap.description}" escapeXml="true" />" />	
	<title><c:out value="${TDKMap.title}" escapeXml="true" /></title>
	<link rel="shortcut icon" href="<my:link domain="jcs.static" uri="/favicon.ico"/>" type="image/x-icon" />
	<link rel="icon" href="<my:link domain="jcs.static" uri="/favicon.ico"/>" type="image/x-icon" />
	<link rel="stylesheet" href="<my:link domain="jcs.static" uri="/res1.5/css/common/common.css"/>">
	<link rel="stylesheet" href="<my:link domain="jcs.static" uri="/res1.5/css/common/layout.css"/>">
	<link rel="stylesheet" href="<my:link domain="jcs.static" uri="/res1.5/plugins/flexslider/flexslider.css"/>">
	<link rel="stylesheet" href="<my:link domain="jcs.static" uri="/res1.5/plugins/flexslider/css/jquery.gallery.css"/>">
	<link rel="stylesheet" href="<my:link domain="jcs.static" uri="/res1.5/plugins/backTools/backTools.css"/>">
	<link rel="stylesheet" href="<my:link domain="jcs.static" uri="/res1.5/css/supplier_zone/flag_layout.css"/>">
	<link rel="stylesheet" href="<my:link domain="jcs.static" uri="/res1.5/css/supplier_zone/flagship.css"/>">
	<link rel="stylesheet" href="<my:link domain="jcs.static" uri="/res1.5/css/module/tables.css"/>">
	<script src="<my:link domain="jcs.static" uri="/res1.5/js/common/jquery-1.10.2.min.js"/>"></script>
</head>
<body>
	<jsp:include page="${path}/commontop">
		<jsp:param name="menuId" value="2" />
		<jsp:param name="supplierId" value="${supplierId}" />
	</jsp:include>
	<div id="s_content" class="wrap clear">
		<div class="content">
			<div class="table_blue">
				<ul class="product_list">
					<c:choose>
						<c:when test="${not empty data}">
							<c:forEach items="${data}" var="data">
								<li>
								<div class="product_images">
										<a href="/product/detail-${data.product.uid}.html" target="_blank">
										<c:choose>
											<c:when test="${fn:length(data.documents)>0}">
												<img src="<my:link domain='img.static' uri='/netdiskimg/supplier-13/${data.documents}.120x120.jpg'/>" alt="">
											</c:when>
											<c:otherwise>
												<img src="<my:link domain='jcs.static' uri='/res1.5/img/supplier_zone/global/default_product.png'/>" alt="">
											</c:otherwise>
										</c:choose>
										
										</a>
								</div>
								<div>
									<h3><a href="/product/detail-${data.product.uid}.html" target="_blank">
										<c:out value="${data.product.productName}" escapeXml="true"/></a></h3>
									<p title="<c:out value="${data.product.productModel}" escapeXml="true"/>">型号：<c:out value="${data.product.productModel}" escapeXml="true"/></p>
									<ul class="product_args">
										<li title="<c:out value="${data.product.trademark}" escapeXml="true"/>">品牌：<c:out value="${data.product.trademark}" escapeXml="true"/></li>
										<li title="<c:out value="${data.product.level}" escapeXml="true"/>">档次：<c:out value="${data.product.level}" escapeXml="true"/></li>
										<li title="<c:out value="${data.product.productionPlace}" escapeXml="true"/>">产地：<c:out value="${data.product.productionPlace}" escapeXml="true"/></li>
									</ul>
								</div>
							</li>
							</c:forEach>
						</c:when>
						<c:otherwise>
							<li style="padding: 25px 30px"><p style="text-align:center;width: 757px;">资料完善中</p></li>
						</c:otherwise>
					</c:choose>
					
				</ul>
				<div class="page_info">
					<p:html url="/product.do?${queryString}" pagesize="${pageVo.pageSize}"  page="${pageVo.page}"  allrows="${pageVo.rowNum}" />
				</div>
			</div>
			</div>
		<!-- 左侧信息 -->
		<jsp:include page="${path}/commonsidebar">
			<jsp:param name="supplierId" value="${supplierId}" />
		</jsp:include>
		<!-- 左侧信息结束 -->
		</div>
		
	<!-- 页尾 -->
	<jsp:include page="common/bottom.jsp"></jsp:include>
	<!-- 页尾结束 -->

	<script src="<my:link domain="jcs.static" uri="/res1.5/plugins/backTools/jquery.backTools.js"/>"></script>
	<script src="<my:link domain="jcs.static" uri="/res1.5/plugins/flexslider/jquery.flexslider.js"/>"></script>
	<script src="<my:link domain="jcs.static" uri="/res1.5/plugins/flexslider/jquery.gallery.js"/>"></script>
</body>
</html>