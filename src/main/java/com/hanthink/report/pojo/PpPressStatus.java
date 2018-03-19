package com.hanthink.report.pojo;

import java.util.Date;

public class PpPressStatus {
	private Integer statusid;

	private Date prodate;

	private String proline;

	private String shift;

	private String equitmentstatus;

	private String mould;

	private Date starttime;

	private Date endtime;

	public Integer getStatusid() {
		return statusid;
	}

	public void setStatusid(Integer statusid) {
		this.statusid = statusid;
	}

	public Date getProdate() {
		return prodate;
	}

	public void setProdate(Date prodate) {
		this.prodate = prodate;
	}

	public String getProline() {
		return proline;
	}

	public void setProline(String proline) {
		this.proline = proline == null ? null : proline.trim();
	}

	public String getShift() {
		return shift;
	}

	public void setShift(String shift) {
		this.shift = shift == null ? null : shift.trim();
	}

	public String getEquitmentstatus() {
		return equitmentstatus;
	}

	public void setEquitmentstatus(String equitmentstatus) {
		this.equitmentstatus = equitmentstatus == null ? null : equitmentstatus.trim();
	}

	public String getMould() {
		return mould;
	}

	public void setMould(String mould) {
		this.mould = mould == null ? null : mould.trim();
	}

	public Date getStarttime() {
		return starttime;
	}

	public void setStarttime(Date starttime) {
		this.starttime = starttime;
	}

	public Date getEndtime() {
		return endtime;
	}

	public void setEndtime(Date endtime) {
		this.endtime = endtime;
	}
}