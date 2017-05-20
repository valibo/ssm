package org.valibo.crud.test;

import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MockMvcBuilder;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;
import org.valibo.crud.bean.Employee;

import com.github.pagehelper.PageInfo;

/**
 * 测试 Controller 
 * 
 * @author Administrator
 *
 */
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations ={ "classpath:applicationContext.xml","classpath:springmvc.xml"})
public class MvcTest {
	
	@Autowired
	WebApplicationContext context ;
	
	MockMvc mockmvc ;
	
	@Before
	public void initMockMvc(){
		System.out.println(123);
		mockmvc = MockMvcBuilders.webAppContextSetup(context).build();
	}
	
	@Test
	public void testPage() throws Exception{
		MvcResult result = mockmvc.perform(MockMvcRequestBuilders.get("/emps").param("pn", "1")).andReturn();
		MockHttpServletRequest request = result.getRequest();
		PageInfo pi = (PageInfo) request.getAttribute("pageInfo");
		System.out.println();
		System.out.println("pi.getPageNum():"+ pi.getPageNum());
		System.out.println("pi.getPageSize():"+pi.getPageSize());
		System.out.println("pi.getStartRow():"+pi.getStartRow());
		System.out.println("pi.getEndRow():"+ pi.getEndRow());
		System.out.println("pi.getTotal():"+ pi.getTotal());
		System.out.println("pi.getPages():"+ pi.getPages());
		System.out.println("pi.isHasNextPage():"+pi.isHasNextPage());
		System.out.println("pi.isHasPreviousPage():"+pi.isHasPreviousPage());
		System.out.println(pi.isIsFirstPage());
		System.out.println(pi.isIsLastPage());
		int[] numbers = pi.getNavigatepageNums();
		for (int i : numbers) {
			System.out.print(" "+i);
		}
		
		
		List<Employee> list = pi.getList();
		for (Employee e : list) {
			System.out.println("id : "+e.getEmpId()+",name: "+e.getEmpName()+", department:"+e.getDepartment().getDeptName());
		}
	}
	
}
