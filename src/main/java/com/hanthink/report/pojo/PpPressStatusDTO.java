package com.hanthink.report.pojo;

import java.text.SimpleDateFormat;

public class PpPressStatusDTO {

	private static SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");

	public PpPressStatusDTO() {

	}

	public PpPressStatusDTO(PpPressStatus domain) {
		this.prodate = sf.format(domain.getProdate());

	}

	private String prodate;

	public String getProdate() {
		return prodate;
	}

	public void setProdate(String prodate) {
		this.prodate = prodate;
	}
}