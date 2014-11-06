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
* Created lvzj 2014-07-23 企业荣誉详情 页面
*/
%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="Keywords" content="<c:out value="${TDKMap.keyWords}" escapeXml="true" />" />
	<meta name="Description" content="<c:out value="${TDKMap.description}" escapeXml="true" />" />	
	<title><c:out value="${TDKMap.title}" escapeXml="true" /></title>
	<link rel="shortcut icon" href="<my:link domain="jcs.static" uri="/favicon.ico"/>" type="image/x-icon" />
  <link rel="icon" href="<my:link domain="jcs.static" uri="/favicon.ico"/>" type="image/x-icon" />
	<link rel="stylesheet" href="<my:link domain="jcs.static" uri="/res1.5/css/common/common.css"/>">
	<link rel="stylesheet" href="<my:link domain="jcs.static" uri="/res1.5/css/common/layout.css"/>">
	<link rel="stylesheet" href="<my:link domain="jcs.static" uri="/res1.5/plugins/backTools/backTools.css"/>">
	<link rel="stylesheet" href="<my:link domain="jcs.static" uri="/res1.5/css/supplier_zone/flag_layout.css"/>">
	<link rel="stylesheet" href="<my:link domain="jcs.static" uri="/res1.5/css/supplier_zone/flagship.css"/>">
	<link rel="stylesheet" href="<my:link domain="jcs.static" uri="/res1.5/css/module/forms.css"/>">
	
	<script src="<my:link domain="jcs.static" uri="/res1.5/js/common/jquery-1.10.2.min.js"/>"></script>
</head>
<body>
	<jsp:include page="${path}/commontop">
		<jsp:param name="menuId" value="2" />
		<jsp:param name="supplierId" value="${supplierId}" />
	</jsp:include>
	<div id="s_content" class="wrap clear">
		<div class="content">
			<!-- 详情内容 begin -->
			<div class="detail_page">
				<h3><c:out value="${data.product.productName}" escapeXml="true"/></h3>

				<!-- 图片展示 begin -->
				<div class="slide_box">
					<div id="slider" class="flexslider">
					  <ul class="slides">
					  
					    <c:choose>
							<c:when test="${fn:length(fileIds)>0}">
					    		<c:forEach items="${fileIds}" var="fileId" >
					    			<li data-thumb="<my:link domain='img.static' uri='/netdiskimg/supplier-13/${fileId}.120x120.jpg'/>">
					     		 		<img src="<my:link domain='img.static' uri='/netdiskimg/supplier-13/${fileId}.600x400.jpg'/>" alt="">
					    			</li>
					    		</c:forEach>
							</c:when>
							<c:otherwise>
								<li data-thumb="<my:link domain='jcs.static' uri='/res1.5/img/supplier_zone/global/default_product.png'/>">
					     		 	<img src="<my:link domain='jcs.static' uri='/res1.5/img/supplier_zone/global/default_product.png'/>" alt="">
					    		</li>
							</c:otherwise>
						</c:choose>
					    
					    
					  </ul>
					</div>
				</div>
				<!-- 图片展示 end -->

				<ul class="compinfo_detail">
					<li class="f_items">
						<div class="label_tit">
							<label class="tit_textabbr">产品名称：</label>
						</div>
						<div class="fields_rit">
						<c:out value="${data.product.productName}" escapeXml="true"/>
						</div>
					</li>
					<li class="f_items">
						<div class="label_tit">
							<label class="tit_textabbr">型号：</label>
						</div>
						<div class="fields_rit"><c:out value="${data.product.productModel}" escapeXml="true"/></div>
					</li>
					<li class="f_items">
						<div class="label_tit">
							<label class="tit_textabbr">品牌：</label>
						</div>
						<div class="fields_rit"><c:out value="${data.product.trademark}" escapeXml="true"/></div>
					</li>
					<li class="f_items">
						<div class="label_tit">
							<label class="tit_textabbr">档次：</label>
						</div>
						<div class="fields_rit"><c:out value="${data.product.level}" escapeXml="true"/></div>
					</li>
					<li class="f_items">
						<div class="label_tit">
							<label class="tit_textabbr">产地：</label>
						</div>
						<div class="fields_rit"><c:out value="${data.product.productionPlace}" escapeXml="true"/></div>
					</li>
					<li class="f_items">
						<div class="label_tit">
							<label class="tit_textabbr">描述：</label>
						</div>
						<div class="fields_rit">${data.product.remark}</div>
					</li>
				</ul>
			</div>
			<!-- 详情内容 end -->
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

	
	<script>
	$(function() {
		$('.flexslider').flexslider({
	    animation: "slide",
	    controlNav: "thumbnails"
	  });
	});
	</script>
</body>
</html>