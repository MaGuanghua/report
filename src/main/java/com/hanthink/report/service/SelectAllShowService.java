package com.hanthink.report.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hanthink.report.mapper.PpPressStatusMapper;
import com.hanthink.report.pojo.PpPressStatus;

@Service
public class SelectAllShowService {

	@Autowired
	private PpPressStatusMapper ppPressStatusMapper;
	
	
	public List<PpPressStatus> selectAllProline(){
			return ppPressStatusMapper.selectAllProline();
	}
	
	public List<PpPressStatus> selectAllShift(){
		return ppPressStatusMapper.selectAllShift();
	}
	
	public List<PpPressStatus> selectAllMould(){
		return ppPressStatusMapper.selectAllMould();
	}
	
	public List<PpPressStatus> selectAllProdate() {
		return ppPressStatusMapper.selectAllProdate();
	}
	
}
