<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://mysoft.com/taglib/domain" prefix="my"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<div class="sidebar">

	<div class="section_wrap">
		<c:choose>
			<c:when test="${cardList == null || fn:length(cardList) == 0}">
				<h3>公司名片</h3>
				<div class="section_cont sidebar_card">
					<h4>
						<c:out value="${card.companyName}" escapeXml="true" />
					</h4>
					<ul>
						<li><label for="">所在地区：</label> <span> <c:out
									value="${card.provinceName}" escapeXml="true" /> <c:if
									test="${card.provinceName!=card.cityName}">
									<c:out value="${card.cityName}" escapeXml="true" />
								</c:if>
						</span></li>
						<li><label for="">地&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;址：</label> <span><c:out
									value="${card.address}" escapeXml="true" /></span></li>
						<li><label for="">总&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;机：</label> <span><c:choose>
									<c:when test="${isLogon==true}">
										<c:out value="${card.telephone}" escapeXml="true" />
									</c:when>
									<c:otherwise>******</c:otherwise>
								</c:choose></span></li>
						<li><label for="">传&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;真：</label> <span><c:choose>
									<c:when test="${isLogon==true}">
										<c:out value="${card.fax}" escapeXml="true" />
									</c:when>
									<c:otherwise>******</c:otherwise>
								</c:choose></span></li>
						<li><label for="">服务热线：</label> <span><c:choose>
									<c:when test="${isLogon==true}">
										<c:out value="${card.hotline}" escapeXml="true" />
									</c:when>
									<c:otherwise>******</c:otherwise>
								</c:choose></span></li>
						<li><label for="">电子邮箱：</label> <span><c:choose>
									<c:when test="${isLogon==true}">
										<c:out value="${card.contactEmail}" escapeXml="true" />
									</c:when>
									<c:otherwise>******</c:otherwise>
								</c:choose></span></li>
						<li><label for="">网&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;址：</label> <span><c:choose>
									<c:when test="${isLogon==true}">
										<c:if test="${card.website != null && card.website != ''}">
											<c:if test="${fn:startsWith(card.website, 'http')}">
												<a href="<c:out value="${card.website}" escapeXml="true" />"
													target="_blank"><c:out value="${card.website}"
														escapeXml="true" /></a>
											</c:if>
											<c:if test="${fn:startsWith(card.website, 'http') == false}">
												<a
													href="http://<c:out value="${card.website}" escapeXml="true" />"
													target="_blank"><c:out value="${card.website}"
														escapeXml="true" /></a>
											</c:if>
										</c:if>
									</c:when>
									<c:otherwise>******</c:otherwise>
								</c:choose> </span></li>
						<li><label for="" style="letter-spacing: 0.8px;">联&nbsp;&nbsp;系人：</label> <span><c:choose>
									<c:when test="${isLogon==true}">
										<c:out value="${card.contactName}" escapeXml="true" />
									</c:when>
									<c:otherwise>******</c:otherwise>
								</c:choose></span></li>
						<li><label for="">职&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;务：</label> <span><c:choose>
									<c:when test="${isLogon==true}">
										<c:out value="${card.contactPosition}" escapeXml="true" />
									</c:when>
									<c:otherwise>******</c:otherwise>
								</c:choose></span></li>
						<li><label for="">电&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;话：</label> <span><c:choose>
									<c:when test="${isLogon==true}">
										<c:out value="${card.telephone}" escapeXml="true" />
									</c:when>
									<c:otherwise>******</c:otherwise>
								</c:choose></span></li>
						<li><label for="">手&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;机：</label> <span><c:choose>
									<c:when test="${isLogon==true}">
										<c:out value="${card.contactMobile}" escapeXml="true" />
									</c:when>
									<c:otherwise>******</c:otherwise>
								</c:choose></span></li>
						<c:if test="${isLogon==false}">
							<li class="align_center"><a
								href="<my:link domain="login" uri="/view/login.do"/>?redirectURL=<%=java.net.URLEncoder.encode(request.getScheme() + "://" + request.getServerName() + "/", "utf-8")%>"
								class="btn_common btn_blue btn_size_30">登录后查看联系方式</a></li>
						</c:if>
					</ul>
				</div>
			</c:when>
			<c:otherwise>
				<div class="sec_namecard_list">
					<c:forEach items="${cardList}" var="item">

						<div class="section_cont sec_namecard">
							<div class="sec_nc_view">
								<div class="sec_nc_photo">
									<c:choose>
										<c:when test="${item.logo != null && item.logo != '' }">
											<img
												src="<my:link domain="img.static" uri="/netdiskimg/user-card-logo/${item.logo}.150x150.jpg" />" />
										</c:when>
										<c:otherwise>
											<img
												src="<my:link domain="jcs.static" uri="/res1.5/img/common/head.png" />"
												alt="<c:out value="${item.name}" escapeXml="true" />">
										</c:otherwise>
									</c:choose>

								</div>
								<strong><c:out value="${item.name}" escapeXml="true" /></strong>
								<p>
									<c:out value="${item.postion}" escapeXml="true" />
								</p>
							</div>
							<div class="sec_nc_wrap">
								<label>我专注</label>
								<div class="sec_nc_cont">
									<p>
										<c:out value="${item.concentration}" escapeXml="true" />
									</p>
								</div>
							</div>
							<div class="sec_nc_wrap">
								<label>联系方式</label>
								<div class="sec_nc_cont">
									<ul class="sec_nc_list">
										<li><label>手&nbsp;&nbsp;机：</label><span><c:choose>
													<c:when test="${isLogon==true}">
														<c:out value="${item.mobile}" escapeXml="true" />
													</c:when>
													<c:otherwise>******</c:otherwise>
												</c:choose></span></li>
										<li><label>邮&nbsp;&nbsp;箱：</label><span><c:choose>
													<c:when test="${isLogon==true}">
														<c:out value="${item.mail}" escapeXml="true" />
													</c:when>
													<c:otherwise>******</c:otherwise>
												</c:choose></span></li>
										<li><label>传&nbsp;&nbsp;真：</label><span><c:choose>
													<c:when test="${isLogon==true}">
														<c:out value="${item.fax}" escapeXml="true" />
													</c:when>
													<c:otherwise>******</c:otherwise>
												</c:choose></span></li>
									</ul>
									<c:if test="${isLogon==false}">
										<div class="sec_nc_login">
											<a
												href="<my:link domain="login" uri="/view/login.do"/>?redirectURL=<%=java.net.URLEncoder.encode(request.getScheme() + "://" + request.getServerName() + "/", "utf-8")%>"
												class="btn_common btn_blue btn_size_30">登录后查看联系方式</a>
										</div>
									</c:if>
								</div>
							</div>
						</div>

					</c:forEach>
				</div>
			<!-- </div> -->
			</c:otherwise>
		</c:choose>
	</div>
	<div class="sidebar_detail_wrap">
		<ul>
			<c:if test="${card.showAuthTag == 1}">
			<li>
				<div class="sidebar_detail_view integrity"></div>
				<div class="sidebar_detail_cont">
					<h4>明源审核</h4>
					<p>
						基本资料由明源审核<br />通过
					</p>
				</div>
			</li>
			</c:if>
			<li>
				<div
					class="sidebar_detail_view <c:choose><c:when test="${stat.inStorageLevel != null}">level${stat.inStorageLevel}</c:when><c:otherwise>level0</c:otherwise></c:choose>"></div>
				<div class="sidebar_detail_cont">
					<h4>入库次数</h4>
					<p>
						已被<span class="nums"><c:choose>
								<c:when test="${stat.inStorageCount != null}">${stat.inStorageCount}</c:when>
								<c:otherwise>0</c:otherwise>
							</c:choose></span>家开发商<br />入库
					</p>
				</div>
			</li>
			<li>
				<div
					class="sidebar_detail_view <c:choose><c:when test="${stat.awardBidLevel != null && stat.awardBidLevel == 1}">gold_medal</c:when><c:when test="${stat.awardBidLevel != null && stat.awardBidLevel == 2}">silvery_medal</c:when><c:when test="${stat.awardBidLevel != null && stat.awardBidLevel == 3}">bronze_medal</c:when><c:otherwise>unable_medal</c:otherwise></c:choose>"></div>
				<div class="sidebar_detail_cont">
					<h4>
						<c:choose>
							<c:when
								test="${stat.awardBidLevel != null && stat.awardBidLevel == 1}">金牌供应商</c:when>
							<c:when
								test="${stat.awardBidLevel != null && stat.awardBidLevel == 2}">银牌供应商</c:when>
							<c:when
								test="${stat.awardBidLevel != null && stat.awardBidLevel == 3}">铜牌供应商</c:when>
							<c:otherwise>铜牌供应商</c:otherwise>
						</c:choose>
					</h4>
					<p>
						一年内在明源云采购<br />中标<span class="nums"><c:choose>
								<c:when test="${stat.awardBidCount != null}">${stat.awardBidCount}</c:when>
								<c:otherwise>0</c:otherwise>
							</c:choose></span>次
					</p>
				</div>
			</li>
			<c:if test="${stat.weekLogonLevel != null and stat.weekLogonLevel>0}">
				<li>
					<div
						class="sidebar_detail_view login<c:choose><c:when test="${stat.weekLogonLevel != null}">${stat.weekLogonLevel}</c:when><c:otherwise>0</c:otherwise></c:choose>"></div>
					<div class="sidebar_detail_cont">
						<h4>供应商活跃度</h4>
						<p>一周内登录次数</p>
					</div>
				</li>
			</c:if>
			<li>
				<div
					class="sidebar_detail_view complete<c:choose><c:when test="${stat.dataLevel != null}">${stat.dataLevel}0</c:when><c:otherwise>40</c:otherwise></c:choose>"></div>
				<div class="sidebar_detail_cont">
					<h4>资料完整度</h4>
					<p>
						资料完整度为<span>${stat.dataCount}%</span>
					</p>
				</div>
			</li>
		</ul>
	</div>
</div>