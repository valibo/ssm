package org.valibo.crud.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.valibo.crud.bean.Employee;
import org.valibo.crud.bean.Msg;
import org.valibo.crud.service.EmployeeService;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

/**
 * 员工
 * 
 * @author Administrator
 *
 */
@Controller
public class EmployeeController {

	@Autowired
	EmployeeService employeeService;

	@RequestMapping("/emps")
	public String getEmps(@RequestParam(value = "pn", defaultValue = "1") Integer pn, Model model) {
		// 这不是一个分页查询
		PageHelper.startPage(pn, 10);
		List<Employee> emps = employeeService.getAll();
		PageInfo page = new PageInfo(emps);
		model.addAttribute(page);
		return "list";
	}

	@ResponseBody
	@RequestMapping("/empsJson")
	public Msg getJsonEmps(@RequestParam(value = "pn", defaultValue = "1") Integer pn, Model model) {
		PageHelper.startPage(pn, 10);
		List<Employee> emps = employeeService.getAll();
		PageInfo page = new PageInfo(emps);
		return Msg.success().add("pageInfo", page);
	}

	@ResponseBody
	@RequestMapping(value = "emp", method = RequestMethod.POST)

	/*
	 * 普通方式的时候是 public Msg saveEmp(Employee employee){ 加入了 hibernate-validator
	 * 之后
	 * 
	 * 
	 */
	public Msg saveEmp(@Valid Employee employee, BindingResult bindingResult) {
		if (bindingResult.hasErrors()) {
			Map<String, Object> errmap = new HashMap<String, Object>();
			List<FieldError> errors = bindingResult.getFieldErrors();
			for (FieldError fieldError : errors) {
				errmap.put(fieldError.getField(), fieldError.getDefaultMessage());
			}
			return Msg.fail("保存失败").add("errorFields", errmap);
		} else {
			employeeService.saveEmp(employee);
			return Msg.success();
		}

	}

	@ResponseBody
	@RequestMapping("/checkUser")
	public Msg checkUser(@RequestParam("empName") String empName) {
		if (empName == null || "".equals(empName.trim())) {
			return Msg.fail("用户名为空");
		}
		String regex = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})";
		if (!empName.matches(regex)) {
			return Msg.fail("用户名必须为 2-5位汉字,6-16位 字母");
		}

		boolean b = employeeService.checkUser(empName);
		if (b) {
			return Msg.success("用户名可用");
		} else {
			return Msg.fail("用户名不可用");
		}

	}
	
	
	/*
	 * 查询员工
	 * 
	 * */
	@ResponseBody
	@RequestMapping(value = "/emp/{id}", method = RequestMethod.GET)
	public Msg getEmp(@PathVariable("id")Integer empId){
		Employee employee = employeeService.getEmp(empId);
		return Msg.success("ok").add("emp", employee);
	}
	
	/**
	 * 员工更新方法
	 * @param employee
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/emp/{empId}", method = RequestMethod.PUT)
	public Msg updateEmp(Employee employee){
		int cc = employeeService.updateEmp(employee);
		return Msg.success("ok").add("cc", cc);
	}
	/*
	@ResponseBody
	@RequestMapping(value = "/emp/{id}", method = RequestMethod.DELETE)
	public Msg delEmp(@PathVariable("id")Integer empId){
		int cc = employeeService.deleteEmp(empId);
		return Msg.success("ok").add("cc", cc);
	}*/
	
	/**
	 * 删除全部   
	 * 
	 * @param ids
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/emp/{ids}", method = RequestMethod.DELETE)
	public Msg delBatch(@PathVariable("ids")String ids){
		String splitstr ="-";
		if(ids.contains(splitstr)){
			List<Integer> idlist = new ArrayList<Integer>();
			for (String id : ids.split(splitstr)) {
				idlist.add(Integer.valueOf(id));
			}
			if(idlist.size() > 0){
				employeeService.deleteBatch(idlist);
			}
			return Msg.success("处理成功");
		}else{
			int cc = employeeService.deleteEmp(Integer.valueOf(ids));
			return Msg.success("处理成功").add("cc", cc);
		}
		
		
		
	}
}
