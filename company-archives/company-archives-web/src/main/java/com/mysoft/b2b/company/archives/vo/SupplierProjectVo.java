package com.mysoft.b2b.company.archives.vo;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.StringEscapeUtils;
import org.apache.commons.lang3.StringUtils;

import com.mysoft.b2b.company.api.SupplierDocument;
import com.mysoft.b2b.supplier.api.SupplierProject;


public class SupplierProjectVo implements Serializable{

	
	private static final long serialVersionUID = 1L;

	private Integer count;
	
	private String fileIds;
	
	private String defaultFileId;
	
	private String projectName;
	
	private String remark;
	
	private String description;
	private String projectId;
	
	public String getProjectId() {
		return projectId;
	}

	public void setProjectId(String projectId) {
		this.projectId = projectId;
	}

	public SupplierProjectVo(SupplierProject project){
		List<SupplierDocument> documents = project.getDocumentList();
		if(documents !=null && !documents.isEmpty()){
			this.count = documents.size();
			this.defaultFileId = documents.get(0).getFileId();
			List<String> fileIds = new ArrayList<String>();
			for(SupplierDocument doc:documents){
				fileIds.add(doc.getFileId());
			}
			this.fileIds = StringUtils.join(fileIds, ",");
		}
		this.projectId = project.getId();
		this.projectName = project.getProjectName();
		this.remark = project.getProjectRemark();
		
		//拼接项目相关信息
		StringBuffer buffer = new StringBuffer();
		if(StringUtils.isNotEmpty(project.getProjectName())){
			buffer.append("项目名称：").append(StringEscapeUtils.escapeXml(project.getProjectName())).append("；  ");
		}
		if(StringUtils.isNotEmpty(project.getProjectCompany())){
			buffer.append("甲方单位：").append(StringEscapeUtils.escapeXml(project.getProjectCompany())).append("；  ");
		}
		if(StringUtils.isNotEmpty(project.getProjectRemark())){
			buffer.append("备注：").append(StringEscapeUtils.escapeXml(project.getProjectRemark())).append("；");
		}
		this.description = buffer.length()>0? buffer.deleteCharAt(buffer.length()-1).toString():"";
		
	}

	public Integer getCount() {
		return count;
	}

	public void setCount(Integer count) {
		this.count = count;
	}

	public String getFileIds() {
		return fileIds;
	}

	public void setFileIds(String fileIds) {
		this.fileIds = fileIds;
	}

	public String getDefaultFileId() {
		return defaultFileId;
	}

	public void setDefaultFileId(String defaultFileId) {
		this.defaultFileId = defaultFileId;
	}

	public String getProjectName() {
		return projectName;
	}

	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}
}
