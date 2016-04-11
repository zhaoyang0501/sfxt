package com.pzy.controller;
import java.text.ParseException;
import java.util.Date;
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

import com.pzy.entity.Fee;
import com.pzy.entity.Grade;
import com.pzy.entity.Standard;
import com.pzy.entity.User;
import com.pzy.service.CategoryService;
import com.pzy.service.CodeService;
import com.pzy.service.FeeService;
import com.pzy.service.StandardService;
import com.pzy.service.UserService;
/***分类管理
 * @author panchaoyang
 *qq 263608237
 */
@Controller
@RequestMapping("/admin/fee")
public class FeeController {
	@Autowired
	private FeeService feeService;
	
	@Autowired
	private CodeService codeService;
	@Autowired
	private CategoryService categoryService;
	@Autowired
	private UserService userService;
	@Autowired
	private StandardService standardService;
	@RequestMapping("create")
	public String create(Model model) {
		model.addAttribute("majors",codeService.findAllMajor());
		model.addAttribute("grades",codeService.findAllGrade());
		model.addAttribute("categorys",categoryService.findAll());
      	return "admin/fee/create";
	}
	@RequestMapping("usercreate")
	public String usercreate(Model model) {
		model.addAttribute("majors",codeService.findAllMajor());
		model.addAttribute("grades",codeService.findAllGrade());
		model.addAttribute("categorys",categoryService.findAll());
      	return "admin/fee/usercreate";
	}
	
	@RequestMapping("index")
	public String index(Model model) {
		model.addAttribute("majors",codeService.findAllMajor());
		model.addAttribute("grades",codeService.findAllGrade());
		model.addAttribute("categorys",categoryService.findAll());
      		return "admin/fee/index";
	}
	@RequestMapping("myfee")
	public String myfee(Model model,HttpSession httpSession) {
		User user=(User)httpSession.getAttribute("adminuser");
		model.addAttribute("fees",feeService.find(user));
      	return "admin/fee/myfee";
	}
	
	@RequestMapping("topayfee")
	public String topayfee(Model model,HttpSession httpSession) {
		User user=(User)httpSession.getAttribute("adminuser");
		model.addAttribute("standards",standardService.findByGrade(user.getGrade()));
      	return "admin/fee/topayfee";
	}
	
	@RequestMapping(value = "/list", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> list(
			@RequestParam(value = "sEcho", defaultValue = "1") int sEcho,
			@RequestParam(value = "iDisplayStart", defaultValue = "0") int iDisplayStart,
			@RequestParam(value = "iDisplayLength", defaultValue = "10") int iDisplayLength, String name,
			String year,
			Long grade,
			Long major
			) throws ParseException {
		int pageNumber = (int) (iDisplayStart / iDisplayLength) + 1;
		int pageSize = iDisplayLength;
		Page<User> fees = feeService.findAllFee(pageNumber, pageSize,grade,major, year);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("aaData", fees.getContent());
		map.put("iTotalRecords", fees.getTotalElements());
		map.put("iTotalDisplayRecords", fees.getTotalElements());
		map.put("sEcho", sEcho);
		return map;
	}
	@RequestMapping(value = "/save", method = RequestMethod.POST)
	public String save(Fee fee,Model model) {
		User user=userService.find(fee.getUser().getUsername());
		if(user==null){
			model.addAttribute("state", "success");
			model.addAttribute("tip", "学号不存在");
			return "admin/fee/create";
		}
		
		fee.setUser(user);
		fee.setCreateDate(new Date());
		fee.setState("已缴费");
		feeService.save(fee);
		
		model.addAttribute("state", "success");
		model.addAttribute("tip", "保存成功");
		return "admin/fee/create";
	}
	@RequestMapping(value = "/update")
	@ResponseBody
	public Map<String, Object> update(Fee fee) {
		feeService.save(fee);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("state", "success");
		map.put("msg", "保存成功");
		return map;
	}
	@RequestMapping(value = "/delete/{id}")
	@ResponseBody
	public Map<String, Object> delete(@PathVariable Long id) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			feeService.delete(id);
			map.put("state", "success");
			map.put("msg", "删除成功");
		} catch (Exception e) {
			map.put("state", "error");
			map.put("msg", "删除失败，外键约束");
		}
        return map;
	}

	@RequestMapping(value = "/get/{id}")
	@ResponseBody
	public Map<String, Object> get(@PathVariable Long id ) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("object", feeService.find(id));
		map.put("state", "success");
		map.put("msg", "成功");
		return map;
	}
	@RequestMapping(value = "/getstandard")
	@ResponseBody
	public Map<String, Object> getstandard(Long gid,String year ) {
		Map<String, Object> map = new HashMap<String, Object>();
		Grade grade = codeService.findOne(gid);
		map.put("object", standardService.findByGradeAndYear(grade, year));
		map.put("state", "success");
		map.put("msg", "成功");
		return map;
	}
}
