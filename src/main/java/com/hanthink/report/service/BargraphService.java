package com.hanthink.report.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hanthink.report.mapper.PpPressStatusMapper;
import com.hanthink.report.pojo.AdctQueryDomain;
import com.hanthink.report.pojo.AdctResultDomain;

@Service
public class BargraphService {

	@Autowired
	private PpPressStatusMapper ppPressStatusMapper;

	public List<AdctResultDomain> getAdctList(AdctQueryDomain domain){
		return ppPressStatusMapper.getAdctList(domain);
		
	}
	
	public List<AdctResultDomain> getAdctList0(AdctQueryDomain domain){
		return ppPressStatusMapper.getAdctList0(domain);
	}

}
