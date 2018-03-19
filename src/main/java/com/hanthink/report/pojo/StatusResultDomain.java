package com.hanthink.report.pojo;

public class StatusResultDomain {

	private String prodate;
	private String proline;
	private String shift;
	private Long totaltime;
	private Long runtime;
	private Long mouldtime;
	private Long stoptime;
	private Long planstoptime;
	private Long unworktime;

	public String getProdate() {
		return prodate;
	}

	public void setProdate(String prodate) {
		this.prodate = prodate;
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

	public Long getTotaltime() {
		return totaltime;
	}

	public void setTotaltime(Long totaltime) {
		this.totaltime = totaltime;
	}

	public Long getRuntime() {
		return runtime;
	}

	public void setRuntime(Long runtime) {
		this.runtime = runtime;
	}

	public Long getMouldtime() {
		return mouldtime;
	}

	public void setMouldtime(Long mouldtime) {
		this.mouldtime = mouldtime;
	}

	public Long getStoptime() {
		return stoptime;
	}

	public void setStoptime(Long stoptime) {
		this.stoptime = stoptime;
	}

	public Long getPlanstoptime() {
		return planstoptime;
	}

	public void setPlanstoptime(Long planstoptime) {
		this.planstoptime = planstoptime;
	}

	public Long getUnworktime() {
		return unworktime;
	}

	public void setUnworktime(Long unworktime) {
		this.unworktime = unworktime;
	}

}
