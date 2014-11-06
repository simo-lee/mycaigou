package com.mysoft.b2b.company.archives.vo;

import java.io.Serializable;

/**
 * 
 * @author Created zhangmin 2014-05-10 分页
 *
 */
public class PageVo implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private int page = 1;
	private int rowNum = 0;
	private int pageSize = 20;
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
	public int getRowNum() {
		return rowNum;
	}
	public void setRowNum(int rowNum) {
		this.rowNum = rowNum;
	}
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
}
