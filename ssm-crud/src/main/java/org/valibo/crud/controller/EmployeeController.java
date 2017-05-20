package org.valibo.crud.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.valibo.crud.bean.Employee;
import org.valibo.crud.service.EmployeeService;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

/** 
 * 员工
 * @author Administrator
 *
 */
@Controller
public class EmployeeController {
	
	@Autowired
	EmployeeService employeeService;
	
	
	@RequestMapping("/emps")
	public String getEmps(@RequestParam(value="pn" ,defaultValue="1" ) Integer pn,Model model){
		//这不是一个分页查询
		PageHelper.startPage(pn, 10);
		List<Employee> emps = employeeService.getAll();
		PageInfo page = new PageInfo(emps);
		model.addAttribute(page);
		return "list";
	}
}
