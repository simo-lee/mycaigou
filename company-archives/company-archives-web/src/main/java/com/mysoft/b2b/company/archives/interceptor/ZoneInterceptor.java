package com.mysoft.b2b.company.archives.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.mysoft.b2b.sso.api.OnlineUser;
import com.mysoft.b2b.sso.api.interceptor.ControllerInterceptor;
import com.mysoft.b2b.supplier.api.SupplierDataService;

/**
 * 供应商旗舰店拦截器
 * 
 * @author subh
 * 
 */
public class ZoneInterceptor extends ControllerInterceptor {
	private static final Logger LOG = LoggerFactory.getLogger(ZoneInterceptor.class);
	@Autowired
	private SupplierDataService supplierDataService;

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object arg2) throws Exception {
		boolean b =  super.preHandle(request, response, arg2);
		if (!b) {
			LOG.info("用户未登录====================");
			return true;// 用户未登录,可以访问旗舰店
		}
		
		return true;
		/*boolean b = super.preHandle(request, response, arg2);
		if (!b) {
			LOG.info("用户未登录====================");
			return b;
		}

		try {
			LOG.info("用户已登录====================");
			OnlineUser user = OnlineUserContext.getInstance().getCurrentUser();
			if (CompanyType.SUPPLIER.getValue().equals(user.getCompanyType())) {
				Integer status = supplierDataService.getSupplierStatus(user.getCompanyId());
				if (SupplierDataConstants.AUDIT_STATUS_PASS.equals(status)) {
					return true;
				}

				String editUrl = DomainTag.getDomainUrlByKey("gys.backstage", "/data/edit.do");
				response.sendRedirect(editUrl);
				return false;
			} else {
				return true;
			}
		} catch (Exception ex) {
			LOG.error("供应商期间店拦截器发生异常", ex);
			return false;
		}*/
	}

	@Override
	protected boolean checkUserAuthority(OnlineUser user) {
		if (user != null) {
			return true;
		}
		return false;
	}

}
