package org.valibo.crud.test;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.valibo.crud.bean.Employee;
import org.valibo.crud.dao.DepartmentMapper;
import org.valibo.crud.dao.EmployeeMapper;

/**
 * 测试 Mapper
 * 
 * 推荐使用 spring 单元测试
 * 1- 导入 spring-test jar包
 * 2- 注解 ContextConfiguration
 * 3- 直接autowired 要使用的组件就可以了
 * 
 * @author Administrator
 *
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "classpath:applicationContext.xml")
public class MapperTest {
	
	/**
	 *  测试  Department Mapper
	 *  
	 */
	
	@Autowired
	private DepartmentMapper departmentMapper;
	
	@Autowired
	private EmployeeMapper employeeMapper;
	
	
	@Autowired
	SqlSession sqlSession;
	
	@Test
	public void testCRUD(){
		
		//方法一 开始
		//ApplicationContext ioc = new ClassPathXmlApplicationContext("applicationContext.xml");
		
		//DepartmentMapper  departmentMapper = ioc.getBean(DepartmentMapper.class);
		//方法一 结束
		
		System.out.println(departmentMapper);
		// 插入 部门
		//departmentMapper.insertSelective(new Department(null, "人事部"));
		//departmentMapper.insertSelective(new Department(null, "测试部"));
		
		//插入员工
		//employeeMapper.insertSelective(new Employee(null, "孔繁彦", "M", "kfy@126.com", 1));
		//employeeMapper.insertSelective(new Employee(null, "万军", "M", "wj@126.com", 2));
		
		//批量插入   请使用 sqlSession 
		
		EmployeeMapper emMapper = sqlSession.getMapper(EmployeeMapper.class);
		String uuid = "";
		String gender = "M";
		String[] names ={"张三","李四","王五","赵六","朱琪","范冰冰"};
		int dId = 1;
		int len = names.length;
		for (int i = 0; i < 1000; i++) {
			//uuid = UUID.randomUUID().toString().substring(0,5) +""+ i ;
			
			uuid = names[i % len] + i;
			gender = i % 3 == 0 ? "M":"W";
			dId = i % 4  + 1;			
			emMapper.insertSelective(new Employee(null, uuid, gender, uuid+"@126.com", dId));
		}
		System.out.println("批量完成");
		
		
		
	}
}
