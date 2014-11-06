<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://mysoft.com/taglib/domain" prefix="my"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<% request.setAttribute("path", request.getContextPath());%>
<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<title><c:out value="${data.mainData.companyName}" escapeXml="true" />企业档案|企业百科 - <c:out value="${data.mainData.shortName}" escapeXml="true" />企业网站</title>
	<meta name="Keywords" content="<c:out value="${data.mainData.companyName}" escapeXml="true"/>官网,<c:out value="${data.mainData.shortName}" escapeXml="true"/>企业网站,<c:out value="${data.mainData.companyName}" escapeXml="true"/>企业档案,<c:out value="${data.mainData.companyName}" escapeXml="true"/>企业百科" />
	<meta name="Description" content="<c:out value="${data.mainData.companyName}" escapeXml="true"/>专业经营<c:out value="${data.businessScope}" escapeXml="true"/>，<c:out value="${data.mainData.shortName}" escapeXml="true" />面向<c:out value="${data.regionNameStr}" escapeXml="true" />等地提供<c:out value="${data.serviceCategoryNames}" escapeXml="true" />等产品和服务。" />
	<link rel="shortcut icon" href="<my:link domain="jcs.static" uri="/favicon.ico"/>" type="image/x-icon" />
	<link rel="icon" href="<my:link domain="jcs.static" uri="/favicon.ico"/>" type="image/x-icon" />
	<link rel="stylesheet" href="<my:link domain="jcs.static" uri="/res1.5/css/common/common.css"/>">
	<link rel="stylesheet" href="<my:link domain="jcs.static" uri="/res1.5/css/common/layout.css"/>">
	<link rel="stylesheet" href="<my:link domain="jcs.static" uri="/res1.5/css/module/tables.css"/>">
	<link rel="stylesheet" href="<my:link domain="jcs.static" uri="/res1.5/plugins/backTools/backTools.css"/>">
	<link rel="stylesheet" href="<my:link domain="jcs.static" uri="/res1.5/plugins/flexslider/css/jquery.gallery.css"/>">
	<link rel="stylesheet" href="<my:link domain="jcs.static" uri="/res1.5/css/web/page/company_archives.css"/>">
	<script src="<my:link domain="jcs.static" uri="/res1.5/js/common/jquery-1.10.2.min.js"/>"></script>
</head>
<body>
<!-- 页头 -->
<jsp:include page="../common/top2.jsp" flush="true"/>
<div id="main" class="wrap clear">
    <div class="content">
      <!-- 企业简介 -->
      <div class="company_intro">
        <h2 class="tit"><c:out value="${data.mainData.companyName}" escapeXml="true"/>	
        <c:choose>
					<c:when test="${!isLogon}">
						<a href="javascript:void(0);" class="follow btn_common btn_white btn_silvery btn_size_24" id="addConcern"><i>+</i>关注</a>
					</c:when>
					<c:when test="${isDev}">
						<a href="javascript:void(0);" class="follow btn_common btn_white btn_silvery btn_size_24" id="addConcern"><i>+</i>关注</a>
					</c:when>
				</c:choose>
        </h2>
        <div class="desc" id="companyDesc">
        	<p>
        	<c:choose>
					<c:when test="${not empty data.companyLogo}">
					<img class="campinfo_logo" src="<my:link uri='/company/${data.supplierId}.250x100.jpg' domain="img.static"/>?companyLogo=${data.companyLogo}" alt="logo">
					</c:when>
					</c:choose>
        	<c:out value="${aboutInfo}" escapeXml="false"/></p>
        	<div class="view_more" style="display:none;"><a href="javascript:void(0);" >展开</a></div>
        </div>
        <ul class="company_meta clear">
          <li class="half">
            <span class="label">公司名称</span>
            <p>
            	<c:out value="${data.mainData.companyName}" escapeXml="true" />
            	<c:if test="${not empty data.iCCertificationUrl and not empty data.iCCFileId }">
            	<span class="cert_gongshang">
            		<a class="icon" href="javascript:void(0)" id="icCertBtn"></a>
            		<a class="picture" title="点击查看原图" data-title='<c:out value="${data.mainData.companyName}" escapeXml="true"/>' 
            				href='<my:link domain="img.static" uri="/netdiskimg/supplier-17/${data.iCCFileId}.1000x800.jpg"/>'>
            			<img src="<my:link domain="img.static" uri="/netdiskimg/supplier-17/${data.iCCFileId}.600x400.jpg"/>">
            		</a>
            	</span>
            	</c:if>
            </p>
            <input type="hidden" id="supplierId" value="${supplierId}"/>
            <input type="hidden" id="iCCertificationUrl" value="${data.iCCertificationUrl}"/>
          </li>
          <li class="half">
            <span class="label">公司简称</span>
            <p><c:out value="${data.mainData.shortName}" escapeXml="true" /></p>
          </li>
          <li class="half">
            <span class="label">公司类型</span>
            <p><c:out value="${data.companyTypeName}" escapeXml="true" /></p>
          </li>
          <li class="half">
            <span class="label">法人姓名</span>
            <p><c:out value="${data.mainData.legalName}" escapeXml="true" /></p>
          </li>
          <li class="half">
            <span class="label">成立年份</span>
            <p><c:out value="${data.mainData.establishYear}" escapeXml="true" /></p>
          </li>
          <li class="half">
            <span class="label">营业执照号</span>
            <p><c:out value="${data.mainData.licenseCode}" escapeXml="true" /></p>
          </li>
          <li class="half">
            <span class="label">注册资本</span>
            <p>
            <c:choose>
            	<c:when test="${not empty data.mainData.regCapital and data.mainData.regCapital ne 0}"><c:out value="${data.mainData.regCapital}" escapeXml="true" />万<c:out value="${currentUnit}" escapeXml="true"/></c:when>
            	<c:otherwise>无需验资</c:otherwise>
            </c:choose>
            </p>
          </li>
          <li class="half">
            <span class="label">供应商类型</span>
            <p><c:out value="${data.supplierTypeName}" escapeXml="true" /></p>
          </li>
          <li>
            <span class="label">服务区域</span>
            <p><c:out value="${data.regionNameStr}" escapeXml="true" /></p>
          </li>
          <li>
            <span class="label">业务范围</span>
            <p><c:out value="${data.businessScope}" escapeXml="true" /></p>
          </li>
          <li>
            <span class="label">服务/产品</span>
            <p><c:out value="${data.serviceCategoryNames}" escapeXml="true" /></p>
          </li>
        </ul>
      </div>
      <!-- 目录 -->
      <c:if test="${not empty itemMap}">
      <div class="catalog_wrap">
        <div class="catalog">
          <div class="catalog_inner clear">
            <div class="catalog_title">
              <span>目录</span>
            </div>
            <ul class="clear">
             	<c:forEach items="${itemMap}" var="item" varStatus="itemSt">
             	<c:if test="${itemSt.index % 2 == 0}">
             	<li>
             	</c:if>
             	<a href="#cata${itemSt.count}">${itemSt.count} ${item.key}</a>
             	<c:if test="${itemSt.index % 2 == 1}">
             	</li>
             	</c:if>
             	</c:forEach>
            </ul>
          </div>
        </div>
      </div>
			</c:if>

			<c:forEach items="${itemMap}" var="item2" varStatus="itemSt2">
      <!-- 1 公司证照 -->
      <c:if test="${item2.key eq '公司证照' and not empty item2.value }">
      <div class="box">
        <div class="hd clear">
          <span class="sn" id="cata${itemSt2.count}">${itemSt2.count}</span>
          <h4>公司证照</h4>
        </div>
        <div class="bd">
          <div class="company_license imglist">
            <ul class="clear">
              <c:forEach items="${item2.value}" var="license">
							<c:set var="title" value=""/>
							<c:choose>
								<c:when test="${license.fileGroup.value == 6}"><c:set var="title" value="营业执照"/></c:when>
								<c:when test="${license.fileGroup.value == 7}"><c:set var="title" value="税务登记证"/></c:when>
								<c:when test="${license.fileGroup.value == 9}"><c:set var="title" value="组织机构代码证"/></c:when>
								<c:when test="${license.fileGroup.value == 1}"><c:set var="title" value="服务资质证书"/></c:when>
							</c:choose>
							<li>
							<a href="<my:link domain="img.static" uri="/netdiskimg/supplier-${license.fileGroup.value}/${license.fileId}.1000x800.jpg"/>" data-thumb="<my:link domain="img.static" uri="/netdiskimg/supplier-${license.fileGroup.value}/${license.fileId}.240x170.jpg"/>" data-title="${title}">
								<img src="<my:link domain="img.static" uri="/netdiskimg/supplier-${license.fileGroup.value}/${license.fileId}.240x170.jpg"/>" alt="${title}">
							</a>
							</li>
						  </c:forEach>
            </ul>
          </div>
        </div>
      </div>
      </c:if>

      <!-- 2 服务资质 -->
      <c:if test="${item2.key eq '服务资质' and not empty item2.value }">
      <div class="box">
        <div class="hd clear">
          <span class="sn" id="cata${itemSt2.count}">${itemSt2.count}</span>
          <h4>服务资质</h4>
        </div>
        <div class="bd">
          <ul class="company_aptitude">
          	<c:forEach items="${item2.value}" var="ql" varStatus="st">
            <li>
              <a class="picture" href="<my:link domain="img.static" uri="/netdiskimg/supplier-1/${ql.documentList[0].fileId}.1000x800.jpg"/>" 
              		data-thumb="<my:link domain="img.static" uri="/netdiskimg/supplier-1/${ql.documentList[0].fileId}.240x170.jpg"/>" data-title="<c:out value="${ql.name}" escapeXml="true"/>">
                <img src="<my:link domain="img.static" uri="/netdiskimg/supplier-1/${ql.documentList[0].fileId}.240x170.jpg"/>" alt="<c:out value="${ql.name}" escapeXml="true"/>">
              </a>
              <div class="aptitude_info">
                <ul>
                  <li>
                    <span class="label">资质名称</span>
                    <p><c:out value="${ql.name}" escapeXml="true"/> </p>
                  </li>
                  <li>
                    <span class="label">资质等级</span>
                    <c:forEach items="${ql.qualifyCodeList}" var="qlcode">
                    <p><c:out value="${qlcode.qualifyNameCode}" escapeXml="true"/><c:out value="${qlcode.qualifyLevelCode}" escapeXml="true"/></p>
                    </c:forEach>
                  </li>
                </ul>
              </div>
            </li>
						</c:forEach>
          </ul>
        </div>
      </div>
      </c:if>

      <!-- 3 明星产品/服务 -->
			<c:if test="${item2.key eq '明星产品/服务' and not empty item2.value }">
      <div class="box">
        <div class="hd clear">
          <span class="sn" id="cata${itemSt2.count}">${itemSt2.count}</span>
          <h4>明星产品/服务</h4>
        </div>
        <div class="bd">
          <div class="company_product imglist">
            <ul class="clear">
            	<c:forEach items="${item2.value }" var="product">
              <li>
                <a href="javascript:void(0)" title="<c:out value="${product.productName}" escapeXml="true"/>" data-pid="<c:out value="${product.uid}" escapeXml="true"/>" 
                		data-uid='<c:out value="${product.createdBy}" escapeXml="true"/>' >
                  <c:choose>
											<c:when test="${empty product.defaultPhotoId}">
												<img src="<my:link domain='jcs.static' uri='/res1.5/img/supplier_zone/global/default_product.png'/>" alt="">
											</c:when>
											<c:otherwise>
												<img src="<my:link domain='img.static' uri='/netdiskimg/supplier-13/${product.defaultPhotoId}.240x170.jpg'/>" alt="">
											</c:otherwise>
										</c:choose>
                  <p><c:out value="${product.productName}" escapeXml="true"/></p>
                </a>
              </li>
            	</c:forEach>
            </ul>
          </div>
        </div>
      </div>
      </c:if>

      <!-- 4 成功案例 -->
      <c:if test="${item2.key eq '成功案例' and not empty item2.value }">
      <div class="box">
        <div class="hd clear">
          <span class="sn" id="cata${itemSt2.count}">${itemSt2.count}</span>
          <h4>成功案例</h4>
        </div>
        <div class="bd">
          <div class="success_case">
            <ul>
            	<c:forEach items="${item2.value}" var="project">
              <li>
                <a class="picture" href="javascript:void(0)" title='<c:out value="${project.projectName}" escapeXml="true"/>' data-proId='<c:out value="${project.id}" escapeXml="true"/>' 
                		data-uid='<c:out value="${project.createdBy}" escapeXml="true"/>'>
              	<c:choose>
              		<c:when test="${empty project.documentList}">
                	<img src='<my:link uri="/res1.5/img/supplier_zone/global/default_project.png" domain="jcs.static"/>' alt="">
              		</c:when>
              		<c:otherwise>
                	<img src="<my:link uri="/netdiskimg/supplier-2/${project.documentList[0].fileId}.240x170.jpg" domain="img.static"/>" alt="<c:out value="${project.projectName}" escapeXml="true"/>">
              		</c:otherwise>
              	</c:choose>
                </a>
                <div class="info">
                  <p class="tit">
                  	<a href="javascript:void(0);" title="<c:out value="${project.projectName}" escapeXml="true"/>" data-proId='<c:out value="${project.id}" escapeXml="true"/>' data-uid='<c:out value="${project.createdBy}" escapeXml="true"/>' >
                			<c:out value="${project.projectName}" escapeXml="true"/>
                		</a>
                	</p>
                  <p class="meta">
                    <span class="object">甲方：<c:out value="${project.projectCompany}" escapeXml="true"/></span>
                    <span class="address">地址：<c:out value="${project.projectProvinceName}" escapeXml="true"/> <c:if test="${project.projectProvinceName ne project.projectCityName}"><c:out value="${project.projectCityName}" escapeXml="true"/></c:if></span>
                  </p>
                  <p class="note"><c:out value="${project.projectRemark}" escapeXml="false"/></p>
                </div>
              </li>
            	</c:forEach>
            </ul>
          </div>
        </div>
      </div>
			</c:if>

      <!-- 5 企业品牌 -->
      <c:if test="${item2.key eq '企业品牌' and not empty item2.value }">
      <div class="box">
        <div class="hd clear">
          <span class="sn" id="cata${itemSt2.count}">${itemSt2.count}</span>
          <h4>企业品牌</h4>
        </div>
        <div class="bd">
          <div class="company_brand imglist">
            <ul class="clear">
              <c:forEach items="${item2.value}" var="brand">
							<c:if test="${not empty brand.documentList }">
							<li>
								<div class="section_imgview">
									<a href="<my:link domain="img.static" uri="/netdiskimg/supplier-3/${brand.documentList[0].fileId}.1000x800.jpg"/>" data-thumb="<my:link domain="img.static" uri="/netdiskimg/supplier-3/${brand.documentList[0].fileId}.240x170.jpg"/>" data-title="<c:out value="${brand.brand}" escapeXml="true"/>">
							 	  	<img src="<my:link domain="img.static" uri="/netdiskimg/supplier-3/${brand.documentList[0].fileId}.240x170.jpg"/>" alt="<c:out value="${brand.brand}" escapeXml="true" />">
									</a>
								</div>
								<p class="section_imgtle" title="<c:out value="${brand.brand}" escapeXml="true"/>"><c:out value="${brand.brand}" escapeXml="true"/></p>
							</li>
							</c:if>
						  </c:forEach>
            </ul>
          </div>
        </div>
      </div>
      </c:if>

      <!-- 6 企业荣誉 -->
      <c:if test="${item2.key eq '企业荣誉' and not empty item2.value }">
      <div class="box">
        <div class="hd clear">
          <span class="sn" id="cata${itemSt2.count}">${itemSt2.count}</span>
          <h4>企业荣誉</h4>
        </div>
        <div class="bd">
          <div class="company_honor imglist">
            <ul class="clear">
              <c:forEach items="${item2.value}" var="award">
							<c:choose>
								<c:when test="${not empty award.documentList}">
									<c:forEach items="${award.documentList}" var="document">
									<li>
										<div class="section_imgview">
										<a href="<my:link domain="img.static" uri="/netdiskimg/supplier-4/${document.fileId}.1000x800.jpg"/>" data-thumb="<my:link domain="img.static" uri="/netdiskimg/supplier-4/${document.fileId}.240x170.jpg"/>" data-title="<c:out value="${award.name}" escapeXml="true"/>">
											<img src="<my:link uri="/netdiskimg/supplier-4/${document.fileId}.240x170.jpg" domain="img.static"/>">
										</a>
										</div>
										<p class="section_imgtle" title="<c:out value="${award.name}" escapeXml="true"/>"><c:out value="${award.name}" escapeXml="true"/></p>
									</li>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<li>
										<div class="section_imgview">
										<a href="javascript:void(0);" data-title="<c:out value="${award.name}" escapeXml="true"/>">
											<img src="<my:link uri="/res1.5/img/supplier_zone/global/default_honor.png" domain="jcs.static"/>">
										</a>
										</div>
										<p class="section_imgtle" title="<c:out value="${award.name}" escapeXml="true"/>"><c:out value="${award.name}" escapeXml="true"/></p>
									</li>
								</c:otherwise>
							</c:choose>
						</c:forEach>
            </ul>
          </div>
        </div>
      </div>
			</c:if>

      <!-- 7 分支机构或工厂 -->
			<c:if test="${item2.key eq '分支机构或工厂' and not empty item2.value}">
      <div class="box">
        <div class="hd clear">
          <span class="sn" id="cata${itemSt2.count}">${itemSt2.count}</span>
          <h4>分支机构或工厂</h4>
        </div>
        <div class="bd">
          <div class="company_organization">
            <ul class="clear">
            	<c:forEach items="${item2.value}" var="institution">
              <li>
                <c:choose>
                	<c:when test="${isLogon}">
                <p class="name"><c:out value="${institution.name}" escapeXml="true"/></p>
                <p class="address"><c:out value="${institution.address}" escapeXml="true"/>&nbsp;&nbsp;<c:out value="${institution.telephone}" escapeXml="true"/></p>
                	</c:when>
                	<c:otherwise>
                <p class="name"><c:out value="${institution.name}" escapeXml="true"/></p>
                	</c:otherwise>	
                </c:choose>
              </li>
            	</c:forEach>
            </ul>
          </div>
        </div>
      </div>
      </c:if>

      <!-- 8 企业相册 -->
      <c:if test="${item2.key eq '企业相册' and not empty item2.value}">
      <div class="box">
        <div class="hd clear">
          <span class="sn" id="cata${itemSt2.count}">${itemSt2.count}</span>
          <h4>企业相册</h4>
        </div>
        <div class="bd">
          <div class="company_album imglist">
            <ul class="clear">
            	<c:forEach items="${item2.value}" var="album" >
              <li>
              	<div class="section_imgview">
                	<a href="<my:link uri="/netdiskimg/supplier-12/${album.fileId}.1000x800.jpg" domain="img.static" />" data-thumb="<my:link domain="img.static" uri="/netdiskimg/supplier-12/${album.fileId}.240x170.jpg"/>"  data-title="<c:out value="${album.fileName}" escapeXml="true"/>">
                  	<img src="<my:link uri="/netdiskimg/supplier-12/${album.fileId}.240x170.jpg" domain="img.static" />" />
                	</a>
              	</div>
                <p class="section_imgtle" title='<c:out value="${album.fileName}" escapeXml="true"/>'><c:out value="${album.fileName}" escapeXml="true"/></p>						
             	</li>		
            	</c:forEach>
            </ul>
          </div>
        </div>
      </div>
      </c:if>
      
      </c:forEach>
      
    </div>
    <!-- /.content -->
	<!-- 左侧信息 -->
	<jsp:include page="${path}/commonsidebar2">
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
<script type="text/javascript">
$(function() {
  // 固定目录
  var $catalog = $('.catalog');
  var top = $catalog.position().top + 20;
  $(window).scroll(function() {
    var scroll = $(this).scrollTop();
    if(scroll > top){
      $catalog.addClass('fixed');
    } else{
      $catalog.removeClass('fixed');
    }
  });
  
  // 滚动位置偏移78px
  $('.catalog').on('click', 'a', function(e) {
      e.preventDefault();
      var href = this.getAttribute("href");
      var $target = $(href);
      var top = $target.offset().top - $catalog.outerHeight();
      $('html,body').animate({"scrollTop": top}, 400, function () {
      });
  });

  // 公司证照，图片预览
  $(".company_license").on('click', 'li a', function (e) {
    e.preventDefault();
    $(this).gallery({
      group: ".company_license",
      selector: "li a",
      overlayClose: true
    });
  });

  // 服务资质，图片预览
  $("ul.company_aptitude").on('click', 'li a', function (e) {
    e.preventDefault();
    $(this).gallery({
      group: "ul.company_aptitude",
      selector: "li a",
      overlayClose: true
    });
  });

  // 企业品牌图片预览
  $(".company_brand").on('click', 'li a', function (e) {
    e.preventDefault();
    $(this).gallery({
      group: ".company_brand",
      selector: "li a",
      overlayClose: true
    });
  });

  // 企业荣誉图片预览
  $(".company_honor").on('click', 'li a', function (e) {
    e.preventDefault();
    $(this).gallery({
      group: ".company_honor",
      selector: "li a",
      overlayClose: true
    });
  });
  
  // 企业相册图片预览
  $(".company_album").on('click', 'li a', function (e) {
    e.preventDefault();
    $(this).gallery({
      group: ".company_album",
      selector: "li a",
      overlayClose: true
    });
  });
  
  $("div.company_product ul li a").bind("click", function() {
	  var pid = $(this).attr("data-pid");
	  var uid = $(this).attr("data-uid");
		var url = "/goProductDtl.do?productId=" + pid + "&userId=" + uid;
		window.open(url);
  });
  
  $("div.success_case ul li a").bind("click", function() {
	  var pid = $(this).attr("data-proId");
	  var uid = $(this).attr("data-uid");
		var url = "/goProjectDtl.do?projectId=" + pid + "&userId=" + uid;
		window.open(url);
  });
  
  $("div.company_organization ul li a ").bind("click", function() {
	  window.location = '<my:link domain="login" uri="/view/login.do"/>?redirectURL=' + encodeURIComponent(document.URL);
  });
  
	// 展开关闭公司介绍
	var $desc = $('#companyDesc');
	var $p = $desc.children('p');
	var h = $p.height();
	var autoH = $p.height('auto').height();
	$p.height(h);
	if (autoH > h) {
	  $desc.children('.view_more').show();
	} else{
	  $p.height('auto');
	}
	$desc.on('click', '.view_more a', function(event) {
	  event.preventDefault();
	  var $this = $(this);
	  if ($desc.hasClass('unfold')) {
	  	$desc.removeClass('unfold');
	    $p.animate({height: h}, 300);
	    $this.text('展开');
	  } else {
	    $desc.addClass('unfold');
	    $p.animate({height: autoH}, 300);
	    $this.text('收起');
	  }
	});
	
	// 取得cookie信息
	function getCookie(name){ 
		var arr, reg = new RegExp("(^| )" + name + "=([^;]*)(;|$)"); 
		if(arr = document.cookie.match(reg)) 
			return unescape(arr[2]); 
		else 
			return ""; 
	};
	
	// 关注操作
	$("a#addConcern").click(function() {
		var companyType = getCookie("companyType") + "";
		if(companyType == "1") {
			mysoft.alert("您当前为供应商,不能关注");
		} else if(companyType == "2"){
			$.get("/check_concern", {"time": new Date().getTime()}, function(data) {
				if(data.success) {
					// 关注操作
					$.post("/add_concern", {}, function(result) {
						if(result.success) {
							// 关注成功
							mysoft.alert("关注成功");
						} else {
							mysoft.alert(result.message);
						}
					});
				} else {
					if("empty_companyId" == data.message ){
						 $.guideDialog("由于会员认证正在审核中，该功能暂未开通，<br/>请耐心等候，建议先完善个人相关资料", {
					            isCancel: false, // 显示继续逛逛按钮
					            btns: {
					                text: "我知道了"
					            }
					        });    
							 return false;
					}else{
						mysoft.alert(data.message);
					}
				}
			});
		} else {
			// 已退出登录
			window.location = '<my:link domain="login" uri="/view/login.do"/>?redirectURL=' + encodeURIComponent(document.URL);
		}
	});
	
	$("a#icCertBtn").bind("click", function() {
		var iCCertificationUrl = $("#iCCertificationUrl").val();
		if (iCCertificationUrl) {
			window.open(iCCertificationUrl);
		}
	});
	
   // 工商截图查看
   $('.cert_gongshang .picture').on('click', function(event) {
     event.preventDefault();
     $(this).gallery({
       group: ".cert_gongshang",
       selector: ".picture",
       overlayClose: true
     });
   });
	
	//pv统计代码
	try {
		var pvUrl ='<my:link domain="portal" uri="/pv/stat.do?pageId=${supplierId}&pvType=supplier" />';
		$.getJSON(pvUrl +"&callback=?",function(data) {});
	} catch(errMsg) {}

});
</script>
</body>
</html>