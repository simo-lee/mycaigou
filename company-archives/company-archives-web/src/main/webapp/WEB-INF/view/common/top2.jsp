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
<!-- logo -->
<div id="s_header">
  <div class="wrap clear">
    <h1 class="logo"><a href="<my:link domain="mainpage" uri="/"/>" title="明源云采购"><img src="<my:link domain="jcs.static" uri="/res1.5/img/common/layout/logo.png"/>" alt="明源云采购"></a></h1>
    <h2 class="title">企业档案</h2>
  </div>
</div>
<script src="<my:link domain="jcs.static" uri="/res1.5/js/common/dialog.js"/>"></script>
<script>
document.write('<link href="<my:link domain="jcs.static" uri="/res1.5/plugins/guide/guide.css"/>" rel="stylesheet"/>');
document.write('<script type="text/javascript" src="<my:link domain="jcs.static" uri="/res1.5/plugins/guide/jquery.guide.js"/>"><\/script>');
</script>
