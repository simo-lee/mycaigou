package com.mysoft.b2b.company.archives.vo;

import java.io.Serializable;

import com.mysoft.b2b.supplier.api.Product;


public class ProductInfoVo implements Serializable{

	private static final long serialVersionUID = -1109304575654039208L;
	
	private Product product;
	
	private String documents;
	

	public Product getProduct() {
		return product;
	}

	public void setProduct(Product product) {
		this.product = product;
	}

	public String getDocuments() {
		return documents;
	}

	public void setDocuments(String documents) {
		this.documents = documents;
	}
	
}
