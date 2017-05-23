package org.valibo.crud.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.valibo.crud.bean.Employee;
import org.valibo.crud.bean.EmployeeExample;
import org.valibo.crud.bean.EmployeeExample.Criteria;
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


	/**
	 * 查询 根据 id 查找 员工
	 * @param id
	 * @return
	 */
	public Employee getEmp(Integer empId) {
		return employeeMapper.selectByPrimaryKey(empId);
	}


	public int updateEmp(Employee employee) {
		return employeeMapper.updateByPrimaryKeySelective(employee);
	}


	public int deleteEmp(Integer empId) {
		return employeeMapper.deleteByPrimaryKey(empId);
	}


	/**
	 * 批量删除
	 * 
	 * @param idlist
	 */
	public void deleteBatch(List<Integer> idlist) {
		EmployeeExample example = new EmployeeExample();
		Criteria criteria = example.createCriteria();
		criteria.andEmpIdIn(idlist);
		employeeMapper.deleteByExample(example);
	}
	
	
	
}
