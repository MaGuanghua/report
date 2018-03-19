package com.hanthink.report.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hanthink.report.mapper.StatusShowMapper;
import com.hanthink.report.pojo.StatusDomain;

@Service
public class ChartPieService {

	@Autowired
	private StatusShowMapper statusShowMapper;

	public List<StatusDomain> statustimeShow(StatusDomain domain) {
		return statusShowMapper.statustimeShow(domain);
	}

}
