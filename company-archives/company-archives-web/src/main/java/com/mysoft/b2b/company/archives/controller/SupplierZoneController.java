package com.mysoft.b2b.company.archives.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringEscapeUtils;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mysoft.b2b.basicsystem.settings.api.CompanyProperty;
import com.mysoft.b2b.basicsystem.settings.api.CurrencyType;
import com.mysoft.b2b.basicsystem.settings.api.DictionaryService;
import com.mysoft.b2b.basicsystem.settings.api.Region;
import com.mysoft.b2b.basicsystem.settings.api.SupplierTag;
import com.mysoft.b2b.bizsupport.api.BasicCategory;
import com.mysoft.b2b.bizsupport.api.BasicCategoryService;
import com.mysoft.b2b.bizsupport.api.MessageCenterService;
import com.mysoft.b2b.bizsupport.api.MessageChannel;
import com.mysoft.b2b.bizsupport.api.MessageReceiver;
import com.mysoft.b2b.bizsupport.api.Qualification;
import com.mysoft.b2b.bizsupport.api.QualificationLevel;
import com.mysoft.b2b.bizsupport.api.QualificationLevelService;
import com.mysoft.b2b.bizsupport.api.QualificationService;
import com.mysoft.b2b.commons.exception.PlatformUncheckException;
import com.mysoft.b2b.commons.taglib.DomainTag;
import com.mysoft.b2b.company.api.SupplierDocument;
import com.mysoft.b2b.company.api.SupplierDocumentGroup;
import com.mysoft.b2b.company.archives.vo.PageVo;
import com.mysoft.b2b.company.archives.vo.ProductInfoVo;
import com.mysoft.b2b.company.archives.vo.SupplierProjectVo;
import com.mysoft.b2b.datacenter.useranalysis.SupplierStatService;
import com.mysoft.b2b.datacenter.useranalysis.SupplierUserStat;
import com.mysoft.b2b.developer.api.BrowseSupplier;
import com.mysoft.b2b.developer.api.BrowseSupplierService;
import com.mysoft.b2b.developer.api.MySupplier;
import com.mysoft.b2b.developer.api.MySupplierLog;
import com.mysoft.b2b.developer.api.MySupplierService;
import com.mysoft.b2b.sso.api.OnlineUser;
import com.mysoft.b2b.sso.api.OnlineUserContext;
import com.mysoft.b2b.sso.api.utils.CookieUtils;
import com.mysoft.b2b.supplier.api.AboutUsVo;
import com.mysoft.b2b.supplier.api.CompanyContact;
import com.mysoft.b2b.supplier.api.Product;
import com.mysoft.b2b.supplier.api.ProductService;
import com.mysoft.b2b.supplier.api.ProductVO;
import com.mysoft.b2b.supplier.api.SupplierAuditData;
import com.mysoft.b2b.supplier.api.SupplierAward;
import com.mysoft.b2b.supplier.api.SupplierBrand;
import com.mysoft.b2b.supplier.api.SupplierBrandStatus;
import com.mysoft.b2b.supplier.api.SupplierBusinessCard;
import com.mysoft.b2b.supplier.api.SupplierData;
import com.mysoft.b2b.supplier.api.SupplierDataService;
import com.mysoft.b2b.supplier.api.SupplierDocumentService;
import com.mysoft.b2b.supplier.api.SupplierInstitution;
import com.mysoft.b2b.supplier.api.SupplierIntroduction;
import com.mysoft.b2b.supplier.api.SupplierIntroductionService;
import com.mysoft.b2b.supplier.api.SupplierIntroductionVo;
import com.mysoft.b2b.supplier.api.SupplierManagerService;
import com.mysoft.b2b.supplier.api.SupplierProject;
import com.mysoft.b2b.supplier.api.SupplierQualify;
import com.mysoft.b2b.supplier.api.SupplierQualifyCode;
import com.mysoft.b2b.supplier.api.SupplierQualifyStatus;
import com.mysoft.b2b.supplier.api.SupplierService;
import com.mysoft.b2b.user.business.api.BusinessCard;
import com.mysoft.b2b.user.business.api.BusinessCardService;
import com.mysoft.b2b.uuc.api.User;
import com.mysoft.b2b.uuc.api.UserIdentity;
import com.mysoft.b2b.uuc.api.UserService;


/**
 * 供应商旗舰店--页面控制器
 * 
 */
@Controller
public class SupplierZoneController extends BaseController {
	
	private static final Logger LOG = LoggerFactory.getLogger(SupplierZoneController.class);

	@Autowired
	private SupplierDataService supplierDataService;

	@Autowired
	private SupplierService supplierService;

	@Autowired
	private DictionaryService dictionaryService;

	@Autowired
	private BasicCategoryService basicCategoryService;

	@Autowired
	private MySupplierService mySupplierService;

	@Autowired
	private QualificationService qualificationService;

	@Autowired
	private QualificationLevelService qualificationLevelService;

	@Autowired
	private BrowseSupplierService browseSupplierService;

	@Autowired
	private SupplierStatService supplierStatService;

	@Autowired
	private ProductService productService;

	@Autowired
	private SupplierDocumentService supplierDocumentService;

	@Autowired
	private MessageCenterService messageCenterService;
	
	@Autowired
	private BusinessCardService businessCardService;
	
	@Autowired
	private UserService userService;

	/**
	 * 公司简介
	 */
	@Autowired
	private SupplierIntroductionService supplierIntroductionService;
	
	/**
	 * 分支机构
	 */
	@Autowired
	private SupplierManagerService supplierManagerService;
	/**
	 * 首页页面文件
	 */
	private static final String WEB_PAGE_INDEX = "home/main";

	/**
	 * 页头页面文件
	 */
	private static final String WEB_PAGE_TOP = "common/top";

	/**
	 * 左侧页面文件
	 */
	private static final String WEB_PAGE_SIDEBAR = "common/sidebar";

	/**
	 * 左侧页面文件
	 */
	private static final String WEB_PAGE_SIDEBAR2 = "common/sidebar2";
	
	/**
	 * 错误页面
	 */
	private static final String WEB_PAGE_ERROR = "error-404";

	/**
	 * 公共页头
	 * 
	 * @return
	 */
	@RequestMapping("/commontop")
	public String top(@RequestParam(value = "menuId", required = true) int menuId,
			@RequestParam(value = "supplierId", required = true) String supplierId, Model model) {
		LOG.info("供应商旗舰店页头,menuId:==>{}, supplierId:==>{}", menuId, supplierId);
		model.addAttribute("menuId", menuId);

		// 获取供应商名片信息
		SupplierBusinessCard card = supplierDataService.getSupplierBusinessCard(StringUtils.trim(supplierId));
		if (card == null) {
			card = new SupplierBusinessCard();
		}
		model.addAttribute("card", card);

		// 获取店标信息
		String shopStand = supplierDataService.getSupplierShopStand(supplierId);
		model.addAttribute("shopStand", shopStand);
		model.addAttribute("supplierId", supplierId);

		// 添加关注的状态信息
		addConcernStatus(model, supplierId);

		return WEB_PAGE_TOP;
	}

	// 添加关注的状态信息
	private void addConcernStatus(Model model, String supplierId) {
		LOG.info("添加关注的状态信息...");
		try {
			// 登录信息
		//	OnlineUser user = OnlineUserContext.getInstance().getCurrentUser();
			UserIdentity user = getLoginAccount();
			boolean isLogon = false;
			boolean canConcern = false;
			boolean canCancel = false;
			if (user != null) {
				LOG.info("用户已登录,companyId:==>" + user.getCompanyId() + "companyType:==>" + getCompanyType(user.getCompanyId()));
				isLogon = true;// 已登录
				if (!"1".equals(getCompanyType(user.getCompanyId()))) {
					canConcern = true;
				}
			} else {
				LOG.info("访问用户未登录...");
			}

			model.addAttribute("isLogon", isLogon);// 是否登录
			model.addAttribute("canConcern", canConcern);// 是否可关注
			model.addAttribute("canCancel", canCancel);// 是否可取消关注
		} catch (Exception ex) {
			LOG.error("调用开发商是否关注供应商接口发生错误,supplierId:" + supplierId, ex);
		}
	}

	// ///////////////////////////////////////////关注//////////////////////////////////////////////////////////
	/**
	 * 检测是否可以关注操作
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/check_concern")
	@ResponseBody
	public Map<String, Object> checkConcern(HttpServletRequest request) {
		Map<String, Object> result = new LinkedHashMap<String, Object>();
		boolean success = false;
		boolean toLogin = false;
		String message = "";
		try {
			HashMap<String, Object> map = new HashMap<String, Object>();
			UserIdentity user = getLoginAccount();
			if (user == null) {
				message = "您还未登录,请先登录";
				toLogin = true;
			} else if(StringUtils.isEmpty(user.getCompanyId())){  //公司ID为空
				message = "empty_companyId";
			}else if (StringUtils.isEmpty(initUserInfo(map, request)) ){
				message = "关注失败";
			} else {
				if ("2".equals(getCompanyType(user.getCompanyId()))) {
					MySupplier mySupplier = new MySupplier();
					mySupplier.setSupplierId(map.get("companyId") + "");// 供应商id
					mySupplier.setCompanyId(user.getCompanyId());// 开发商id
					mySupplier.setStatus(-1);//后台不判断状态
					MySupplier ret = mySupplierService.getMySupplier(mySupplier);
					LOG.info("调用查询是否关注接口返回的结果：" + ret);
					if (ret != null) {
						message = "您已关注该供应商";
					} else {
						success = true;
					}
				} else {
					message = "您当前为供应商,不能关注";
				}
			}
		} catch (Exception ex) {
			LOG.error("检测是否可以关注供应商发生错误", ex);
			message = "关注失败";
		}
		result.put("success", success);
		result.put("message", message);
		result.put("toLogin", toLogin);
		return result;
	}

	/**
	 * 关注操作
	 * 
	 * @return
	 */
	@RequestMapping(value = "/add_concern")
	@ResponseBody
	public Map<String, Object> addConcern(HttpServletRequest request) {
		Map<String, Object> result = new LinkedHashMap<String, Object>();
		boolean success = false;
		String message = "";
		try {
			HashMap<String, Object> map = new HashMap<String, Object>();
			if (StringUtils.isEmpty(initUserInfo(map, request))) {
				message = "关注失败";
			} else {
				UserIdentity user = getLoginAccount();
				MySupplier mySupplier = new MySupplier();
				mySupplier.setSupplierId(map.get("companyId") + "");// 供应商id
				mySupplier.setCompanyId(user.getCompanyId());// 开发商id
				mySupplier.setCreatedBy(user.getUserId());// 当前用户id
				int ret = mySupplierService.saveMySupplier(mySupplier);
				LOG.info("调用关注接口返回的数据:" + ret);
				if (ret <= 0) {
					message = "关注失败";
				} else {
					success = true;
					sendConcernMessage(map.get("companyId") + "", user);
				}
			}
		} catch (Exception ex) {
			LOG.error("关注供应商发生错误", ex);
			message = "关注失败";
		}

		result.put("success", success);
		result.put("message", message);
		return result;
	}

	/**
	 * 公共左侧边栏
	 * 
	 * @return
	 */
	@RequestMapping("/commonsidebar")
	public String sidebar(@RequestParam(value = "supplierId", required = true) String supplierId, Model model) {
		LOG.info("供应商旗舰店边栏, supplierId:==>{}", supplierId);

		// 获取供应商名片信息
		SupplierBusinessCard card = supplierDataService.getSupplierBusinessCard(StringUtils.trim(supplierId));
		if (card == null) {
			card = new SupplierBusinessCard();
		} else {
			card.setProvinceName(getRegionNameByCode(card.getProvinceCode()));
			card.setCityName(getRegionNameByCode(card.getCityCode()));
		}
		model.addAttribute("card", card);

		// 获取供应商的统计数据
		SupplierUserStat stat = supplierStatService.getSupplierUserStatBySupplierId(supplierId);
		if (stat == null || isOldDataThanOneDay(stat)) {
			stat = supplierStatService.saveAndReturnSupplierUserStatByBySupplierId(supplierId);
		}
		if (stat == null) {
			stat = new SupplierUserStat();
		}
		model.addAttribute("stat", stat);

		// 添加登录信息
		addLoginInfo(model);
		
		// 电子名片信息
		List<BusinessCard> cardList = businessCardService.getAuditBusinessCardByCompanyId(supplierId);
		if (cardList != null) {
			for (BusinessCard item : cardList) {
				if (item == null || StringUtils.isBlank(item.getUserId())) {
					continue;
				}
				User _u = userService.getLoginAccount(item.getUserId());
				if (null != _u && StringUtils.isNotEmpty(_u.getName())) {
					item.setName(_u.getName());
				}
			}
		}
		model.addAttribute("cardList", cardList);
		LOG.info("cardList:==>" + (cardList == null ? null : cardList.size()));

		return WEB_PAGE_SIDEBAR;
	}
	
	/**
	 * 公共左侧边栏
	 * 
	 * @return
	 */
	@RequestMapping("/commonsidebar2")
	public String sidebar2(@RequestParam(value = "supplierId", required = true) String supplierId, HttpServletRequest request, Model model) {
		LOG.info("供应商旗舰店边栏, supplierId:==>{}", supplierId);

		// 获取供应商名片信息
		SupplierBusinessCard card = supplierDataService.getSupplierBusinessCard(StringUtils.trim(supplierId));
		if (card == null) {
			card = new SupplierBusinessCard();
		} else {
			card.setProvinceName(getRegionNameByCode(card.getProvinceCode()));
			card.setCityName(getRegionNameByCode(card.getCityCode()));
		}
		model.addAttribute("card", card);

		// 添加登录信息
		addLoginInfo(model);

		// 电子名片信息
		List<BusinessCard> cardList = businessCardService.getAuditBusinessCardByCompanyId(supplierId);
		if (cardList != null) {
			for (BusinessCard item : cardList) {
				String userId = item.getUserId();
				if (item == null || StringUtils.isBlank(userId)) {
					continue;
				}
				String shopUrl = this.getSupplierDomain(userId, "4");
				item.setPersonalShopUrl(shopUrl);
				if (StringUtils.isNotBlank(item.getName())) {
					continue;
				}
				User _u = userService.getLoginAccount(userId);
				if (null != _u && StringUtils.isNotEmpty(_u.getName())) {
					item.setName(_u.getName());
				}
			}
		}
		model.addAttribute("cardList", cardList);
		LOG.info("cardList:==>" + (cardList == null ? null : cardList.size()));

		// 其他联系人信息
		List<CompanyContact> contactList = supplierDataService.getCompanyContactListByCompanyId(supplierId);
		if (contactList == null) {
			contactList = new ArrayList<CompanyContact>();
		}
		model.addAttribute("contactList", contactList);

		// 首页的url
		//String shopDomain = DomainTag.getDomainUrlByKey("s.shop", "/");
		//model.addAttribute("shopDomain", shopDomain);
		
		// 当前登录的用户ID
		String userCompanyId = "" + CookieUtils.getCookie(request, "companyId");
		model.addAttribute("userCompanyId", userCompanyId);

		return WEB_PAGE_SIDEBAR2;
	}
	
	private void addLoginInfo(Model model) {
		// 登录信息
		OnlineUser user = OnlineUserContext.getInstance().getCurrentUser();
		boolean isLogon = false;
		if (user != null) {
			isLogon = true;// 已登录
		}
		model.addAttribute("isLogon", isLogon);
	}

	private boolean isOldDataThanOneDay(SupplierUserStat stat) {
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.DAY_OF_YEAR, -1);
		Date date = cal.getTime();
		if (stat.getLastUpdatedTime() != null && stat.getLastUpdatedTime().before(date)) {
			return true;
		} else {
			return false;
		}
	}
	
	private static final String WEIXIN_URL= "http://m.mycaigou.com/WeiXin/Supplier.aspx?supplierid=";
	
	@RequestMapping("/{supplierId}")
	public String redirectMainPage(HttpServletRequest request, Model model,  @PathVariable String supplierId) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		if (StringUtils.isEmpty(initUserInfo(map, request))) {
			return WEB_PAGE_ERROR;
		}
		LOG.info("进入到供应商企业档案首页");
		// 如果是手机端访问,重定向
		if (judgeIsMoblie(request)) {
			return "redirect:" + WEIXIN_URL + supplierId;
		}
		this.mainInfo(supplierId, model);
		return WEB_PAGE_INDEX;
	}

	/**
	 * 供应商企业档案首页
	 * 
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping("/")
	public String main(HttpServletRequest request, Model model) {
		String prefix = this.getUrlDomainPrefix(request);
		boolean isSupplierId = prefix.matches("^g\\d{6,}$");
		if (isSupplierId) {
			String tmpSupplierId = prefix.toUpperCase();
			return "redirect:" + DomainTag.getDomainUrlByKey("g.archives", "/") + tmpSupplierId;
		} 
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		if (StringUtils.isEmpty(initUserInfo(map, request))) {
			return WEB_PAGE_ERROR;
		}
		LOG.info("进入到供应商企业档案首页");
		// 获取公司信息
		String supplierId = map.get("companyId") + "";
		// 如果是手机端访问,重定向
		if (judgeIsMoblie(request)) {
			return "redirect:" + WEIXIN_URL + supplierId;
		}
		/*
		SupplierData data = supplierDataService.getByCompanyId(supplierId);
		if (data == null) {
			data = new SupplierData();
		}
		if (data.getMainData() == null) {
			data.setMainData(new SupplierAuditData());
		}
		model.addAttribute("supplierId", supplierId);// 传递给页头的数据
		model.addAttribute("data", data);
		// 币种获取中文名称
		if (StringUtils.isNotBlank(data.getMainData().getRegCapitalUnit())) {
			CurrencyType ctype = dictionaryService.getCurrencyTypeByCode(data.getMainData().getRegCapitalUnit());
			model.addAttribute("currentUnit", ctype != null ? ctype.getName() : "");
		}
		// 设置省、市
		data.setProvinceName(getRegionNameByCode(data.getProvinceCode()));
		data.setCityName(getRegionNameByCode(data.getCityCode()));
		// 服务区域
		data.setRegionNameStr(getRegionNameByCodes(data.getRegionCodeStr()));
		// 公司类型
		if (StringUtils.isNotBlank(data.getCompanyType())) {
			CompanyProperty cp = dictionaryService.getCompanyPropertyByCode(data.getCompanyType());
			data.setCompanyTypeName(cp != null ? cp.getName() : "");
		}
		// 服务/产品分类
		if (StringUtils.isNotBlank(data.getServiceCategoryCodes())) {
			data.setServiceCategoryNames(getCategoryNameByCodes(data.getServiceCategoryCodes()));
		}
		// 供应商类型
		if (StringUtils.isNotBlank(data.getSupplierType())) {
			SupplierTag st = dictionaryService.getSupplierTagByKey(data.getSupplierType());
			data.setSupplierTypeName(st != null ? st.getName() : "");
		}
		
		Map<String, Object> itemMap = new LinkedHashMap<String, Object>();
		
		// 公司证照
		List<SupplierDocument> companyLicenseList = new ArrayList<SupplierDocument>();
		//获取营业执照信息
		SupplierDocument doc = new SupplierDocument();
		doc.setFileGroup(SupplierDocumentGroup.BUSINESS_LICENSE);
		doc.setCompanyId(supplierId);
		List<SupplierDocument> businessLicenses = supplierDocumentService.getSupplierDocuments(doc);
		if (CollectionUtils.isNotEmpty(businessLicenses)) {
			doc = businessLicenses.get(0);
			doc.setFileName("营业执照");
			companyLicenseList.add(doc);
		}
		//获取证照信息
		List<SupplierDocument> fileList2 = supplierDataService.getSupplierCertList(supplierId);
		if (CollectionUtils.isNotEmpty(fileList2)) {
			companyLicenseList.addAll(fileList2);
		}
		if(CollectionUtils.isNotEmpty(companyLicenseList)) {
			itemMap.put("公司证照", companyLicenseList);
		}
		
		// 服务资质数据
		List<SupplierQualify> suppQual = supplierManagerService.getSupplierQualifyList(supplierId);
		List<SupplierQualify> suppQualList = null;
		if (CollectionUtils.isNotEmpty(suppQual)) {
			suppQualList = new ArrayList<SupplierQualify>();
			List<SupplierQualifyCode> suppQualCodeList = getSupplierQualifyCodeList(supplierId);
			for (SupplierQualify sq : suppQual) {
				List<SupplierQualifyCode> qualifyCodeList = null;
				if (SupplierQualifyStatus.AUDIT_PASS.equals(sq.getStatus())) {
					if (CollectionUtils.isNotEmpty(suppQualCodeList)) {
						qualifyCodeList = new ArrayList<SupplierQualifyCode>();
						for (SupplierQualifyCode suppQC : suppQualCodeList) {
							if (suppQC.getQualifyId().equals(sq.getId())) {
								qualifyCodeList.add(suppQC);
							}
						}
						sq.setQualifyCodeList(qualifyCodeList);
					}
					suppQualList.add(sq);
				}
			}
		}
		if (CollectionUtils.isNotEmpty(suppQualList)) {
			itemMap.put("服务资质", suppQualList);
		}
		
		// 企业产品
		List<Product> productList = productService.getProductsByCompanyId(supplierId, 0, 500);
		if (CollectionUtils.isNotEmpty(productList)) {
			itemMap.put("明星产品/服务", productList);
		}

		// 成功案例
		List<SupplierProject> projectList = supplierManagerService.getSupplierProjectByCompanyId(supplierId, 0, 100);
		if (CollectionUtils.isNotEmpty(projectList)) {
			itemMap.put("成功案例", projectList);
		}

		// 品牌列表
		List<SupplierBrand> brandList = supplierManagerService.getSupplierBrandList(supplierId);
		List<SupplierBrand> brandResult = new ArrayList<SupplierBrand>();
		if (brandList != null) {
			for (SupplierBrand brand : brandList) {
				if (SupplierBrandStatus.AUDIT_PASS.equals(brand.getStatus())) {
					brandResult.add(brand);
				}
			}
		}
		if (CollectionUtils.isNotEmpty(brandResult)) {
			itemMap.put("企业品牌", brandResult);
		}
		
		// 企业荣誉
		List<SupplierAward> awardList = supplierService.findAwardsByCompanyId(supplierId, 0, 1000);
		if (CollectionUtils.isNotEmpty(awardList)) {
			itemMap.put("企业荣誉", awardList);
		}
		
		//分支机构或分公司信息列表
		List<SupplierInstitution> institutionList = supplierManagerService.getSupplierInstitutionList(supplierId);
		if (CollectionUtils.isNotEmpty(institutionList)) {
			itemMap.put("分支机构或工厂", institutionList);
		}
		
		// 企业相册
		SupplierDocument albumDoc = new SupplierDocument();
		albumDoc.setCompanyId(supplierId);
		albumDoc.setFileGroup(SupplierDocumentGroup.SUPPLIER_PHOTO);
		List<SupplierDocument> albumList = supplierDocumentService.getSupplierDocuments(albumDoc);
		if (CollectionUtils.isNotEmpty(albumList)) {
			// 按创建时间倒序
			Collections.sort(albumList, new Comparator<SupplierDocument> () {
				@Override
				public int compare(SupplierDocument o1, SupplierDocument o2) {
					int rtn = 0;
					if (o1.getCreatedTime().after(o2.getCreatedTime())) {
						rtn = -1;
					} else {
						rtn = 1;
					}
					return rtn;
				}
			});
			itemMap.put("企业相册", albumList);
		}
		model.addAttribute("itemMap", itemMap);
		
		UserIdentity user = getLoginAccount();
		try {
			// 开发商浏览供应商的记录
			String companyType = getCompanyType(user.getCompanyId());
			if (user != null &&  ! "1".equals(companyType)) {
				BrowseSupplier browseSupplier = new BrowseSupplier();
				browseSupplier.setSupplierId(supplierId);
				browseSupplier.setCompanyId(user.getCompanyId());
				browseSupplier.setCreatedTime(new Date());
				browseSupplier.setUserId(user.getUserId());
				browseSupplierService.addOrUpdateBrowseSupplier(browseSupplier);
				LOG.info("添加开发商浏览供应商旗舰店记录完成...");
			}
		} catch (Exception ex) {
			LOG.error("添加开发商浏览供应商旗舰店记录发生错误", ex);
		}

		// 是否开发商登录
		boolean isDev = false;
		if (user != null) {
			LOG.info("用户已登录,companyId:==>" + user.getCompanyId() + "companyType:==>" + getCompanyType(user.getCompanyId()));
			if ("2".equals(getCompanyType(user.getCompanyId()))) {
				isDev = true;
			}
		}
		model.addAttribute("isDev", isDev);// 是否开发商
		// 添加登录信息
		addLoginInfo(model);
		// 公司简介
		String aboutInfo = null;
		SupplierIntroduction introduction = supplierIntroductionService.getSupplierIntroductionById(supplierId);
		if (introduction != null && StringUtils.isNotBlank(introduction.getSupplierIntro())) {
			aboutInfo = StringEscapeUtils.escapeXml(introduction.getSupplierIntro());
			aboutInfo = aboutInfo.replaceAll("\r\n", "<br/>").replaceAll("\n", "<br/>").replaceAll(" ", "&nbsp;");
		}
		model.addAttribute("aboutInfo", aboutInfo);
		*/
		this.mainInfo(supplierId, model);
		return WEB_PAGE_INDEX;
	}
	
	/**
	 * 获取供应商信息
	 * 
	 * @param supplierId
	 * @param model
	 */
	private void mainInfo(String supplierId, Model model) {
		SupplierData data = supplierDataService.getByCompanyId(supplierId);
		if (data == null) {
			data = new SupplierData();
		}
		if (data.getMainData() == null) {
			data.setMainData(new SupplierAuditData());
		}
		model.addAttribute("supplierId", supplierId);// 传递给页头的数据
		// 币种获取中文名称
		if (StringUtils.isNotBlank(data.getMainData().getRegCapitalUnit())) {
			CurrencyType ctype = dictionaryService.getCurrencyTypeByCode(data.getMainData().getRegCapitalUnit());
			model.addAttribute("currentUnit", ctype != null ? ctype.getName() : "");
		}
		// 设置省、市
		data.setProvinceName(getRegionNameByCode(data.getProvinceCode()));
		data.setCityName(getRegionNameByCode(data.getCityCode()));
		// 服务区域
		data.setRegionNameStr(getRegionNameByCodes(data.getRegionCodeStr()));
		// 公司类型
		if (StringUtils.isNotBlank(data.getCompanyType())) {
			CompanyProperty cp = dictionaryService.getCompanyPropertyByCode(data.getCompanyType());
			data.setCompanyTypeName(cp != null ? cp.getName() : "");
		}
		// 服务/产品分类
		if (StringUtils.isNotBlank(data.getServiceCategoryCodes())) {
			data.setServiceCategoryNames(getCategoryNameByCodes(data.getServiceCategoryCodes()));
		}
		// 供应商类型
		if (StringUtils.isNotBlank(data.getSupplierType())) {
			SupplierTag st = dictionaryService.getSupplierTagByKey(data.getSupplierType());
			data.setSupplierTypeName(st != null ? st.getName() : "");
		}
		model.addAttribute("data", data);
		Map<String, Object> itemMap = new LinkedHashMap<String, Object>();
		// 公司证照
		List<SupplierDocument> companyLicenseList = new ArrayList<SupplierDocument>();
		//获取营业执照信息
		SupplierDocument doc = new SupplierDocument();
		doc.setFileGroup(SupplierDocumentGroup.BUSINESS_LICENSE);
		doc.setCompanyId(supplierId);
		List<SupplierDocument> businessLicenses = supplierDocumentService.getSupplierDocuments(doc);
		if (CollectionUtils.isNotEmpty(businessLicenses)) {
			doc = businessLicenses.get(0);
			doc.setFileName("营业执照");
			companyLicenseList.add(doc);
		}
		//获取证照信息
		List<SupplierDocument> fileList2 = supplierDataService.getSupplierCertList(supplierId);
		if (CollectionUtils.isNotEmpty(fileList2)) {
			companyLicenseList.addAll(fileList2);
		}
		if(CollectionUtils.isNotEmpty(companyLicenseList)) {
			itemMap.put("公司证照", companyLicenseList);
		}
		
		// 服务资质数据
		List<SupplierQualify> suppQual = supplierManagerService.getSupplierQualifyList(supplierId);
		List<SupplierQualify> suppQualList = null;
		if (CollectionUtils.isNotEmpty(suppQual)) {
			suppQualList = new ArrayList<SupplierQualify>();
			List<SupplierQualifyCode> suppQualCodeList = getSupplierQualifyCodeList(supplierId);
			for (SupplierQualify sq : suppQual) {
				List<SupplierQualifyCode> qualifyCodeList = null;
				if (SupplierQualifyStatus.AUDIT_PASS.equals(sq.getStatus())) {
					if (CollectionUtils.isNotEmpty(suppQualCodeList)) {
						qualifyCodeList = new ArrayList<SupplierQualifyCode>();
						for (SupplierQualifyCode suppQC : suppQualCodeList) {
							if (suppQC.getQualifyId().equals(sq.getId())) {
								qualifyCodeList.add(suppQC);
							}
						}
						sq.setQualifyCodeList(qualifyCodeList);
					}
					suppQualList.add(sq);
				}
			}
		}
		if (CollectionUtils.isNotEmpty(suppQualList)) {
			itemMap.put("服务资质", suppQualList);
		}
		
		// 企业产品
		List<Product> productList = productService.getProductsByCompanyId(supplierId, 0, 500);
		if (CollectionUtils.isNotEmpty(productList)) {
			itemMap.put("明星产品/服务", productList);
		}

		// 成功案例
		List<SupplierProject> projectList = supplierManagerService.getSupplierProjectByCompanyId(supplierId, 0, 100);
		if (CollectionUtils.isNotEmpty(projectList)) {
			itemMap.put("成功案例", projectList);
		}

		// 品牌列表
		List<SupplierBrand> brandList = supplierManagerService.getSupplierBrandList(supplierId);
		List<SupplierBrand> brandResult = new ArrayList<SupplierBrand>();
		if (brandList != null) {
			for (SupplierBrand brand : brandList) {
				if (SupplierBrandStatus.AUDIT_PASS.equals(brand.getStatus())) {
					brandResult.add(brand);
				}
			}
		}
		if (CollectionUtils.isNotEmpty(brandResult)) {
			itemMap.put("企业品牌", brandResult);
		}
		
		// 企业荣誉
		List<SupplierAward> awardList = supplierService.findAwardsByCompanyId(supplierId, 0, 1000);
		if (CollectionUtils.isNotEmpty(awardList)) {
			itemMap.put("企业荣誉", awardList);
		}
		
		//分支机构或分公司信息列表
		List<SupplierInstitution> institutionList = supplierManagerService.getSupplierInstitutionList(supplierId);
		if (CollectionUtils.isNotEmpty(institutionList)) {
			itemMap.put("分支机构或工厂", institutionList);
		}
		
		// 企业相册
		SupplierDocument albumDoc = new SupplierDocument();
		albumDoc.setCompanyId(supplierId);
		albumDoc.setFileGroup(SupplierDocumentGroup.SUPPLIER_PHOTO);
		List<SupplierDocument> albumList = supplierDocumentService.getSupplierDocuments(albumDoc);
		if (CollectionUtils.isNotEmpty(albumList)) {
			// 按创建时间倒序
			Collections.sort(albumList, new Comparator<SupplierDocument> () {
				@Override
				public int compare(SupplierDocument o1, SupplierDocument o2) {
					int rtn = 0;
					if (o1.getCreatedTime().after(o2.getCreatedTime())) {
						rtn = -1;
					} else {
						rtn = 1;
					}
					return rtn;
				}
			});
			itemMap.put("企业相册", albumList);
		}
		model.addAttribute("itemMap", itemMap);
		
		UserIdentity user = getLoginAccount();
		try {
			// 开发商浏览供应商的记录
			String companyType = getCompanyType(user.getCompanyId());
			if (user != null &&  ! "1".equals(companyType)) {
				BrowseSupplier browseSupplier = new BrowseSupplier();
				browseSupplier.setSupplierId(supplierId);
				browseSupplier.setCompanyId(user.getCompanyId());
				browseSupplier.setCreatedTime(new Date());
				browseSupplier.setUserId(user.getUserId());
				browseSupplierService.addOrUpdateBrowseSupplier(browseSupplier);
				LOG.info("添加开发商浏览供应商旗舰店记录完成...");
			}
		} catch (Exception ex) {
			LOG.error("添加开发商浏览供应商旗舰店记录发生错误", ex);
		}

		// 是否开发商登录
		boolean isDev = false;
		if (user != null) {
			LOG.info("用户已登录,companyId:==>" + user.getCompanyId() + "companyType:==>" + getCompanyType(user.getCompanyId()));
			if ("2".equals(getCompanyType(user.getCompanyId()))) {
				isDev = true;
			}
		}
		model.addAttribute("isDev", isDev);// 是否开发商
		// 添加登录信息
		addLoginInfo(model);
		// 公司简介
		String aboutInfo = null;
		SupplierIntroduction introduction = supplierIntroductionService.getSupplierIntroductionById(supplierId);
		if (introduction != null && StringUtils.isNotBlank(introduction.getSupplierIntro())) {
			aboutInfo = StringEscapeUtils.escapeXml(introduction.getSupplierIntro());
			aboutInfo = aboutInfo.replaceAll("\r\n", "<br/>").replaceAll("\n", "<br/>").replaceAll(" ", "&nbsp;");
		}
		model.addAttribute("aboutInfo", aboutInfo);
	}

	/**
	 * 获取供应商资质code
	 * 
	 * @param supplierId
	 * @return
	 */
	private List<SupplierQualifyCode> getSupplierQualifyCodeList(String supplierId) {
		try {
			List<SupplierQualifyCode> codeList = supplierDataService.getSupplierQualifyCodeList(supplierId);
			for (SupplierQualifyCode code : codeList) {
				code.setQualifyNameCode(getQualifyNameByCode(code.getQualifyNameCode()));
				code.setQualifyLevelCode(getQualificationLevelByCode(code.getQualifyLevelCode()));
			}
			return codeList;
		} catch (Exception ex) {
			LOG.error("获取资质code列表发生错误");
		}
		return new ArrayList<SupplierQualifyCode>();
	}

	/**
	 * 获取资质文件
	 * 
	 * @param supplierId
	 * @return
	 */
	@SuppressWarnings("unused")
	private List<SupplierDocument> getSupplierQualifyFileList(String supplierId) {
		try {
			return supplierDataService.getSupplierQualifyFileList(supplierId);
		} catch (Exception ex) {
			LOG.error("获取资质code列表发生错误");
		}
		return new ArrayList<SupplierDocument>();
	}

	@RequestMapping("/about")
	public String about(HttpServletRequest request, Model model) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		if (StringUtils.isEmpty(initUserInfo(map, request))) {
			return WEB_PAGE_ERROR;
		}
		LOG.info("进入到供应商旗舰店关于我们............");
		String companyId = map.get("companyId").toString();
		
		AboutUsVo data =  new AboutUsVo();
		//供应商简介
		SupplierIntroduction introduction = supplierIntroductionService.getSupplierIntroductionById(companyId);
		SupplierDocument doc = new SupplierDocument();
		doc.setCompanyId(companyId);
		doc.setFileGroup(SupplierDocumentGroup.SUPPLIER_PHOTO);
		
		SupplierIntroductionVo  introductionVo = new SupplierIntroductionVo();
		introductionVo.setCompanyId(companyId);
		introductionVo.setIntroduction(introduction!=null?introduction.getSupplierIntro():"");
		//图片
		introductionVo.setDocuments(supplierDocumentService.getSupplierDocuments(doc));
		data.setIntroduction(introductionVo);
		
		if (StringUtils.isNotEmpty(introductionVo.getIntroduction())) {
			String _introduction = StringEscapeUtils.escapeXml(data.getIntroduction().getIntroduction());
			_introduction = _introduction.replaceAll("\r\n", "<br/>").replaceAll("\n", "<br/>").replaceAll(" ", "&nbsp;");
			data.getIntroduction().setIntroduction(_introduction);
		}
		model.addAttribute("data", data);
		
		//分支机构或分公司信息列表
		List<SupplierInstitution> institutionList = supplierManagerService.getSupplierInstitutionList(companyId);
		model.addAttribute("institutionList", institutionList);
		
		
		// 公司其他证照
		List<SupplierDocument> otherLicenseList = supplierDocumentService.getAuthedOtherDocuments(map.get("companyId")+"");
		model.addAttribute("otherLicenseList", otherLicenseList);
		
		LOG.info("supplierId:" + map.get("companyId"));
		model.addAttribute("supplierId", map.get("companyId"));
		model.addAttribute("companyName", getSupplierName(map.get("companyId") + ""));

		// 添加登录信息
		addLoginInfo(model);

		return "about";
	}

	@RequestMapping("/successcase")
	public String cases(HttpServletRequest request, Model model, PageVo page) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		if (StringUtils.isEmpty(initUserInfo(map, request))) {
			return WEB_PAGE_ERROR;
		}
		List<SupplierProject> data = supplierService.findProjectsByCompanyId(map.get("companyId").toString(),
				(page.getPage() - 1) * page.getPageSize(), page.getPageSize());
		
		List<SupplierProjectVo> _data = new ArrayList<SupplierProjectVo>();
		if(data !=null && !data.isEmpty()){
			for(SupplierProject project:data){
				_data.add(new SupplierProjectVo(project));
			}
		}
		int total = supplierService.findProjectTotalByCompanyId(map.get("companyId").toString());
		page.setRowNum(total);
		model.addAttribute("data",_data );
		model.addAttribute("queryString", request.getQueryString());
		model.addAttribute("page", page);
		LOG.info("supplierId:" + map.get("companyId"));
		model.addAttribute("supplierId", map.get("companyId"));
		model.addAttribute("companyName", getSupplierName(map.get("companyId") + ""));
		model.addAttribute("TDKMap", getTDK(1, map, null));
		return "case";
	}
	
	
	@RequestMapping("/award")
	public String award(HttpServletRequest request, Model model, PageVo page) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		if (StringUtils.isEmpty(initUserInfo(map, request))) {
			return WEB_PAGE_ERROR;
		}
		List<SupplierAward> data = supplierService.findAwardsByCompanyId(map.get("companyId").toString(),
				(page.getPage() - 1) * page.getPageSize(), page.getPageSize());
		
		int total = supplierService.findAwardTotalByCompanyId(map.get("companyId").toString());
		page.setRowNum(total);
		model.addAttribute("data", data);
		model.addAttribute("queryString", request.getQueryString());
		model.addAttribute("page", page);
		LOG.info("supplierId:" + map.get("companyId"));
		model.addAttribute("supplierId", map.get("companyId"));
		model.addAttribute("companyName", getSupplierName(map.get("companyId") + ""));
		model.addAttribute("TDKMap", getTDK(2, map, null));
		return "award";
	}
	/**
	 *  荣誉 详情
	 * @param request
	 * @param model
	 * @param awardId
	 * @return
	 */
	@RequestMapping("/award/detail-{awardId}.html")
	public String getAwardDetail(HttpServletRequest request, Model model, @PathVariable String awardId) {
		LOG.info("...getAwardDetail   awardId:" + awardId);
		if(StringUtils.isEmpty(awardId)){
			throw new PlatformUncheckException("getAwardDetail  param  id  is null",null);
		}
		HashMap<String, Object> map = new HashMap<String, Object>();
		if (StringUtils.isEmpty(initUserInfo(map, request))) {
			return WEB_PAGE_ERROR;
		}
		//取详情
		SupplierAward award = supplierService.getAwardByAwardId(awardId);
		String remark = award.getRemark()==null?"":award.getRemark();
		remark = textToHtml(remark);
		//remark.replaceAll("\r\n", "<br/>").replaceAll("\n", "<br/>").replaceAll(" ", "&nbsp;")
		award.setRemark(remark);
		model.addAttribute("TDKMap", getTDKForDetail(awardId,2, map));
		model.addAttribute("award",award);
		LOG.info("supplierId:" + map.get("companyId"));
		model.addAttribute("supplierId", map.get("companyId"));
		model.addAttribute("companyName", getSupplierName(map.get("companyId") + ""));
		return "awardDetail";
	}

	/**
	 * 成功案例 详情
	 * @param request
	 * @param model
	 * @param projectId
	 * @return
	 */
	@RequestMapping("/successcase/detail-{projectId}.html")
	public String getProjectDetail(HttpServletRequest request, Model model, @PathVariable String projectId) {
		LOG.info("...getProjectDetail   projectId:" + projectId);
		if(StringUtils.isEmpty(projectId)){
			throw new PlatformUncheckException("getProjectDetail  param  id  is null",null);
		}
		HashMap<String, Object> map = new HashMap<String, Object>();
		if (StringUtils.isEmpty(initUserInfo(map, request))) {
			return WEB_PAGE_ERROR;
		}
		//取详情
		SupplierProject project = supplierService.getProjectByProjectId(projectId);
		// 设置省、市
		project.setProjectProvinceName(getRegionNameByCode(project.getProjectProvinceCode()));
		project.setProjectCityName(getRegionNameByCode(project.getProjectCityCode()));
		
		String remark = project.getProjectRemark()==null?"":project.getProjectRemark();
		remark = textToHtml(remark);
		project.setProjectRemark(remark);
		model.addAttribute("TDKMap", getTDKForDetail(projectId,1, map));
		model.addAttribute("project",project);
		LOG.info("supplierId:" + map.get("companyId"));
		model.addAttribute("supplierId", map.get("companyId"));
		model.addAttribute("companyName", getSupplierName(map.get("companyId") + ""));
		return "projectDetail";
	}
	
	// ///////////////////////////////////////////查询计数数据//////////////////////////////////////////////////////////
	/**
	 * 根据code查找服务区域名称
	 * 
	 * @param codes
	 * @return
	 */
	private String getRegionNameByCode(String code) {
		if (StringUtils.isBlank(code)) {
			return null;
		}
		
		if("china".equalsIgnoreCase(code)) {
			return "全国";
		}

		Region region = dictionaryService.getRegionByCode(StringUtils.trim(code));
		if (region == null) {
			return null;
		}
		return region.getName();
	}

	/**
	 * 根据code查找服务区域名称
	 * 
	 * @param codes
	 * @return
	 */
	private String getRegionNameByCodes(String codes) {
		if (StringUtils.isBlank(codes)) {
			return null;
		}
		StringBuilder sb = new StringBuilder();
		LOG.info("开始调用字典服务查询服务区域code对应的名字, codes:==>{}", codes);
		String[] arr = codes.split(",");
		int index = 0;
		for (String item : arr) {
			String regionName = getRegionNameByCode(item);
			if (StringUtils.isBlank(regionName)) {
				continue;
			}
			sb.append(regionName);
			if (index != arr.length - 1) {
				sb.append(";");
			}
			index++;
		}
		String result = StringUtils.trim(sb.toString());
		LOG.info("调用字典服务查询服务区域code对应的名字完成, names:==>{}", result);

		return result;
	}

	/**
	 * 根据服务分类code获取服务分类名字,多个服务分类用逗号分隔
	 * 
	 * @param codes
	 * @return
	 */
	private String getCategoryNameByCodes(String codes) {
		if (StringUtils.isBlank(codes)) {
			return null;
		}
		String[] arr = StringUtils.split(codes, ",");
		if (arr == null || arr.length == 0) {
			return null;
		}
		List<String> list = Arrays.asList(arr);
		return getCategoryNameByCodeList(list);
	}

	/**
	 * 根据服务分类code获取服务分类名字
	 * 
	 * @param codes
	 * @return
	 */
	private String getCategoryNameByCodeList(List<String> codes) {
		if (codes == null || codes.isEmpty()) {
			return null;
		}

		StringBuilder sb = new StringBuilder();
		LOG.info("开始调用基础分类服务查询分类code对应的分类名字, codes:==>{}", codes);
		for (String item : codes) {
			if (StringUtils.isBlank(item)) {
				continue;
			}
			BasicCategory basicCategory = basicCategoryService.getCategoryByCode(StringUtils.trim(item));
			if (basicCategory == null) {
				continue;
			}
			if (StringUtils.isNotBlank(basicCategory.getCategoryName())) {
				sb.append(basicCategory.getCategoryName());
				sb.append(";");
			}
		}
		String result = StringUtils.trim(sb.toString());
		if (result.length() > 0) {
			result = result.substring(0, result.length() - 1);
		}
		LOG.info("调用基础分类服务查询分类code对应的分类名字完成, names:==>{}", result);

		return result;
	}

	/**
	 * 获取资质名称
	 * 
	 * @param code
	 * @return
	 */
	private String getQualifyNameByCode(String code) {
		if (StringUtils.isBlank(code)) {
			return null;
		}
		Qualification qn = qualificationService.getQualificationByCode(code);
		if (qn != null) {
			return qn.getQualificationName();
		}
		return null;
	}

	/**
	 * 获取资质等级名称
	 * 
	 * @param code
	 * @return
	 */
	private String getQualificationLevelByCode(String code) {
		if (StringUtils.isBlank(code)) {
			return null;
		}
		QualificationLevel ql = qualificationLevelService.getQualificationLevelByCode(code);
		if (ql != null) {
			return ql.getLevelName();
		}
		return null;
	}

	@RequestMapping("/product")
	public String product(HttpServletRequest request, Model model, PageVo page) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		if (StringUtils.isEmpty(initUserInfo(map, request))) {
			return WEB_PAGE_ERROR;
		}
		ProductVO pageVo = new ProductVO();
		pageVo.setCompanyId(map.get("companyId").toString());
		pageVo.setStartIndex((page.getPage() - 1) * pageVo.getPageSize());
		pageVo.setDisplay(1);
		page.setPageSize(pageVo.getPageSize());
		pageVo.setStatus(2);
		page.setRowNum(productService.getProductsCount(pageVo));
		//TDK设置
		StringBuffer productNames = new StringBuffer();
		
		List<Product> products = productService.getProducts(pageVo);
		if (products != null && !products.isEmpty()) {
			List<ProductInfoVo> data = new ArrayList<ProductInfoVo>();
			for (int i = 0;i<products.size();i++) {
				Product product  = products.get(i);
				SupplierDocument filterDocument = new SupplierDocument();
				filterDocument.setCompanyId(map.get("companyId").toString());
				filterDocument.setFileGroup(SupplierDocumentGroup.PRODUCT_PHOTO);
				filterDocument.setRelationId(product.getUid());
				List<SupplierDocument> documents = supplierDocumentService.getSupplierDocuments(filterDocument);
				ProductInfoVo info = new ProductInfoVo();
				info.setProduct(product);
				if (documents != null && !documents.isEmpty()) {
					info.setDocuments(documents.get(0).getFileId());
				}
				data.add(info);
				if(i<3){
					productNames.append(product.getProductName()).append("、");	
				}
			}
			model.addAttribute("data", data);
		}
		model.addAttribute("queryString", request.getQueryString());
		model.addAttribute("pageVo", page);
		model.addAttribute("supplierId", map.get("companyId"));
		model.addAttribute("companyName", getSupplierName(map.get("companyId") + ""));
		productNames =  productNames.length()!=0?productNames.deleteCharAt(productNames.length()-1):productNames;
		Map<String,String> TDKMap = getTDK(0, map, productNames.toString());
		model.addAttribute("TDKMap", TDKMap);
		return "product";
	}
	
	@RequestMapping(value="/product/detail-{uid}")
	public String productDetail(@PathVariable String uid,HttpServletRequest request,Model model){
		if(StringUtils.isEmpty(uid)){
			return WEB_PAGE_ERROR;
		}
		HashMap<String, Object> map = new HashMap<String, Object>();
		if (StringUtils.isEmpty(initUserInfo(map, request))) {
			return WEB_PAGE_ERROR;
		}
		ProductInfoVo info = new ProductInfoVo();
		Product product = productService.getProductById(uid);
		SupplierDocument filterDocument = new SupplierDocument();
		filterDocument.setCompanyId(product.getCompanyId());
		filterDocument.setFileGroup(SupplierDocumentGroup.PRODUCT_PHOTO);
		filterDocument.setRelationId(product.getUid());
		List<SupplierDocument> documents = supplierDocumentService.getSupplierDocuments(filterDocument);
		List<String> fileIds = new ArrayList<String>();
		if (documents != null && !documents.isEmpty()) {
			for (SupplierDocument document : documents) {
				fileIds.add(document.getFileId());
			}
		}
		if(product != null) {
			product.setRemark(this.textToHtml(product.getRemark()));
		}
		info.setProduct(product);
		
		//设置TDK
		Map<String,String> TDKMap = this.getTDKForDetail(product.getUid(), 0, map);
		model.addAttribute("TDKMap", TDKMap);
		model.addAttribute("data", info);
		model.addAttribute("fileIds", fileIds);
		model.addAttribute("supplierId", map.get("companyId"));
		return "productDetail";
	}
	
	/**
	 * 跳转到个人店铺详情页
	 * 
	 * @param productId
	 * @param supplierId
	 * @return
	 */
	@RequestMapping("/goProductDtl")
	public String goProductDetail(@RequestParam(required = true) String productId, 
			@RequestParam(required = true) String userId) {
		if (StringUtils.isEmpty(productId) || StringUtils.isEmpty(userId)) {
			return WEB_PAGE_ERROR;
		}
		String personalShopUrl = this.getSupplierDomain(userId, "4");
		LOG.info("redirect url: " + personalShopUrl);
		return "redirect:" + personalShopUrl + "/product/detail-" + productId + ".html";
	}
	
	/**
	 * 个人店铺成功案例详情页
	 * 
	 * @param productId
	 * @param supplierId
	 * @return
	 */
	@RequestMapping("/goProjectDtl")
	public String goProjectDetail(@RequestParam(required = true) String projectId,
			@RequestParam(required = true) String userId) {
		if (StringUtils.isEmpty(projectId) || StringUtils.isEmpty(userId)) {
			return WEB_PAGE_ERROR;
		}
		String personalShopUrl = this.getSupplierDomain(userId, "4");
		LOG.info("ProjectDtl redirect url: " + personalShopUrl);
		return "redirect:" + personalShopUrl + "/successcase/detail-" + projectId + ".html";
	}
	
	// 开发商关注供应商发送消息
	private void sendConcernMessage(String supplierId, UserIdentity user) {
		try {
			LOG.info("开发商关注供应商开始发送消息============================");
			// 发送消息
			String templateId = "17";
            //针对系统发送的消息 处理人 
            String sender = user.getCompanyId();
            String senderId = user.getCompanyId();
            //封装接收者
            List<MessageReceiver> receivers = new ArrayList<MessageReceiver>(); 
            MessageReceiver receiver = new MessageReceiver();
            //获取供应商名称
            //String supplierName = supplierService.getNameBySupplierId(supplierId);
            receiver.setReceiver(supplierId);
            receiver.setReceiverId(supplierId);
            Map<Integer, String> addrMap = new HashMap<Integer, String>();
            addrMap.put(MessageChannel.SITE_MESSAGE.getValue(), supplierId);
            receiver.setAddrMap(addrMap);
            receivers.add(receiver);
            //填充content数据
            HashMap<String, String> parameters = new HashMap<String, String>();
 			String url = DomainTag.getDomainUrlByKey("mainpage", "/").replace("www", user.getCompanyId());
 			parameters.put("developerPath", url);
 			parameters.put("developerName", StringEscapeUtils.escapeXml(getCompanyNameByCompanyId(user.getCompanyId())));
          
 			boolean result = messageCenterService.sendMessageByTemplateId(sender, senderId,receivers,templateId,parameters, null);
			
			LOG.info("开发商关注供应商发送消息结果:===========================" + result);
		} catch (Exception ex) {
			LOG.error("开发商关注供应商发送消息发生异常", ex);
		}

		try {
			LOG.info("开始记录关注操作日志");
			MySupplierLog mysupplierlog = new MySupplierLog();
			mysupplierlog.setCompanyId(user.getCompanyId());
			mysupplierlog.setSupplierId(supplierId);
			mysupplierlog.setExecutedTime(new Date());
			mysupplierlog.setOperator(user.getUserId());
			mysupplierlog.setType(5);// 关注
			mysupplierlog.setRemark("关注成功操作");
			mySupplierService.saveMySupplierLog(mysupplierlog);
			LOG.info("记录关注操作日志完成");
		} catch (Exception ex) {
			LOG.info("记录关注操作日志完成", ex);
		}
	}

	/**
	 * 开发商发送近三年的营业额的消息
	 * 
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/tmsg", method = { RequestMethod.POST })
	public Map<String, Object> sendTurnoverMessage(HttpServletRequest request) {
		Map<String, Object> ret = new LinkedHashMap<String, Object>();
		boolean suc = false;
		String msg = "";

		HashMap<String, Object> map = new HashMap<String, Object>();
		if (StringUtils.isEmpty(initUserInfo(map, request))) {
			msg = "操作失败";
		} else {
			UserIdentity user = getLoginAccount();
			if (user == null) {
				msg = "您还未登录,请先登录";
			} else {
				if ("2".equals(getCompanyType(user.getCompanyId()))) {
					try {
						LOG.info("开发商关注供应商近三年营业额开始发送消息============================");
						// 发送消息
						String templateId = "80";
						String sender = user.getCompanyId();
			            String senderId = user.getCompanyId();
			            //封装接收者
			            List<MessageReceiver> receivers = new ArrayList<MessageReceiver>(); 
			            MessageReceiver receiver = new MessageReceiver();
			            //获取供应商名称
			            String supplierId = map.get("companyId") + "";
			            //String supplierName = supplierService.getNameBySupplierId(supplierId);
			            receiver.setReceiver(supplierId);
			            receiver.setReceiverId(supplierId); // 接受者--供应商ID;
			            Map<Integer, String> addrMap = new HashMap<Integer, String>();
			            addrMap.put(MessageChannel.SITE_MESSAGE.getValue(), supplierId);
			            receiver.setAddrMap(addrMap);
			            receivers.add(receiver);
			            //填充content数据
			            HashMap<String, String> parameters = new HashMap<String, String>();
			 			String url = DomainTag.getDomainUrlByKey("mainpage", "/").replace("www", user.getCompanyId());
			 			parameters.put("developerPath", url);
			 			parameters.put("developerName", StringEscapeUtils.escapeXml(getCompanyNameByCompanyId(user.getCompanyId())));
			 
			 			suc = messageCenterService.sendMessageByTemplateId(sender, senderId,receivers,templateId,parameters, null);
						
						LOG.info("开发商关注供应商近三年营业额发送消息结果:===========================" + suc);
					} catch (Exception ex) {
						LOG.error("发送营业额消息失败", ex);
						msg = "操作失败";
					}
				} else {
					msg = "您当前为供应商,不能执行该操作";
				}
			}
		}
		ret.put("success", suc);
		ret.put("message", msg);
		return ret;
	}

	/**
	 * 开发商发送需补充分类信息的消息
	 * 
	 * @return
	 */
	@RequestMapping(value = "/cmsg", method = { RequestMethod.POST })
	@ResponseBody
	public Map<String, Object> sendCategoryMessage(@RequestParam(value = "cat", required = true) String categoryList,
			HttpServletRequest request) {
		Map<String, Object> ret = new LinkedHashMap<String, Object>();
		boolean suc = false;
		String msg = "";

		HashMap<String, Object> map = new HashMap<String, Object>();
		if (StringUtils.isEmpty(initUserInfo(map, request))) {
			msg = "操作失败";
		} else {
			UserIdentity user = getLoginAccount();
			if (user == null) {
				msg = "您还未登录,请先登录";
			} else {
				if ("2".equals(getCompanyType(user.getCompanyId()))) {
					try {
						LOG.info("开发商关注供应商其他分类信息开始发送消息============================");
						// 发送消息
						String templateId = "81";
			            //针对系统发送的消息 处理人 
			            String sender = getCompanyNameByCompanyId(user.getCompanyId());
			            String senderId = user.getCompanyId();
			            //封装接收者
			            List<MessageReceiver> receivers = new ArrayList<MessageReceiver>(); 
			            MessageReceiver receiver = new MessageReceiver();
			            //获取供应商名称
			            String supplierId = map.get("companyId") + "";
			            //String supplierName = supplierService.getNameBySupplierId(supplierId);
			            receiver.setReceiver(supplierId);
			            receiver.setReceiverId(supplierId); // 接受者--供应商ID;
			            Map<Integer, String> addrMap = new HashMap<Integer, String>();
			            addrMap.put(MessageChannel.SITE_MESSAGE.getValue(), supplierId);
			            receiver.setAddrMap(addrMap);
			            receivers.add(receiver);
			            //填充content数据
			            HashMap<String, String> parameters = new HashMap<String, String>();
			 			String url = DomainTag.getDomainUrlByKey("mainpage", "/").replace("www", user.getCompanyId());
			 			parameters.put("developerPath", url);
			 			parameters.put("developerName", StringEscapeUtils.escapeXml(getCompanyNameByCompanyId(user.getCompanyId())));
			 			parameters.put("categoryList", StringEscapeUtils.escapeXml(categoryList));
			 			
			 			suc = messageCenterService.sendMessageByTemplateId(sender, senderId,receivers,templateId,parameters, null);
						
						LOG.info("开发商关注供应商其他分类信息发送消息结果:===========================" + suc);
					} catch (Exception ex) {
						LOG.error("发送其他分类消息失败", ex);
						msg = "操作失败";
					}
				} else {
					msg = "您当前为供应商,不能执行该操作";
				}
			}
		}

		ret.put("success", suc);
		ret.put("message", msg);

		return ret;
	}
	
	/**
	 *SEO优化，获取TDK信息(详情页)
	 *@param type 0:产品，1：案例，2：荣誉 
	 *@param map 初始化公用信息的结果map
	 */
	private Map<String,String> getTDKForDetail(String id,Integer type,Map<String, Object> map){
		
		if(StringUtils.isBlank(id)){
			LOG.error("获取TDK信息失败，对象ID为空");
			return null;
		}
		Map<String,String> TDKMap = new HashMap<String, String>();
		String title = "";
		String description = "";
		String keyWords = "";
		
		String companyName = getSupplierName(map.get("companyId").toString());
		String shortName = getSupplierShortName(map.get("companyId").toString());
		
		//获取产品详情页的TDK信息
		if(type.compareTo(0)==0){
			Product product  = productService.getProductById(id);
			if (product == null) {
				LOG.error("产品对象为null");
				return null;
			}
			SupplierBusinessCard card = supplierDataService.getSupplierBusinessCard(StringUtils.trim(map.get("companyId")+""));
			String address = "";
			if (card != null) {
				String province = getRegionNameByCode(card.getProvinceCode());
				String city = getRegionNameByCode(card.getCityCode());
				address = province+(province.equals(city)?"":city);
			}
			title = ""+product.getProductName()+" - "+shortName+"产品展示 - 明源云采购";
			description = companyName+"，为"+address+"提供优质的"+product.getProductName()+"，被明源云采购纳入全国数万家精准房地产供应商数据库。";
			keyWords = product.getProductName();
		}
		
		//获取案列详情页的TDK信息
		else if(type.compareTo(1)==0){
			SupplierProject  project = supplierManagerService.getSupplierProjectById(id, null);
			if (project == null) {
				LOG.error("案列对象为null");
				return null;
			}
			title = project.getProjectName()+" - " + shortName+"成功案列 - 明源云采购";
			description = companyName+"最新成功案列有"+project.getProjectName();
			keyWords = project.getProjectName();
		}
		
		//获取荣誉详情页的TDK信息
		else if(type.compareTo(2)==0){
			SupplierAward  award = supplierManagerService.getSupplierAwardById(id, map.get("companyId").toString(), null);
			if (award == null) {
				LOG.error("荣誉对象为null");
				return null;
			}
			title = award.getName()+" - " + shortName+"企业荣誉 - 明源云采购";
			description = "欢迎了解"+companyName+award.getName()+"，让您能够对"+getSupplierShortName(map.get("companyId").toString())+"的企业荣誉信息有更全面的了解。";
			keyWords = award.getName();
		}
		TDKMap.put("title", title);
		TDKMap.put("description", description);
		TDKMap.put("keyWords", keyWords);
		return TDKMap;
	}
	
	/**
	 *SEO优化，获取TDK信息
	 *@param type 0:产品，1：案例，2：荣誉 
	 *@param map 初始化公用信息的结果map
	 *@param productName:如果是产品，则取值前3个产品的产品名称
	 *@param address:如果是产品，则取值公司所在地区+地址
	 */
	private Map<String,String> getTDK(Integer type,Map<String, Object> map,String productName){
		
		Map<String,String> TDKMap = new HashMap<String, String>();
		String title = "";
		String description = "";
		String keyWords = "";
		
		String companyName = getSupplierName(map.get("companyId").toString());
		String shortName = getSupplierShortName(map.get("companyId").toString());
		
		//获取产品的TDK信息
		if(type.compareTo(0)==0){
			title = shortName+"产品展示 - 明源云采购";
			SupplierBusinessCard card = supplierDataService.getSupplierBusinessCard(StringUtils.trim(map.get("companyId")+""));
			String address = "";
			if (card != null) {
				String province = StringUtils.trimToEmpty(getRegionNameByCode(card.getProvinceCode()));
				String city = StringUtils.trimToEmpty(getRegionNameByCode(card.getCityCode()));
				address = province+(province.equals(city)?"":city)+card.getAddress();
			}
			description = companyName+"，"+address+"，优质供应商主营产品或服务有"+productName+"，被明源云采购纳入全国数万家精准房地产供应商数据库。";
			keyWords = shortName+"产品展示";;
		}
		
		//获取案列的TDK信息
		else if(type.compareTo(1)==0){
			title = shortName+"成功案例 - 明源云采购";
			description = "欢迎了解"+companyName+"成功案例，明源云采购房地产供应商数据库为您提供最新"+shortName+"成功案例。";
			keyWords = shortName+"成功案例";
		}
		
		//获取荣誉的TDK信息
		else if(type.compareTo(2)==0){
			title = shortName+"企业荣誉 - 明源云采购";
			description = "欢迎了解"+companyName+"企业荣誉信息，让您能够对"+shortName+"的企业荣誉有更全面的了解。";
			keyWords = shortName+"企业荣誉";
		}
		TDKMap.put("title", title);
		TDKMap.put("description", description);
		TDKMap.put("keyWords", keyWords);
		return TDKMap;
	}


	// 获取公司名字
	private String getSupplierName(String supplierId) {
		try {
			return supplierService.getNameBySupplierId(supplierId);
		} catch (Exception ex) {
			LOG.error("根据供应商ID查找供应商名称出错!", ex);
			return "";
		}
	}
	
	private String getSupplierShortName(String supplierId){
		try {
			return supplierService.getShortNameBySupplierId(supplierId);
		} catch (Exception ex) {
			LOG.error("根据供应商ID查找供应商简称出错!", ex);
			return "";
		}
	}
	

}
