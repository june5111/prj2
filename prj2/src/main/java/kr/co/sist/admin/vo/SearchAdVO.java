package kr.co.sist.admin.vo;

import java.sql.Date;

public class SearchAdVO {

	private String cName, title; //�����, ��������
	private int jobNum, totalApply; // �����ȣ, �������
	private Date inputDate, endDate; //�������, ��������
	
	
	public String getcName() {
		return cName;
	}
	public void setcName(String cName) {
		this.cName = cName;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public int getJobNum() {
		return jobNum;
	}
	public void setJobNum(int jobNum) {
		this.jobNum = jobNum;
	}
	public int getTotalApply() {
		return totalApply;
	}
	public void setTotalApply(int totalApply) {
		this.totalApply = totalApply;
	}
	public Date getInputDate() {
		return inputDate;
	}
	public void setInputDate(Date inputDate) {
		this.inputDate = inputDate;
	}
	public Date getEndDate() {
		return endDate;
	}
	
	@Override
	public String toString() {
		return "SearchAdVO [cName=" + cName + ", title=" + title + ", jobNum=" + jobNum + ", totalApply=" + totalApply
				+ ", inputDate=" + inputDate + ", endDate=" + endDate + "]";
	}
	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}
	
	
	
	
	
	
	
	
}//class
