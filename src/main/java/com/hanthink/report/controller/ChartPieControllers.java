package com.hanthink.report.controller;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.hanthink.report.pojo.StatusDomain;
import com.hanthink.report.pojo.StopInfoDTO;
import com.hanthink.report.service.ChartPieService;
import com.hanthink.report.util.JsonUtil;

@Controller
public class ChartPieControllers {
	@Autowired
	private ChartPieService chartPieService;

	@RequestMapping(value = "/piechart")
	@ResponseBody
	public ModelAndView getAdctList(HttpServletRequest request) throws Exception {

		HttpSession session = request.getSession();
		String proline = request.getParameter("proline");
		String shift = request.getParameter("shift");
		String startprodate = request.getParameter("startprodate");
		String endprodate = request.getParameter("endprodate");

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date1 = sdf.parse(startprodate);
		Date date2 = sdf.parse(endprodate);
		int size = date1.compareTo(date2);
		if (size > 0) {
			return new ModelAndView("jump1");
		}

		StatusDomain domain = new StatusDomain();

		if (!"请选择".equals(proline) && !"".equals(proline)) {
			domain.setProline(proline);
			session.setAttribute("proline_", proline);
		} else {
			session.removeAttribute("proline_");
		}

		if (!"请选择".equals(shift) && !"".equals(shift)) {
			domain.setShift(shift);
			session.setAttribute("shift_", shift);
		} else {
			session.removeAttribute("shift_");
		}

		if (!"请选择".equals(startprodate) && !"".equals(startprodate)) {
			domain.setStartprodate(startprodate);
			session.setAttribute("startday_", startprodate);
		} else {
			session.removeAttribute("startday_");
		}

		if (!"请选择".equals(endprodate) && !"".equals(endprodate)) {
			domain.setEndprodate(endprodate);
			session.setAttribute("endday_", endprodate);
		} else {
			session.removeAttribute("endday_");
		}

		String equitmentstatus = null;

		List<String> statustimepercentage = new ArrayList<String>();

		List<StatusDomain> statustimeShow = chartPieService.statustimeShow(domain);

		List<String> status = new ArrayList<>();

		List<StopInfoDTO> tableList = new ArrayList<>();

		BigDecimal total = new BigDecimal(0);
		for (StatusDomain statusDomain : statustimeShow) {
			total = total.add(new BigDecimal(statusDomain.getStatustime()));
		}

		for (StatusDomain statusDomain : statustimeShow) {
			StopInfoDTO dto = new StopInfoDTO();
			// 获取列表传输的数据
			dto.setProline(proline);
			dto.setShift(shift);
			dto.setStartprodate(startprodate);
			dto.setEndprodate(endprodate);
			dto.setEquitmentstatus(statusDomain.getEquitmentstatus());
			dto.setTotalTime(statusDomain.getStatustime());
			dto.setper(statusDomain.getStatustime(), total);
			tableList.add(dto);

			// 获取各阶段的状态与各自时间
			equitmentstatus = statusDomain.getEquitmentstatus();

			// 各个阶段的状态与时间添加到相应的集合中
			status.add(equitmentstatus);

			statustimepercentage.add(dto.getPercentage());

		}

		String equitmentstatusDTO = JsonUtil.list2json(status);
		String statustimepercentageDTO = JsonUtil.list2json(statustimepercentage);
		session.setAttribute("text", equitmentstatusDTO);
		session.setAttribute("number", statustimepercentageDTO);

		session.setAttribute("tableList", tableList);

		ModelAndView m = new ModelAndView();
		m.setViewName("index2");
		return m;
	}

}
