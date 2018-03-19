package com.hanthink.report.controller;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.hanthink.report.pojo.AdctQueryDomain;
import com.hanthink.report.pojo.AdctResultDomain;
import com.hanthink.report.pojo.ExtendPpPressDTO;
import com.hanthink.report.pojo.PpPressStatus;
import com.hanthink.report.pojo.PpPressStatusDTO;
import com.hanthink.report.pojo.StatusDomain;
import com.hanthink.report.pojo.StopInfoDTO;
import com.hanthink.report.service.BargraphService;
import com.hanthink.report.service.ChartPieService;
import com.hanthink.report.service.SelectAllShowService;
import com.hanthink.report.util.JsonUtil;

@Controller
public class SelectAllShowController {

	@Value("${PROLINE}")
	private String PROLINE;

	@Value("${SHIFT}")
	private String SHIFT;

	@Value("${STARTPRODATE}")
	private String STARTPRODATE;

	@Value("${ENDPRODATE}")
	private String ENDPRODATE;
	
	@Value("${EQUITMENTSTATUS}")
	private String EQUITMENTSTATUS;

	@Autowired
	private SelectAllShowService selectAllShowService;

	@Autowired
	private BargraphService bargraphService;

	@Autowired
	private ChartPieService chartPieService;

	@RequestMapping("/a")
	@ResponseBody
	public ModelAndView selectAllProdate(HttpServletRequest request) {
		HttpSession session = request.getSession();

//		String str = (String) session.getAttribute("proline_");
//		String str1 = (String) session.getAttribute("startday_");

		session.removeAttribute("proline_");
		session.removeAttribute("shift_");
		session.removeAttribute("mould_");
		session.removeAttribute("dayFlag_");
		session.removeAttribute("startday_");
		session.removeAttribute("endday_");

		List<PpPressStatus> proline = selectAllShowService.selectAllProline();
		List<PpPressStatus> proshift = selectAllShowService.selectAllShift();
		List<PpPressStatus> promould = selectAllShowService.selectAllMould();
		List<PpPressStatus> prodate = selectAllShowService.selectAllProdate();

		List<PpPressStatusDTO> dateSelect = new ArrayList<>();
		if (prodate != null && prodate.size() > 0) {
			for (PpPressStatus domain : prodate) {
				dateSelect.add(new PpPressStatusDTO(domain));
			}
		}

		AdctQueryDomain domain = new AdctQueryDomain();
		domain.setEquitmentstatus(EQUITMENTSTATUS);
		domain.setProline(PROLINE);
		List<String> list1 = new ArrayList<>();
		List<String> list2 = new ArrayList<>();
		List<AdctResultDomain> result = bargraphService.getAdctList0(domain);

		for (AdctResultDomain status : result) {
			ExtendPpPressDTO temp = new ExtendPpPressDTO(status);
			list1.add(temp.getComment());
			list2.add(temp.getAdct());
		}

		session.setAttribute("proline", proline);
		session.setAttribute("proshift", proshift);
		session.setAttribute("promould", promould);
		session.setAttribute("prodate", dateSelect);

		session.setAttribute("list1", JsonUtil.list2json(list1));
		session.setAttribute("list2", JsonUtil.list2json(list2));

		ModelAndView m = new ModelAndView();
		m.setViewName("index");
		return m;

	}

	@RequestMapping("/b")
	@ResponseBody
	public ModelAndView show(HttpServletRequest request) {
		HttpSession session = request.getSession();
		StatusDomain domain1 = new StatusDomain();

		List<PpPressStatus> proline = selectAllShowService.selectAllProline();
		List<PpPressStatus> proshift = selectAllShowService.selectAllShift();
		List<PpPressStatus> prodate = selectAllShowService.selectAllProdate();

		List<PpPressStatusDTO> dateSelect = new ArrayList<>();
		if (prodate != null && prodate.size() > 0) {
			for (PpPressStatus domain : prodate) {
				dateSelect.add(new PpPressStatusDTO(domain));
			}
		}

		domain1.setProline(PROLINE);
		domain1.setShift(SHIFT);
		domain1.setStartprodate(STARTPRODATE);
		domain1.setEndprodate(ENDPRODATE);
		List<StatusDomain> statustimeShow = chartPieService.statustimeShow(domain1);
		

		List<String> statustimepercentage3 = new ArrayList<String>();
		List<String> status = new ArrayList<>();
		String equitmentstatus = null;
		List<StopInfoDTO> tableList = new ArrayList<>();

		BigDecimal total = new BigDecimal(0);
		for (StatusDomain statusDomain : statustimeShow) {
			total = total.add(new BigDecimal(statusDomain.getStatustime()));
		}

		for (StatusDomain statusDomain : statustimeShow) {
			StopInfoDTO dto = new StopInfoDTO();
			// 获取列表传输的数据
			dto.setProline(PROLINE);
			dto.setShift(SHIFT);
			dto.setStartprodate(STARTPRODATE);
			dto.setEndprodate(ENDPRODATE);
			dto.setEquitmentstatus(statusDomain.getEquitmentstatus());
			dto.setTotalTime(statusDomain.getStatustime());
			dto.setper(statusDomain.getStatustime(), total);
			tableList.add(dto);

			// 获取各阶段的状态与各自时间
			equitmentstatus = statusDomain.getEquitmentstatus();

			// 各个阶段的状态与时间添加到相应的集合中
			status.add(equitmentstatus);

			statustimepercentage3.add(dto.getPercentage());

		}
		session.setAttribute("proline", proline);
		session.setAttribute("proshift", proshift);
		session.setAttribute("prodate", dateSelect);

		String equitmentstatusDTO = JsonUtil.list2json(status);
		String statustimepercentageDTO = JsonUtil.list2json(statustimepercentage3);
		session.setAttribute("text", equitmentstatusDTO);
		session.setAttribute("number", statustimepercentageDTO);
		session.setAttribute("tableList", tableList);

	

		ModelAndView m = new ModelAndView();
		m.setViewName("index2");
		return m;
	}

	

}
