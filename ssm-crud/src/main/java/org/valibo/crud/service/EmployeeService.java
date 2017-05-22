package org.valibo.crud.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.valibo.crud.bean.Employee;
import org.valibo.crud.bean.EmployeeExample;
import org.valibo.crud.dao.EmployeeMapper;

@Service
public class EmployeeService {

	@Autowired
	EmployeeMapper employeeMapper;
	
	
	/**
	 * 查询所有员工
	 * @return
	 */
	public List<Employee> getAll() {
		return employeeMapper.selectByExampleWithDept(null);
	}


	public void saveEmp(Employee employee) {
		// TODO Auto-generated method stub
		employeeMapper.insertSelective(employee);
	}


	public boolean checkUser(String empName) {
		EmployeeExample ee = new EmployeeExample();
		org.valibo.crud.bean.EmployeeExample.Criteria criteria = ee.createCriteria();
		criteria.andEmpNameEqualTo(empName);
		return employeeMapper.countByExample(ee) == 0;
	}
	
	
	
}
