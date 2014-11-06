<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://mysoft.com/taglib/domain" prefix="my"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<div class="sidebar">
	<!-- 企业旗舰店 -->
	<c:if test="${cardList != null && fn:length(cardList) > 0}">
	<div class="aside person_box">
	  <div class="hd"><h3>企业旗舰店</h3></div>
	  <div class="bd">
	  	<c:forEach items="${cardList}" var="item" varStatus="stat">
	  	<div class="person">
	      <div class="info clear">
	        <c:set var="userId" value="${item.userId}" />
	        <a class="avatar" href="${item.personalShopUrl}" target="_blank">
		        <c:choose>
							<c:when test="${item.logo != null && item.logo != '' }">
								<img src="<my:link domain="img.static" uri="/netdiskimg/user-card-logo/${item.logo}.150x150.jpg" />" alt="<c:out value="${item.name}" escapeXml="true" />" />
							</c:when>
							<c:otherwise>
								<img src="<my:link domain="jcs.static" uri="/res1.5/img/common/head.png" />" alt="<c:out value="${item.name}" escapeXml="true" />" />
							</c:otherwise>
						</c:choose>
	        </a>
	        <a class="enter" href="${item.personalShopUrl}" target="_blank">进入店铺</a>
	        <p class="name">
	        	<a href="${item.personalShopUrl}" target="_blank"><c:out value="${item.name}" escapeXml="true" /></a>
	        	<c:if test="${item.auditStatus == '2'}">
	        	<a href="<my:link domain='my' uri='/card/viewIntroduction' />" class="auth_v"></a>
	        	</c:if>
	        </p>
	        <p class="post"><c:out value="${item.postion}" escapeXml="true" /></p>
	      </div>
	      <c:if test="${item.concentration != null && item.concentration != ''}">
	      <p class="concentration"><strong>我专注：</strong><c:out value="${item.concentration}" escapeXml="true" /></p>
	      </c:if>
	      <ul class="info_list">
	        <li>
	          <span class="label">手&nbsp;&nbsp;&nbsp;机</span>
	          <p>
	          	<c:choose>
	          		<c:when test="${isLogon==true}"><c:out value="${item.mobile}" escapeXml="true" /></c:when>
	          		<c:otherwise>${fn:substring(item.mobile, 0, 4)}*******</c:otherwise>
	          	</c:choose>
	          </p>
	        </li>
	        <li>
	          <span class="label">邮&nbsp;&nbsp;&nbsp;箱</span>
	          <p>
	          	<c:choose>
			         	<c:when test="${isLogon ==true}">
			         		<c:out value="${item.mail}" escapeXml="true" />
			         	</c:when>
			         	<c:otherwise>
			         		<c:set var="mailArr" value="${fn:split(item.mail, '@')}" />
									<c:choose>
										<c:when test="${mailArr != null && fn:length(mailArr) >=2}">
											${fn:substring(mailArr[0], 0, 4)}***@***.***
										</c:when>
										<c:otherwise>${fn:substring(item.mail, 0, 4)}***@***.***</c:otherwise>
									</c:choose>
			         	</c:otherwise>
			         </c:choose>
	          </p>
	        </li>
	        <li>
	          <span class="label">&nbsp;Q&nbsp;&nbsp;&nbsp;Q</span>
	          <p>
		          <c:choose>
		          	<c:when test="${isLogon ==true}"><c:out value="${item.qq}" escapeXml="true" /></c:when>
		          	<c:otherwise>******</c:otherwise>
		          </c:choose>
	          </p>
	        </li>
	      </ul>
	    </div>
	  	</c:forEach>
	  </div>
	</div>
	</c:if>
	
	<!-- 企业联系信息 -->
	<div class="aside contect_box">
	  <div class="hd"><h3>企业联系信息</h3></div>
	  <div class="bd">
	    <ul class="contect_info">
	      <li>
	        <span class="label">总&nbsp;&nbsp;&nbsp;机</span>
	        <p>
	        	<c:choose>
          		<c:when test="${isLogon==true}"><c:out value="${card.telephone}" escapeXml="true" /></c:when>
          		<c:otherwise>${fn:substring(card.telephone, 0, 4)}*******</c:otherwise>
          	</c:choose>
	        </p>
	      </li>
	      <li>
	        <span class="label">传&nbsp;&nbsp;&nbsp;真</span>
	        <p>
						<c:choose>
          		<c:when test="${isLogon==true}"><c:out value="${card.fax}" escapeXml="true" /></c:when>
          		<c:otherwise>${fn:substring(card.fax, 0, 4)}*******</c:otherwise>
          	</c:choose>
	        </p>
	      </li>
	      <li>
	        <span class="label">地&nbsp;&nbsp;&nbsp;址</span>
	        <p><c:out value="${card.provinceName}" escapeXml="true" /><c:if test="${card.provinceName!=card.cityName}"><c:out value="${card.cityName}" escapeXml="true" /></c:if><c:out value="${card.address}" escapeXml="true" /></p>
	      </li>
	      <li>
	        <span class="label">服务热线</span>
	        <p>
	        	<c:choose>
          		<c:when test="${isLogon==true}"><c:out value="${card.hotline}" escapeXml="true" /></c:when>
          		<c:otherwise>${fn:substring(card.hotline, 0, 4)}*******</c:otherwise>
          	</c:choose>
	        </p>
	      </li>
	      <li class="line"></li>
	      <li>
	        <span class="label">企业网站</span>
	        <p>
	        	<c:choose>
	        		<c:when test="${isLogon==true}">       	
		        	<c:if test="${card.website != null && card.website != ''}">
								<c:if test="${fn:startsWith(card.website, 'http')}">
									<a href="<c:out value="${card.website}" escapeXml="true" />" target="_blank">
										<c:out value="${card.website}" escapeXml="true" />
									</a>
								</c:if>
								<c:if test="${fn:startsWith(card.website, 'http') == false}">
									<a href="http://<c:out value="${card.website}" escapeXml="true" />" target="_blank">
										<c:out value="${card.website}" escapeXml="true" />
									</a>
								</c:if>
							</c:if>
							</c:when>
							<c:otherwise>******</c:otherwise>
						</c:choose>
	        </p>
	      </li>
	      <li>
	        <span class="label">企业微博</span>
	        <p>
	        	<c:choose>
	        		<c:when test="${isLogon==true}"><c:out value="${card.blogAddress}" escapeXml="true" /></c:when>
	        		<c:otherwise>******</c:otherwise>
	        	</c:choose>
	        </p>
	      </li>
	      <li>
	        <span class="label">微信公众号</span>
	        <p>
	        	<c:choose>
	        		<c:when test="${isLogon==true}"><c:out value="${card.weixinPublicAccount}" escapeXml="true" /></c:when>
	        		<c:otherwise>******</c:otherwise>
	        	</c:choose>
	        </p>
	      </li>
	    </ul>
	    <c:if test="${isLogon==false}">
	    <a href="<my:link domain="login" uri="/view/login.do"/>?redirectURL=<%=java.net.URLEncoder.encode(request.getScheme() + "://" + request.getServerName() + "/", "utf-8")%>" class="btn_common btn_orange btn_size_40 btn_rim_radius">登录后查看联系方式</a>
	    </c:if>
	  </div>
	</div>
	
	<!-- 更多联系人信息 -->
	<c:if test="${contactList != null && fn:length(contactList) > 0}">
	<div class="aside more_contect_box">
	  <div class="hd"><h3>更多联系人信息</h3></div>
	  <div class="bd">
	    <ul class="more_contect_info">
	    	<c:forEach items="${contactList}" var="item" varStatus="stat">
	    	<li>
	        <p class="name"><strong><c:out value="${item.contactName}" escapeXml="true" /></strong><c:if test="${item.position != null && item.position != '' }">（<c:out value="${item.position}" escapeXml="true" />）</c:if></p>
	        <p><span>手&nbsp;&nbsp;&nbsp;机</span>
	        	<c:choose>
          		<c:when test="${isLogon==true}"><c:out value="${item.mobile}" escapeXml="true" /></c:when>
          		<c:otherwise>${fn:substring(item.mobile, 0, 4)}*******</c:otherwise>
          	</c:choose>
	         <p><span>邮&nbsp;&nbsp;&nbsp;箱</span>
	         <c:choose>
	         	<c:when test="${isLogon ==true}">
	         		<c:out value="${item.email}" escapeXml="true" />
	         	</c:when>
	         	<c:otherwise>
	         		<c:set var="mailArr" value="${fn:split(item.email, '@')}" />
							<c:choose>
							<c:when test="${mailArr != null && fn:length(mailArr) >=2}">
								${fn:substring(mailArr[0], 0, 4)}***@***.***
							</c:when>
							<c:otherwise>${fn:substring(item.email, 0, 4)}***@***.***</c:otherwise>
							</c:choose>
	         	</c:otherwise>
	         </c:choose>
	         </p>
	      </li>
	    	</c:forEach>
	    </ul>
	    <c:choose>
	    	<c:when test="${isLogon == false}"><a href="<my:link domain='login' uri='/' />" class="btn_common btn_orange btn_size_40 btn_rim_radius">我要加入</a></c:when>
	    	<c:when test="${supplierId != userCompanyId}"><a href="<my:link domain='my' uri='/companycert/introduce' />" class="btn_common btn_orange btn_size_40 btn_rim_radius">我要加入</a></c:when>
	    	<c:otherwise></c:otherwise>
	    </c:choose>
	  </div>
	</div>
	</c:if>
	
</div>
<!-- /.sidebar -->