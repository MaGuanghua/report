package com.hanthink.report.pojo;

import java.math.BigDecimal;

public class StopInfoDTO {

	private String equitmentstatus;
	private String proline;
	private String shift;
	private String startprodate;
	private String endprodate;
	private String statustime;
	private String percentage;

	public String getEquitmentstatus() {
		return equitmentstatus;
	}

	public void setEquitmentstatus(String equitmentstatus) {
		this.equitmentstatus = equitmentstatus;
	}

	public String getProline() {
		return proline;
	}

	public void setProline(String proline) {
		this.proline = proline;
	}

	public String getShift() {
		return shift;
	}

	public void setShift(String shift) {
		this.shift = shift;
	}

	public String getStartprodate() {
		return startprodate;
	}

	public void setStartprodate(String startprodate) {
		this.startprodate = startprodate;
	}

	public String getEndprodate() {
		return endprodate;
	}

	public void setEndprodate(String endprodate) {
		this.endprodate = endprodate;
	}

	public String getStatustime() {
		return statustime;
	}

	public void setStatustime(String statustime) {
		this.statustime = statustime;
	}

	public String getPercentage() {
		return percentage;
	}

	public void setPercentage(String percentage) {
		this.percentage = percentage;
	}

	public void setTotalTime(Double statustime) {
		BigDecimal temp = new BigDecimal(statustime);
		this.statustime = temp.divide(new BigDecimal(60), 2, BigDecimal.ROUND_HALF_UP).toString();
	}

	public void setper(Double statustime, BigDecimal total) {
		BigDecimal temp = new BigDecimal(statustime);
		this.percentage = temp.multiply(new BigDecimal(100)).divide(total, 2, BigDecimal.ROUND_HALF_UP).toString();
	}
}
