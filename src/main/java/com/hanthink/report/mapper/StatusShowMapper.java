package com.hanthink.report.mapper;

import java.util.List;

import com.hanthink.report.pojo.StatusDomain;
import com.hanthink.report.pojo.StatusQueryDomain;
import com.hanthink.report.pojo.StatusResultDomain;

public interface StatusShowMapper {

	// 选择状态时间
	List<StatusDomain> statustimeShow(StatusDomain domain);

	// 默认状态
	List<StatusDomain> defaultstatustimeShow();

}