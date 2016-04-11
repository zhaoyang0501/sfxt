package com.pzy.controller;
import java.text.ParseException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pzy.entity.Report;
import com.pzy.entity.User;
import com.pzy.entity.Work;
import com.pzy.service.ReportService;
import com.pzy.service.WorkService;

/***评估管理
 * @author panchaoyang
 * qq:263608237
 */
@Controller
@RequestMapping("/admin/report")
public class ReportController {
	@Autowired
	private ReportService reportService;
	
	@Autowired
	private WorkService workService;
	
	
	@RequestMapping("create")
	public String create(Model model,Long id) {
		model.addAttribute("work",workService.find(id));
		return "admin/report/create";
	}
	@RequestMapping("index")
	public String index(Model model ) {
		model.addAttribute("todo",workService.findTodo());
		model.addAttribute("done",workService.findDone());
		return "admin/report/index";
	}
	@RequestMapping("myreport")
	public String myreport(Model model ) {
		model.addAttribute("todo",workService.findTodo());
		model.addAttribute("done",workService.findDone());
		return "admin/report/index";
	}
	@RequestMapping(value = "/save", method = RequestMethod.POST)
	public String save(Report report,Model model,HttpSession httpSession) {
		User user=(User)httpSession.getAttribute("adminuser");
		Work work=workService.find(report.getWork().getId());
		report.setWork(work);
		report.setUser(user);
		reportService.save(report);
		if("待考评".equals(work.getState()))
			work.setState("已有一人考评");
		else if("已有一人考评".equals(work.getState()))
			work.setState("考评结束");
		workService.save(work);
		
		
		model.addAttribute("tip","考评成功");
		model.addAttribute("todo",workService.findTodo());
		model.addAttribute("done",workService.findDone());
		return "admin/report/index";
	}
	
	@RequestMapping(value = "/list", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> list(
			@RequestParam(value = "sEcho", defaultValue = "1") int sEcho,
			@RequestParam(value = "iDisplayStart", defaultValue = "0") int iDisplayStart,
			@RequestParam(value = "iDisplayLength", defaultValue = "10") int iDisplayLength, String name
			) throws ParseException {
		int pageNumber = (int) (iDisplayStart / iDisplayLength) + 1;
		int pageSize = iDisplayLength;
		Page<Report> users = reportService.findAll(pageNumber, pageSize, name);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("aaData", users.getContent());
		map.put("iTotalRecords", users.getTotalElements());
		map.put("iTotalDisplayRecords", users.getTotalElements());
		map.put("sEcho", sEcho);
		return map;
	}
	@RequestMapping(value = "/delete/{id}")
	@ResponseBody
	public Map<String, Object> delete(@PathVariable Long id) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			reportService.delete(id);
			map.put("state", "success");
			map.put("msg", "删除成功");
		} catch (Exception e) {
			map.put("state", "error");
			map.put("msg", "删除失败，外键约束");
		}
        return map;
	}
}
