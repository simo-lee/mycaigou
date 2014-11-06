<%--
Update：2014-06-16 subh 在页面尾部增加了pv统计代码
Update：2014-08-20 liucz LOGO缓存处理
Update：2014-09-18 liucz 成功案例增加链接到详情页
--%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://mysoft.com/taglib/domain" prefix="my"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
	String path = request.getContextPath();
	request.setAttribute("path", path);
%>
<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<title><c:out value="${data.mainData.companyName}" escapeXml="true" /> - <c:out value="${data.mainData.shortName}" escapeXml="true" />企业网站 - 明源云采购</title>
	<meta name="Keywords" content="<c:out value="${data.mainData.companyName}" escapeXml="true" />,<c:out value="${data.mainData.shortName}" escapeXml="true" />企业网站" />
	<meta name="Description" content="<c:out value="${data.mainData.companyName}" escapeXml="true" />面向<c:out value="${data.regionNameStr}" escapeXml="true" />等地提供<c:out value="${data.serviceCategoryNames}" escapeXml="true" />等产品和服务。" />
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
	<!-- 页头 -->
	<jsp:include page="${path}/commontop">
		<jsp:param name="menuId" value="1" />
		<jsp:param name="supplierId" value="${supplierId}" />
	</jsp:include>
	<div id="s_content" class="wrap clear con_home">
		<div class="content">
			<c:if test="${aboutInfo != null && aboutInfo != ''}">
			<div class="section_wrap">
				<h3 id="btsAbout" class="show_nav" data-text="公司简介"><a href="/about" class="home_rightlink">更多&gt;&gt;</a>公司简介</h3>
				<div class="section_cont" style="height: 110px;overflow: hidden;">
					<p><c:out value="${aboutInfo}" escapeXml="false"/></p>
				</div>
			</div>
			</c:if>
			<div class="section_wrap">
				<h3 id="btsCompany" class="show_nav" data-text="公司基本信息">公司基本信息</h3>
				<div class="section_cont">
					<div class="campinfo_logo">
						<c:choose>
							<c:when test="${data.companyLogo != null && data.companyLogo != '' }">
							<img src="<my:link uri='/company/${data.supplierId}.250x100.jpg' domain="img.static"/>?companyLogo=${data.companyLogo}" alt="logo">
							</c:when>
						</c:choose>
					</div>
					<ul class="section_cont_sideview">
						<li>
							<label for="">公司名称：</label><span><c:out value="${data.mainData.companyName}" escapeXml="true" /></span>
						</li>
						<li>
							<label for="">成立年份：</label><span><c:out value="${data.mainData.establishYear}" escapeXml="true" /></span>
						</li>
						<li>
							<label for="">公司类型：</label><span><c:out value="${data.companyTypeName}" escapeXml="true" /></span>
						</li>
						<li>
							<label for="">法人姓名：</label><span><c:out value="${data.mainData.legalName}" escapeXml="true" /></span>
						</li>
						<li>
							<label for="">营业执照号：</label><span><c:out value="${data.mainData.licenseCode}" escapeXml="true" /></span>
						</li>	
						<li>
							<label for="">注册资本：</label><c:if test="${not empty data.mainData.regCapital and data.mainData.regCapital ne 0}"><span><c:out value="${data.mainData.regCapital}" escapeXml="true" />万<c:out value="${currentUnit}" escapeXml="true" /></span></c:if>
						</li>
						<li>
							<label for="">提供服务/产品：</label><span><c:out value="${data.serviceCategoryNames}" escapeXml="true" /></span>
						</li>
						<li>
							<label for="">服务区域：</label><span><c:out value="${data.regionNameStr}" escapeXml="true" /></span>
						</li>
						<li>
							<label for="">业务范围：</label><span><c:out value="${data.businessScope}" escapeXml="true" /></span>
						</li>
					</ul>
				</div>
			</div>
			<c:if test="${qualifyCodeList != null && fn:length(qualifyCodeList) > 0}">
			<div class="section_wrap">
				<h3 id="btsAptitude" class="show_nav" data-text="服务资质">服务资质</h3>
				<div class="section_cont clear">
					<ul class="home_aptitude_list">
						<c:forEach items="${qualifyCodeList}" var="item">
						<li>
							<span><c:out value="${item.qualifyNameCode}" escapeXml="true" /><c:out value="${item.qualifyLevelCode}" escapeXml="true" /></span>
						</li>
						</c:forEach>
					</ul>
					<ul class="home_aptitude_view">
						<c:forEach items="${qualifyFileList}" var="item">
						<li>
							<a href="<my:link domain="img.static" uri="/netdiskimg/supplier-${item.fileGroup.value}/${item.fileId}.1000x800.jpg"/>" data-thumb="<my:link domain="img.static" uri="/netdiskimg/supplier-${item.fileGroup.value}/${item.fileId}.160x106.jpg"/>">
								<img src="<my:link domain="img.static" uri="/netdiskimg/supplier-${item.fileGroup.value}/${item.fileId}.160x106.jpg"/>" alt="<c:out value="${item.fileName}" escapeXml="true" />">
							</a>
						</li>
						</c:forEach>
					</ul>
				</div>
			</div>
			</c:if>
			<c:if test="${projectList != null && fn:length(projectList) > 0}">
			<div class="section_wrap">
				<h3 id="btsCase" class="show_nav" data-text="成功案例">成功案例</h3>
				<div class="table_info table_blue">
					<table class="none_tfoot">
						<colgroup>
							<col class="col1" width="20%">
							<col class="col2" width="20%">
							<col class="col3" width="15%">
							<col class="col3" width="45%">
						</colgroup>
						<thead>
							<tr>
								<th><p class="col_txt">项目名称</p></th>
								<th><p class="col_txt">建设单位</p></th>
								<th><p class="col_txt">项目所在地</p></th>
								<th><p class="col_txt">备注</p></th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${projectList}" var="item">
							<tr>
								<td><p class="col_txt" title="<c:out value="${item.projectName}" escapeXml="true"/>"><a target="_blank" href="/successcase/detail-${item.id}.html"><c:out value="${item.projectName}" escapeXml="true"/></a></p></td>
								<td><p class="col_txt" title="<c:out value="${item.projectCompany}" escapeXml="true"/>"><c:out value="${item.projectCompany}" escapeXml="true"/></p></td>
								<td>
									<c:if test="${item.projectProvinceName eq item.projectCityName}">
										<p class="col_txt" title="<c:out value="${item.projectProvinceName}" escapeXml="true"/>">
											<c:out value="${item.projectProvinceName}" escapeXml="true"/>
										</p>
									</c:if>
									<c:if test="${item.projectProvinceName ne item.projectCityName}">
										<p class="col_txt" title="<c:out value="${item.projectProvinceName}" escapeXml="true"/><c:out value="${item.projectCityName}" escapeXml="true"/>">
											<c:out value="${item.projectProvinceName}" escapeXml="true"/><c:out value="${item.projectCityName}" escapeXml="true"/>
										</p>
									</c:if>
								</td>
								<td><p class="col_txt" title="<c:out value="${item.projectRemark}" escapeXml="true"/>"><c:out value="${item.projectRemark}" escapeXml="true"/></p></td>
							</tr>
							</c:forEach>
						</tbody>
						<tfoot><tr><td colspan="4"></td></tr></tfoot>
					</table>
				</div>
			</div>
			</c:if>
			<c:if test="${brandList != null && fn:length(brandList) > 0}">
			<div class="section_wrap">
				<h3 id="btsBand" class="show_nav" data-text="品牌信息">品牌信息</h3>
				<div class="section_cont">
					<div id="brandProve" class="flexslider carousel">
						<ul class="slides">
							<c:forEach items="${brandList}" var="item">
							<c:choose>
								<c:when test="${item.documentList != null && fn:length(item.documentList) > 0}">
									<li><a href="<my:link domain="img.static" uri="/netdiskimg/supplier-3/${item.documentList[0].fileId}.1000x800.jpg"/>"><img src="<my:link domain="img.static" uri="/netdiskimg/supplier-3/${item.documentList[0].fileId}.160x106.jpg"/>" alt="<c:out value="${item.brand}" escapeXml="true" />"></a></li>
								</c:when>
								<c:otherwise>
									
								</c:otherwise>
							</c:choose>
							</c:forEach>
						</ul>
					</div>
				</div>
			</div>
			</c:if>
			<div class="section_wrap">
				<h3 id="btsProve" class="show_nav" data-text="公司证照">公司证照</h3>
				<div class="section_cont">
					<div id="companyProve" class="flexslider carousel">
						<ul class="slides">
							<c:forEach items="${fileList}" var="item">
							<c:set var="title" value=""/>
							<c:choose>
								<c:when test="${item.fileGroup.value == 6}"><c:set var="title" value="营业执照"/></c:when>
								<c:when test="${item.fileGroup.value == 7}"><c:set var="title" value="税务登记证"/></c:when>
								<c:when test="${item.fileGroup.value == 9}"><c:set var="title" value="组织机构代码证"/></c:when>
								<c:when test="${item.fileGroup.value == 1}"><c:set var="title" value="服务资质证书"/></c:when>
							</c:choose>
							<li>
							<a href="<my:link domain="img.static" uri="/netdiskimg/supplier-${item.fileGroup.value}/${item.fileId}.1000x800.jpg"/>" data-thumb="<my:link domain="img.static" uri="/netdiskimg/supplier-${item.fileGroup.value}/${item.fileId}.160x106.jpg"/>" data-title="${title}">
							<img src="<my:link domain="img.static" uri="/netdiskimg/supplier-${item.fileGroup.value}/${item.fileId}.160x106.jpg"/>" alt="${title}"><p>${title}</p>
							</a>
							</li>
							</c:forEach>
						</ul>
					</div>
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
	<jsp:include page="../common/bottom.jsp"></jsp:include>
	<!-- 页尾结束 -->
	
	<script src="<my:link domain="jcs.static" uri="/res1.5/plugins/backTools/jquery.backTools.js"/>"></script>
	<script src="<my:link domain="jcs.static" uri="/res1.5/plugins/flexslider/jquery.flexslider.js"/>"></script>
	<script src="<my:link domain="jcs.static" uri="/res1.5/plugins/flexslider/jquery.gallery.js"/>"></script>
	<script>
	// 其他分类，选中
	$("ul.home_otherType").on('click', 'label', function (e) {
		if (e.target && e.target.tagName.toLowerCase() === "label") {
			var $ckb = $(this).find("input");
			if ($ckb && $ckb.length) {
				if ($ckb[0].checked) {
					$ckb[0].checked = false;
				} else {
					$ckb[0].checked = true;
				}
			}
		}
	});
	// 了解其他信息
	$("a.moreOtherType").on('click', function () {
		var $selectChecked = $(this).parent().find("li input:checked");
		//console.log($selectChecked);
	});

	// 服务资质，图片预览
	$("ul.home_aptitude_view").on('click', 'li a', function (e) {
		e.preventDefault();
		$(this).gallery({
			group: "ul.home_aptitude_view",
			selector: "li a",
			overlayClose: true
		});
	});

	$("#s_content").backTools({
		catalog: {
			list: function(){
				var ret = [];
				$('h3.show_nav').each(function() {
					var obj = {};
					obj.id = $(this).attr("id");
					obj.text = $(this).attr("data-text");
					ret.push(obj);
				});
				return ret;
			}
		} 
	});

	$(".flexslider").flexslider({
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
	
	// 取得cookie信息
	function getCookie(name){ 
		var arr,reg=new RegExp("(^| )"+name+"=([^;]*)(;|$)"); 
		if(arr=top.document.cookie.match(reg)) return unescape(arr[2]); 
		else return ""; 
	};
	
	// 发送消息
	$("#send_t_msg").click(function() {
		var companyType = getCookie("companyType") + "";
		if(companyType == "1") {
			mysoft.alert("您当前为供应商,不能执行该操作");
		} else if(companyType == "2"){
			// 关注操作
			$.post("/tmsg", {}, function(result) {
				if(result.success) {
					// 操作成功
					mysoft.alert("您想了解的近三年营业额已经通知到供应商，请关注供应商的消息回复");
				} else {
					mysoft.alert(result.message);
				}
			});
		} else {
			// 已退出登录
		}
	});
	
	$("#send_c_msg").click(function() {
		var $otherCat = $("input[name='otherCat']:checked");
		if($otherCat.length == 0) {
			mysoft.alert("请选择您想了解信息的分类");
			return false;
		} else {
			var catInfo = "";
			$otherCat.each(function() {
				catInfo += $(this).val() + ",";
			});
			catInfo = catInfo.substring(0, catInfo.length - 1);
			
			var companyType = getCookie("companyType") + "";
			if(companyType == "1") {
				mysoft.alert("您当前为供应商,不能执行该操作");
			} else if(companyType == "2"){
				// 关注操作
				$.post("/cmsg", {cat: catInfo}, function(result) {
					if(result.success) {
						// 操作成功
						mysoft.alert("您想了解的分类信息已经通知到供应商，请关注供应商的消息回复");
					} else {
						mysoft.alert(result.message);
					}
				});
			} else {
				// 已退出登录
			}
		}
	});
	
	// pv统计代码
	try {
		var pvUrl ='<my:link domain="portal" uri="/pv/stat.do?pageId=${supplierId}&pvType=supplier" />';
		$.getJSON(pvUrl +"&callback=?",function(data) {});
	} catch(errMsg) {
		// not do work
	}
	</script>
</body>
</html>