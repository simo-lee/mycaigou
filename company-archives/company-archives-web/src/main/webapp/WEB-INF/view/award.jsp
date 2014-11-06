<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://mysoft.com/taglib/domain" prefix="my" %>  
<%@ taglib uri="http://mysoft.com/taglib/includeHtml" prefix="html" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://mysoft.com/taglib/page" prefix="p"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
	String path = request.getContextPath();
	request.setAttribute("path", path);
%>
<%
/*
*
* Created zhangmin 2014-05-10 企业荣誉页面
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
	<link rel="stylesheet" href="<my:link domain="jcs.static" uri="/res1.5/css/module/tables.css"/>">
	<script src="<my:link domain="jcs.static" uri="/res1.5/js/common/jquery-1.10.2.min.js"/>"></script>
</head>
<body>
	<jsp:include page="${path}/commontop">
		<jsp:param name="menuId" value="4" />
		<jsp:param name="supplierId" value="${supplierId}" />
	</jsp:include>
	<div id="s_content" class="wrap clear con_home">
		<div class="content">
			<div class="case_cont table_blue">
				<div class="section_imglist">
					<ul>
					<c:choose>
						<c:when test="${not empty data }">
						<c:forEach items="${data}" var="award">
							<c:choose>
								<c:when test="${not empty award.documentList}">
									<c:forEach items="${award.documentList}" var="document">
									<li>
										<div class="section_imgview">
										<a target="_blank" data-title="<c:out value="${award.name}" escapeXml="true"/>" href="/award/detail-${award.id}.html">
											<img src="<my:link uri="/netdiskimg/supplier-4/${document.fileId}.150x100.jpg" domain="img.static"/>">
										</a>
										</div>
										<p class="section_imgtle" title="<c:out value="${award.name}" escapeXml="true"/>"><c:out value="${award.name}" escapeXml="true"/></p>
									</li>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<li>
										<div class="section_imgview">
										<a data-title="<c:out value="${award.name}" escapeXml="true"/>" href="/award/detail-${award.id}.html" target="_blank" >
											<img src="<my:link uri="/res1.5/img/supplier_zone/global/default_honor.png" domain="jcs.static"/>">
										</a>
										</div>
										<p class="section_imgtle" title="<c:out value="${award.name}" escapeXml="true"/>"><c:out value="${award.name}" escapeXml="true"/></p>
									</li>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						</c:when>
						<c:otherwise>
						 	<p style="text-align:center">资料完善中</p>
						</c:otherwise>
						</c:choose>
					</ul>
				</div>
				<div class="page_info">
					 
					 <p:html url="/award.do?${queryString}" pagesize="${page.pageSize}"  page="${page.page}"  allrows="${page.rowNum}" />
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

	<script>

	</script>
</body>
</html>