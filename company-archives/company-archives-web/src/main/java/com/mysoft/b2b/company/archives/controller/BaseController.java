package com.mysoft.b2b.company.archives.controller;

import java.util.HashMap;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.mysoft.b2b.bizsupport.api.DomainService;
import com.mysoft.b2b.commons.DomainUtil;
import com.mysoft.b2b.commons.HtmlUtils;
import com.mysoft.b2b.commons.taglib.DomainTag;
import com.mysoft.b2b.sso.api.OnlineUser;
import com.mysoft.b2b.sso.api.OnlineUserContext;
import com.mysoft.b2b.supplier.api.SupplierDataConstants;
import com.mysoft.b2b.supplier.api.SupplierDataService;
import com.mysoft.b2b.supplier.api.SupplierService;
import com.mysoft.b2b.uuc.api.CompanyType;
import com.mysoft.b2b.uuc.api.UserIdentity;
import com.mysoft.b2b.uuc.api.UserService;


/**
 * 控制器基类
 * 
 * @author subh
 * 
 */
public class BaseController {
	private static final Logger LOG = LoggerFactory.getLogger(BaseController.class);

	@Autowired
	private SupplierDataService supplierDataService;

	@Autowired
	private DomainService domainService;

	
	@Autowired
	private UserService userService;
	
	@Autowired
	private SupplierService supplierService;
	
	
	protected String getCompanyType(String companyid){
		if(StringUtils.isEmpty(companyid)){
			return null;
		}
		String companyType = null;
		if(companyid.toUpperCase().startsWith("G"))
			companyType =CompanyType.SUPPLIER.getValue();
		else if(companyid.toUpperCase().startsWith("K"))
			companyType = CompanyType.DEVELOPER.getValue();;
		return companyType;
	}

	/**
	 * 初始化公用信息
	 * 
	 * @param map
	 * @return companyId
	 */
	protected String initUserInfo(HashMap<String, Object> map, HttpServletRequest request) {
		String userId = "";
		String companyType = "";
		String currentCompanyId = "";
		// 登录用户信息
		UserIdentity user = getLoginAccount();
		if (null != user) {
			userId = user.getUserId();
			currentCompanyId = user.getCompanyId();
			if(currentCompanyId != null && currentCompanyId.toUpperCase().startsWith("G"))
				companyType =CompanyType.SUPPLIER.getValue();
			else if(null != currentCompanyId && currentCompanyId.toUpperCase().startsWith("K"))
				companyType = CompanyType.DEVELOPER.getValue();;
		}
		map.put("companyType", companyType);
		map.put("userId", userId);
		map.put("currentCompanyId", currentCompanyId);
		String companyId = request.getParameter("companyId");
		if (StringUtils.isBlank(companyId)) {
			String prefix = this.getUrlDomainPrefix(request);
			boolean isSupplierId = prefix.matches("^g\\d{6,}$");
			if (isSupplierId) {
				companyId = prefix.toUpperCase();
			} else if("g".equalsIgnoreCase(prefix)) {
				StringBuffer reqUrl = request.getRequestURL();
				if (StringUtils.isNotBlank(reqUrl)) {
					String reqUrlStr = reqUrl.toString();
					companyId = reqUrlStr.substring(reqUrlStr.lastIndexOf("/") + 1);
				}
			} else {
				companyId = domainService.getCompanyIdByPrefix(prefix);
			}
			LOG.info("通过域前缀查询公司id返回结果,prefix:" + prefix + ",companyId:" + companyId);
		} 

		// 获取供应商的状态信息--如果不是已通过审核，不能进入到旗舰店
		Integer authStatus = supplierDataService.getSupplierStatus(companyId);
		LOG.info("authStatus:" + authStatus);
		if (authStatus == null || authStatus.intValue() != SupplierDataConstants.AUDIT_STATUS_PASS) {
			LOG.info("当前供应商的审核状态为：" + authStatus);
			return null;
		}

		// 判断供应商是否已冻结
		Integer state = supplierDataService.getSupplierState(companyId);
		if (state == null || state.intValue() != SupplierDataConstants.SUPPLIER_STATE_ACTIVE) {
			LOG.info("当前供应商的冻结激活状态为：" + state);
			return null;
		}

		map.put("companyId", companyId);
		map.put("callUrl", getCallUrl(request));

		LOG.info("initUserInfo:" + map);
		return companyId;
	}

	/**
	 * 获取域名前缀
	 * 
	 * @param request
	 * @return
	 */
	protected String getUrlDomainPrefix(HttpServletRequest request) {
		String domainPrefix = request.getHeader("host");
		if (domainPrefix != null && domainPrefix.indexOf(".") > -1) {
			return domainPrefix.substring(0, domainPrefix.indexOf("."));
		}
		return "";
	}

	private String getCallUrl(HttpServletRequest request) {
		LOG.info("request.getRequestURI() == " + request.getRequestURI());
		LOG.info("request.getRequestURL() == " + request.getRequestURL());
		LOG.info("request.getRemoteHost() == " + request.getRemoteHost());
		return request.getContextPath();
	}

	/**
	 * 判断字符串是否是供应商ID
	 * 
	 * @param str
	 * @return
	 */
	protected boolean isSupplierId(String prefix) {
		if (StringUtils.isBlank(prefix)) {
			return false;
		}
		String str = StringUtils.trimToEmpty(prefix);
		if (str.length() < 7) {
			return false;
		}

		Pattern p = Pattern.compile("^[g|G]\\d{6,}$");
		Matcher m = p.matcher(str);
		return m.matches();
	}

	/**
	 * 获取供应商ID
	 * 
	 * @param str
	 * @return
	 */
	protected String formatSupplierId(String str) {
		return "G" + StringUtils.trimToEmpty(str).substring(1);
	}
	
	/**
	 * 文本转HTML，用于处理普通文本框录入文本的显示问题
	 * 
	 * @param text
	 * @return
	 */
	protected String textToHtml(String text) {
		if (StringUtils.isBlank(text)) {
			return "";
		}
		//String html = StringEscapeUtils.escapeHtml(text);
		String html = HtmlUtils.escape(text);
		html = html.replaceAll("\n", "<br/>").replaceAll("\r", "<br/>").
				replaceAll("\r\n", "<br/>").replaceAll(" ", "&nbsp;");
		return html;
	}
	
	/**
	 * 获取当前登录账户关联的公司id
	 * @return
	 */
	public  String getCompanyId(){
		OnlineUser onlineUser = OnlineUserContext.getInstance().getCurrentUser();
		if(onlineUser ==null) {
		//	LOG.info("当前账户没有登录", new IllegalAccessException("当前账户没有登录"));
			return null;
		}
		UserIdentity _user = userService.getCompanyIdByUserid(onlineUser.getUserId());
		if(_user !=null) 
			return _user.getCompanyId();
		return null;
	}
	/**
	 * 获取当前登录账户的用户id
	 * @return
	 */
	public  String getUserId(){
		OnlineUser onlineUser = OnlineUserContext.getInstance().getCurrentUser();
		if(onlineUser ==null) {
		//	LOG.info("当前账户没有登录", new IllegalAccessException("当前账户没有登录"));
			onlineUser = new OnlineUser();
		}
		return onlineUser.getUserId();
	}
	
	/**
	 * 获取当前登录账户信息
	 * @return
	 */
	public  UserIdentity getLoginAccount(){
		OnlineUser onlineUser = OnlineUserContext.getInstance().getCurrentUser();
		if(onlineUser ==null) {
		//	LOG.info("当前账户没有登录", new IllegalAccessException("当前账户没有登录"));
			return new UserIdentity();
		}
		UserIdentity _user = userService.getCompanyIdByUserid(onlineUser.getUserId());
		if(null == _user){
			_user = new UserIdentity();
			_user.setUserId(onlineUser.getUserId());
		}
		return _user;
	}
	public String getCompanyNameByCompanyId(String compnayId){
		if(StringUtils.isEmpty(compnayId))
			return "";
		String name = supplierService.getShortNameBySupplierId(compnayId);
		if(StringUtils.isEmpty(name))
			name =   supplierService.getNameBySupplierId(compnayId);
		return name;
	}
	
	public boolean judgeIsMoblie(HttpServletRequest request) {
		boolean isMoblie = false;
		String[] mobileAgents = { "iphone", "android", "phone", "mobile", "wap", "netfront", "java", "opera mobi",
				"opera mini", "ucweb", "windows ce", "symbian", "series", "webos", "sony", "blackberry", "dopod",
				"nokia", "samsung", "palmsource", "xda", "pieplus", "meizu", "midp", "cldc", "motorola", "foma",
				"docomo", "up.browser", "up.link", "blazer", "helio", "hosin", "huawei", "novarra", "coolpad", "webos",
				"techfaith", "palmsource", "alcatel", "amoi", "ktouch", "nexian", "ericsson", "philips", "sagem",
				"wellcom", "bunjalloo", "maui", "smartphone", "iemobile", "spice", "bird", "zte-", "longcos",
				"pantech", "gionee", "portalmmm", "jig browser", "hiptop", "benq", "haier", "^lct", "320x320",
				"240x320", "176x220", "w3c ", "acs-", "alav", "alca", "amoi", "audi", "avan", "benq", "bird", "blac",
				"blaz", "brew", "cell", "cldc", "cmd-", "dang", "doco", "eric", "hipt", "inno", "ipaq", "java", "jigs",
				"kddi", "keji", "leno", "lg-c", "lg-d", "lg-g", "lge-", "maui", "maxo", "midp", "mits", "mmef", "mobi",
				"mot-", "moto", "mwbp", "nec-", "newt", "noki", "oper", "palm", "pana", "pant", "phil", "play", "port",
				"prox", "qwap", "sage", "sams", "sany", "sch-", "sec-", "send", "seri", "sgh-", "shar", "sie-", "siem",
				"smal", "smar", "sony", "sph-", "symb", "t-mo", "teli", "tim-", "tosh", "tsm-", "upg1", "upsi", "vk-v",
				"voda", "wap-", "wapa", "wapi", "wapp", "wapr", "webc", "winw", "winw", "xda", "xda-",
				"Googlebot-Mobile" };
		LOG.info("User-Agent:==>" + request.getHeader("User-Agent"));
		if (request.getHeader("User-Agent") != null) {
			String userAgent = " " + request.getHeader("User-Agent").toLowerCase() + " ";
			for (String mobileAgent : mobileAgents) {
				if (userAgent.indexOf(" " + mobileAgent + " ") >= 0) {
					isMoblie = true;
					break;
				}
			}
		}
		LOG.info("isMoblie:==>" + isMoblie);
		return isMoblie;
	}
	
	/**
	 * 通过供应商或者开发商公司ID获取配置的二级域名，没有配置时返回默认域名
	 * @param companyId
	 * @return
	 */
	public String getCompanyDomain(String companyId){
		String domain = domainService.getDomainByCompanyId(companyId);
		return DomainTag.getDomainUrlByKey("mainpage", "/").replace("www", domain);
	}
	
	/**
	 * 通过ID号获取供应商相关的域名
	 * 
	 * @param id: supplierId 或 userId
	 * @param type： 2-企业档案；4-个人店铺
	 * @return
	 */
	protected String getSupplierDomain(String id, String type) {
		String rtnUrl = "";
		if (StringUtils.isNotBlank(id)) {
			String domain = domainService.getDomainByCompanyId(id);
			if (id.equalsIgnoreCase(domain)) {
				String pageKey = "2".equals(type) ? "g.archives" : "s.shop";
				rtnUrl = DomainTag.getDomainUrlByKey(pageKey, "/") + id;
			} else {
				//rtnUrl = DomainTag.getDomainUrlByKey("mainpage", "/").replace("www", domain);
				rtnUrl = DomainUtil.getDomain("mainpage").replace("www", domain);
				
			}
		}
		return rtnUrl;
	}
}
