package com.hanthink.report.pojo;

import java.math.BigDecimal;

public class ExtendPpPressDTO {

	public ExtendPpPressDTO() {

	}

	public ExtendPpPressDTO(AdctResultDomain domain) {
		BigDecimal num = new BigDecimal(domain.getTotaltime());
		BigDecimal counter = new BigDecimal(domain.getCounter());

		BigDecimal totalBig = num.divide(counter, 5, BigDecimal.ROUND_HALF_UP).divide(new BigDecimal(60), 5,
				BigDecimal.ROUND_HALF_UP);
		String totalStr = totalBig.setScale(2, BigDecimal.ROUND_HALF_UP).toString();
		StringBuilder sb = new StringBuilder();

		sb.append(domain.getDateYmd());
		if (domain.getMould() != null) {
			sb.append(".").append(domain.getMould());
		}
		if (domain.getShift() != null) {
			sb.append(".").append(domain.getShift());
		}
		if (domain.getProline() != null) {
			sb.append(".").append(domain.getProline());
		}
		adct = totalStr;

		comment = sb.toString();
	}

	private String adct;
	private String comment;

	public String getAdct() {
		return adct;
	}

	public void setAdct(String adct) {
		this.adct = adct;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

}
