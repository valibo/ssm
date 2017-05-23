<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>员工列表</title>
<link
	href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
	rel="stylesheet">
</head>
<body>
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<h1>SSM</h1>
			</div>
		</div>
		<!-- 按钮 -->
		<div class="row">
			<div class="col-md-4 col-md-offset-8">
				<button type="button" class="btn btn-primary">新增</button>
				<button type="button" class="btn btn-danger">删除</button>
			</div>
		</div>
		<!-- 表格数据 -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover">
					<thead>
						<tr>
							<th>#</th>
							<th>name</th>
							<th>gender</th>
							<th>email</th>
							<th>departname</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${pageInfo.list}" var="emp">
							<tr>
								<td>${emp.empId}</td>
								<td>${emp.empName}</td>
								<td>${emp.gender=="M"?"男":"女"}</td>
								<td>${emp.email}</td>
								<td>${emp.department.deptName}</td>
								<td>
									<button type="button" class="btn btn-primary btn-xs">
										<span class="glyphicon glyphicon-star" aria-hidden="true"></span>
										新增
									</button>
									<button type="button" class="btn btn-danger btn-xs">
										<span class="glyphicon glyphicon-star" aria-hidden="true"></span>
										删除
									</button>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
		<!--  显示分页  -->
		<div class="row">
			<div class="col-md-6">当前 ${pageInfo.pageNum } 页,总
				${pageInfo.pages } 页 ,共 ${pageInfo.total } 条记录</div>
			<div class="col-md-6">
				<nav aria-label="Page navigation">
				<ul class="pagination">
					<c:if test="${pageInfo.hasPreviousPage}">
						<li><a href="${APP_PATH}/emps?pn=1" aria-label="Next"> <span
								aria-hidden="true">首页</span>
						</a></li>
						<li><a href="${APP_PATH}/emps?pn=${pageInfo.pageNum -1}" aria-label="Previous"> <span
								aria-hidden="true">&laquo;</span>
						</a></li>
					</c:if>
					<c:forEach items="${pageInfo.navigatepageNums}" var="page_num">
						<c:if test="${page_num == pageInfo.pageNum}">
							<li class="active"><a href="#">${page_num}</a></li>
						</c:if>
						<c:if test="${page_num != pageInfo.pageNum}">
							<li><a href="${APP_PATH}/emps?pn=${page_num}">${page_num}</a></li>
						</c:if>
					</c:forEach>
					<c:if test="${pageInfo.hasNextPage}">
						<li><a href="${APP_PATH}/emps?pn=${pageInfo.pageNum+ 1}" aria-label="Next"> <span
								aria-hidden="true">&raquo;</span>
						</a></li>
						<li><a href="${APP_PATH}/emps?pn=${pageInfo.pages}" aria-label="Next"> <span
							aria-hidden="true">末页</span>
						</a></li>
					</c:if>
					
				</ul>
				</nav>
			</div>
		</div>
		<div class="row"></div>
	</div>














	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script src="${APP_PATH}/static/jquery/1.12.4/jquery.min.js"></script>
	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script
		src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</body>
</html>