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
* Created zhangmin 2014-05-10 关于我们页面
* update lvzj 20140627 关于我们，分支机构，其他证照
*/
%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<title>关于我们 - <c:out value="${companyName}" escapeXml="true" /> - 明源云采购</title>
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
	<jsp:include page="${path}/commontop" >
		<jsp:param name="menuId" value="5" />
		<jsp:param name="supplierId" value="${supplierId}" />
	</jsp:include>
	<div id="s_content" class="wrap clear con_home">
		<div class="content">
			<div class="section_wrap">
				<h3>公司简介</h3>
				<div class="section_cont">
					
					<c:choose>
						<c:when test="${empty data.introduction.introduction}">
							 <p class="section_noresult">资料完善中</p>
						</c:when>
						<c:otherwise>
							<div class="about_desc">
								<p><c:out value="${data.introduction.introduction}" escapeXml="false"/></p>
							</div>
						</c:otherwise>
					</c:choose>
						
					<c:if test="${not empty data.introduction.documents}">
						<div class="flexslider carousel">
						<ul class="slides">
							<c:forEach items="${data.introduction.documents}" var="document">
								<li><a href="<my:link uri="/netdiskimg/supplier-12/${document.fileId}.1000x800.jpg" domain="img.static"/>"
								 class="table_link" target="_blank">
								<img src="<my:link uri="/netdiskimg/supplier-12/${document.fileId}.160x106.jpg" domain="img.static"/>">
								</a>
								</li>
							</c:forEach>
						</ul>
					</div>
					</c:if>
				</div>
			</div>
			<div class="section_wrap">
				<c:choose>
					<c:when test="${not empty institutionList}">
						<h3>分支机构或工厂</h3>
							<div class="table_info table_blue about_branches">
							<table class="none_tfoot">
								<colgroup>
									<col class="col1">
									<col class="col2">
									<col class="col3">
								</colgroup>
								<thead>
									<tr>
										<th><p class="col_txt">分支机构或工厂名称</p></th>
										<th><p class="col_txt">地址</p></th>
										<th><p class="col_txt">电话</p></th>
										
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${institutionList}" var="item">
									<tr>
										<td><p class="col_txt" title="<c:out value="${item.name}" escapeXml="true"/>"><c:out value="${item.name}" escapeXml="true"/></p></td>
										<td><p class="col_txt" title="<c:out value="${item.address}" escapeXml="true"/>"><c:out value="${item.address}" escapeXml="true"/></p></td>
										<td>
										<p class="col_txt" title="<c:if test="${isLogon==true}"><c:out value="${item.telephone}" escapeXml="true" /></c:if>">
											<c:choose>
											<c:when test="${isLogon==true}">
												<c:out value="${item.telephone}" escapeXml="true" />
											</c:when>
												<c:otherwise>******</c:otherwise>
											</c:choose>
										</p></td>
									</tr>
									</c:forEach>
								</tbody>
								<tfoot><tr><td colspan="6"></td></tr></tfoot>
							</table>
							</div>
						</c:when>
					</c:choose>
			</div>
			<div class="section_wrap">
				<c:choose>
					<c:when test="${not empty otherLicenseList }">
						<h3>其他证照</h3>
						<div class="section_cont">
								<div class="flexslider carousel">
								<ul class="slides">
								<c:forEach items="${otherLicenseList }" var="document">
									<li><a href="<my:link uri="/netdiskimg/supplier-8/${document.fileId}.1000x800.jpg" domain="img.static"/>"
									 class="table_link" target="_blank">
									<img  src="<my:link uri="/netdiskimg/supplier-8/${document.fileId}.160x106.jpg" domain="img.static"/>">
									</a>
									</li>
								</c:forEach>
								</ul>
								</div>
						</div>
					</c:when>
				</c:choose>	
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

	<script>
		$(window).load(function(){
			$("div.flexslider").flexslider({
				animation: "slide",
				animationLoop: false,
				slideshow: false,
				itemWidth: 160,
				itemMargin: 5,
				controlNav: false
			}).on('click', 'ul.slides a', function (e) {
				e.preventDefault();
				$(this).gallery({
					group: "ul.slides",
					selector: "a",
					overlayClose: true
				});
			});
		});
	</script>
</body>
</html>