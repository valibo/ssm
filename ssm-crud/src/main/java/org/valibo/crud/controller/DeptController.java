package org.valibo.crud.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.valibo.crud.bean.Department;
import org.valibo.crud.bean.Msg;
import org.valibo.crud.service.DepartmentService;

/**
 * 
 * 处理部门相关
 * @author Administrator
 *
 */
@Controller
public class DeptController {
	
	@Autowired
	private DepartmentService departmentService;
	

	@ResponseBody
	@RequestMapping("deptsJson")
	public Msg deptsJson(){
		List<Department> depts = departmentService.getDepts();
		return Msg.success().add("depts", depts);
	}

}
