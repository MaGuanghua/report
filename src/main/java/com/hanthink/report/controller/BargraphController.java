package com.hanthink.report.controller;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.druid.support.json.JSONUtils;
import com.hanthink.report.pojo.AdctQueryDomain;
import com.hanthink.report.pojo.AdctResultDomain;
import com.hanthink.report.pojo.ExtendPpPressDTO;
import com.hanthink.report.service.BargraphService;
import com.hanthink.report.service.SelectAllShowService;
import com.hanthink.report.util.JsonUtil;

@Controller
public class BargraphController {

	@Value("${EQUITMENTSTATUS}")
	private String EQUITMENTSTATUS;

	@Autowired
	private BargraphService bargraphService;

	@RequestMapping(value = "/day")
	@ResponseBody
	public ModelAndView getAdctList(HttpServletRequest request, HttpServletResponse response)
			throws ParseException, IOException {
		HttpSession session = request.getSession();

		String proline = request.getParameter("proline");
		String shift = request.getParameter("shift");
		String mould = request.getParameter("mould");
		String daytype = request.getParameter("daytype");
		String dayFlag = null;
		if ("月".equals(daytype)) {
			dayFlag = "1";
		}
		String startday = request.getParameter("startday");
		String endday = request.getParameter("endday");
		if (startday.equals("s1")) {

			return new ModelAndView("jump");
		}
		if (endday.equals("s2")) {
			return new ModelAndView("jump");
		}

		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		
		 Date date1 = sdf.parse(startday);
		 Date date2 = sdf.parse(endday);
		 int size = date1.compareTo(date2);
		
		 if (size > 0) {
			 return new ModelAndView("jump");
		 } 

		AdctQueryDomain domain = new AdctQueryDomain();
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

		if (!"请选择".equals(mould) && !"".equals(mould)) {
			domain.setMould(mould);
			session.setAttribute("mould_", mould);
		} else {
			session.removeAttribute("mould_");
		}

		if (!"请选择".equals(daytype) && !"".equals(daytype)) {
			domain.setDayFlag(dayFlag);
			session.setAttribute("daytype_", daytype);
		} else {
			session.removeAttribute("daytype_");
		}

		if (!"请选择".equals(startday) && !"".equals(startday)) {
			domain.setDay(startday);
			session.setAttribute("startday_", startday);
		} else {
			session.removeAttribute("startday_");
		}

		if (!"请选择".equals(endday) && !"".equals(endday)) {
			domain.setEndday(endday);
			session.setAttribute("endday_", endday);
		} else {
			session.removeAttribute("endday_");
		}
		domain.setEquitmentstatus(EQUITMENTSTATUS);

		List<AdctResultDomain> result = bargraphService.getAdctList(domain);

		List<String> list1 = new ArrayList<>();
		List<String> list2 = new ArrayList<>();

		for (AdctResultDomain status : result) {
			ExtendPpPressDTO temp = new ExtendPpPressDTO(status);

			list1.add(temp.getComment());
			list2.add(temp.getAdct());
		}

		String list11 = JsonUtil.list2json(list1);
		String list12 = JsonUtil.list2json(list2);

		session.setAttribute("list1", list11);

		session.setAttribute("list2", list12);

		ModelAndView m = new ModelAndView();
		m.setViewName("index");
		return m;
	}

}
