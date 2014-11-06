<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://mysoft.com/taglib/domain" prefix="my" %>  
<%@ taglib uri="http://mysoft.com/taglib/includeHtml" prefix="html" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!-- 禁用缓存 -->
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache">
<meta http-equiv="Expires" content="0">
<script charset="utf-8" src="http://wpa.b.qq.com/cgi/wpa.php"></script>
<html:include page="site_nav"/>
<script type="text/javascript">
	function initSiteNav(){
		$(".site_home").show();
	}
	(function($){
		initSiteNav();
	})($);
</script>
<div id="s_header">
	<div class="wrap clear">
		<div class="s_company">
			<h1><c:out value="${card.companyName}" escapeXml="true" /></h1>
			<div class="s_ctrlbar">
				<c:choose>
					<c:when test="${isLogon==false}">
						<a href="javascript:void(0)" class="btn_common btn_blue btn_size_30 addConcern"><i>+</i><span>关注</span></a>
					</c:when>
					<c:when test="${canConcern == true}">
						<a href="javascript:void(0)" class="btn_common btn_blue btn_size_30 addConcern"><i>+</i><span>关注</span></a>
					</c:when>
				</c:choose>
			</div>
		</div>
		<c:choose>
			<c:when test="${shopStand != null && shopStand != ''}">
				<img class="s_banner" src="<my:link domain="img.static" uri="/netdiskimg/supplier-14/${shopStand}.1000x200.jpg"/>" width="1000" height="200" alt="">
			</c:when>
			<c:otherwise><img class="s_banner" src="<my:link domain="jcs.static" uri="/res1.5/img/supplier_zone/page/banner.jpg"/>" width="1000" height="200" alt=""></c:otherwise>
		</c:choose>
		
		<div id="s_nav">
			<ul>
				<li <c:if test="${param.menuId == 1}">class="active"</c:if>><a href="/">首页</a></li>
				<li <c:if test="${param.menuId == 2}">class="active"</c:if>><a href="/product">产品展示</a></li>
				<li <c:if test="${param.menuId == 3}">class="active"</c:if>><a href="/successcase">成功案例</a></li>
				<li <c:if test="${param.menuId == 4}">class="active"</c:if>><a href="/award">企业荣誉</a></li>
				<li <c:if test="${param.menuId == 5}">class="active"</c:if>><a href="/about">关于我们</a></li>
			</ul>
		</div>
	</div>
</div>
<script src="<my:link domain="jcs.static" uri="/res1.5/js/common/dialog.js"/>"></script>
	<script>
			document.write('<link href="<my:link domain="jcs.static" uri="/res1.5/plugins/guide/guide.css"/>" rel="stylesheet"/>');
			document.write('<script type="text/javascript" src="<my:link domain="jcs.static" uri="/res1.5/plugins/guide/jquery.guide.js"/>"><\/script>');
	</script>
<script>
(function($){
	// 登录url
	var jumpUrl = '<my:link domain="login" uri="/view/login.do"/>';
	
	// 取得cookie信息
	function getCookie(name){ 
		var arr,reg=new RegExp("(^| )"+name+"=([^;]*)(;|$)"); 
		if(arr=top.document.cookie.match(reg)) return unescape(arr[2]); 
		else return ""; 
	};
	
	// 关注操作
	$("a.addConcern").click(function() {
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
							// TODO 替换页面
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
			window.location = jumpUrl;
		}
	});
	
})(jQuery);
</script>