package com.hanthink.report.mapper;

import java.util.List;

import com.hanthink.report.pojo.AdctQueryDomain;
import com.hanthink.report.pojo.AdctResultDomain;
import com.hanthink.report.pojo.PpPressStatus;

public interface PpPressStatusMapper {

	//下拉框显示的值
	List<PpPressStatus> selectAllProline();

	List<PpPressStatus> selectAllShift();

	List<PpPressStatus> selectAllMould();

	List<PpPressStatus> selectAllProdate();


	//柱状图显示的值
	List<AdctResultDomain> getAdctList(AdctQueryDomain domain);
	List<AdctResultDomain> getAdctList0(AdctQueryDomain domain);
}