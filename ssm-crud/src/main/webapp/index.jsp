<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
<title>SSM</title>

<!-- Bootstrap -->

<link href="static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
	rel="stylesheet">

<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
      <script src="https://cdn.bootcss.com/html5shiv/3.7.3/html5shiv.min.js"></script>
      <script src="https://cdn.bootcss.com/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body>

	<!--  -->
	<div class="modal fade" tabindex="-1" role="dialog"
		aria-labelledby="gridSystemModalLabel" id="empAddModal">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="gridSystemModalLabel">员工添加</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal" id="empAddForm">
						<div class="form-group">
							<label class="col-sm-2 control-label">empName</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" name="empName"
									id="empName" placeholder="empName">
								<span id="empNameHelpBlock" class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">Email</label>
							<div class="col-sm-10">
								<input type="email" class="form-control" name="email" id="email"
									placeholder="Email">
								<span id="emailNameHelpBlock" class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">gender</label>
							<div class="col-sm-10">
								<label class="radio-inline"> <input type="radio"
									name="gender" id="gender1" value="M" checked="checked">
									男
								</label> <label class="radio-inline"> <input type="radio"
									name="gender"  value="W"> 女 
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">deptName</label>
							<div class="col-sm-4">
								<select class="form-control" id="deptSelect" name="dId"></select>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="emp_save">保存</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal-dialog -->
	</div>
	<!-- /.modal -->

	<!-- 页面主要内容 -->
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<h1>SSM</h1>
			</div>
		</div>
		<!-- 按钮 -->
		<div class="row">
			<div class="col-md-4 col-md-offset-8">
				<button type="button" class="btn btn-primary" id="emp_add_modal_btn">新增</button>
				<button type="button" class="btn btn-danger">删除</button>
			</div>
		</div>
		<!-- 表格数据 -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover" id="empsTable">
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
			<div class="col-md-6" id="pageInfoPanel"></div>
			<div class="col-md-6" id="pageInfoNavPanel"></div>
		</div>
		<div class="row"></div>
	</div>
	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script src="${APP_PATH}/static/jquery/1.12.4/jquery.min.js"></script>
	<!-- Include all compiled plugins (below), or include individual files as needed -->
	<script
		src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>


	<script type="text/javascript">
		//员工表格
		function build_emps_table(result) {
			$('#empsTable > tbody').empty();
			var emps = result.map.pageInfo.list;
			$.each(emps, function(index, item) {
				var empIdTd = $('<td></td>').append(item.empId);
				var empNameTd = $('<td></td>').append(item.empName);
				var emailTd = $('<td></td>').append(item.email);
				var departNameTd = $('<td></td>').append(
						item.department.deptName);
				//empId: 1, empName: "李波", gender: "1", email: "valibo@163.com", dId: 1,…
				var genderTd = $('<td></td>').append(
						item.gender == 'M' ? "男" : "女");

				/*
				<button type="button" class="btn btn-primary btn-xs">
											<span class="glyphicon glyphicon-star" aria-hidden="true"></span>
											新增
										</button>
										<button type="button" class="btn btn-danger btn-xs">
											<span class="glyphicon glyphicon-star" aria-hidden="true"></span>
											删除
										</button>
				 */
				var editBtn = $('<button></button>').addClass(
						'btn btn-primary btn-xs').append(
						$('<span></span>').addClass(
								'glyphicon glyphicon-pencil')).append(' 编辑');
				var delBtn = $('<button></button>').addClass(
						'btn btn-danger btn-xs').append(
						$('<span></span>')
								.addClass('glyphicon glyphicon-trash')).append(
						' 删除');

				var btnTd = $('<td></td>').append(editBtn).append(' ').append(
						delBtn);

				$('<tr></tr>').append(empIdTd).append(empNameTd).append(
						genderTd).append(emailTd).append(departNameTd).append(
						btnTd).appendTo($('#empsTable > tbody'));
			});

		}

		//解析分页信息
		function build_page_info(result) {
			var $pageInfoPanel = $('#pageInfoPanel');
			var pageInfo = result.map.pageInfo;
			var msg = '当前 ' + pageInfo.pageNum + '页,总' + pageInfo.pages
					+ '页 ,共 ' + pageInfo.total + ' 条记录';
			$('#pageInfoPanel').html(msg);
			maxpagenum =  pageInfo.total;

		}
		// 解析分页条
		function build_page_nav(result) {
			//#pageInfoNavPanel
			$('#pageInfoNavPanel').empty();
			var ul = $('<ul></ul>').addClass('pagination');
			var pageInfo = result.map.pageInfo;
			var firstLi = $('<li></li>').append(
					$('<a></a>').append('首页').attr('href', 'javascript:;'));
			var prePageLi = $('<li></li>')
					.append(
							$('<a></a>').append('&laquo;').attr('href',
									'javascript:;'));
			if (pageInfo.hasPreviousPage == false) {
				firstLi.addClass('disabled');
				prePageLi.addClass('disabled');
			} else {
				firstLi.click(function() {
					to_page(1);
				});
				prePageLi.click(function() {
					to_page(pageInfo.pageNum - 1);
				});

			}

			ul.append(firstLi).append(prePageLi);

			var nextPageLi = $('<li></li>')
					.append(
							$('<a></a>').append('&raquo;').attr('href',
									'javascript:;'));
			var lastLi = $('<li></li>').append(
					$('<a></a>').append('末页').attr('href', 'javascript:;'));
			if (pageInfo.hasNextPage == false) {
				nextPageLi.addClass('disabled');
				lastLi.addClass('disabled');
			} else {

				nextPageLi.click(function() {
					to_page(pageInfo.pageNum + 1);
				});
				lastLi.click(function() {
					to_page(pageInfo.pages);
				});
			}
			

			$.each(pageInfo.navigatepageNums,
					function(index, item) {
						var numLi = $('<li></li>').append(
								$('<a></a>').append(item).attr('href',
										'javascript:;'));
						if (pageInfo.pageNum == item) {
							numLi.addClass('active');
						}
						numLi.click(function() {
							to_page(item);
						});
						ul.append(numLi);
					});

			ul.append(nextPageLi).append(lastLi);

			var navEle = $('<nav></nav>').attr('aria-label', 'Page navigation');
			navEle.append(ul).appendTo('#pageInfoNavPanel');

		}

		function to_page(pn) {
			$.ajax({
				url : "${APP_PATH}/empsJson",
				data : "pn=" + pn,
				type : "get",
				success : function(result) {
					build_emps_table(result);
					build_page_info(result);
					build_page_nav(result);
				}
			});
		}

		
		//查询部门
		function getDepts(){
			$.ajax({
				url : "${APP_PATH}/deptsJson",
				type : "get",
				success : function(result) {
					if(result ){
						if(result.code == 100){
							var depts = result.map.depts;
							$('#deptSelect').empty();
							$.each(depts,function(index,item){
								//$('#deptSelect').append($('<option value="' +  item.deptId + '">'+ item.deptName+'</option>'));
								
								$('<option></option>').append(item.deptName).attr('value',item.deptId).appendTo($('#deptSelect'));
							});
							$('#empAddModal').modal({
								"backdrop" : "static"
							});
						}else{
							alert(result.msg);
						}
					}else{
						alert('通讯失败');
					}
				}
			});
		}
		
		
		//数据验证
		function show_validate_msg(ele,status,msg){
			ele.parent().removeClass('has-success has-error');
			ele.next('.help-block').text('');
			if("success" == status){
				ele.parent().addClass('has-success');
				ele.next('.help-block').text('');
			}else if("error" == status){
				ele.parent().addClass('has-error');
				ele.next('.help-block').text(msg);
			}
			
		}
		
		//表单重置
		function reset_form(ele){
			$(ele)[0].reset();
			$(ele).find('*').removeClass('has-success has-error');
			$(ele).find('.help-block').text('');
			$('#emp_save').data('ajaxEmpName','false');
		}
		var maxpagenum = 99999999;
		
		$(function() {
			to_page(1);
			$('#emp_add_modal_btn').click(function() {
				//重置表单
				reset_form($('#empAddForm'));
				getDepts();
			});
			
			$('#empName').change(function(){
				var ele = $(this);
				$.ajax({
					url : "${APP_PATH}/checkUser",
					data : "empName=" + $(this).val(),
					type : "POST",
					success : function(result) {
						if(result.code == 100){
							show_validate_msg( ele,'success','');
							$('#emp_save').data('ajaxEmpName','true');
						}else{
							show_validate_msg( ele,'error',result.msg);
							$('#emp_save').data('ajaxEmpName','false');
						}
					}
				});
				
			});
			
			
			
			$('#emp_save').click(function(){
				var formData = $('#empAddForm').serialize();
				var empName = $('#empName');
				var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
				/*
				if(!regName.test(empName.val())){
				//alert('用户名可以为 2-5位汉字,6-16位 字母');
				//empName.parent().addClass('has-error');
				//$('#empNameHelpBlock').text('用户名可以为 2-5位汉字,6-16位 字母');
				show_validate_msg(empName,'error','用户名可以为 2-5位汉字,6-16位 字母');
				return false;
			}else{
				show_validate_msg(empName,'success','');
			}
			
			
			var emailval = $('#email').val();
			if(!('true' == $(this).data('ajaxEmpName'))){
				show_validate_msg(empName,'error','用户名校验没通过');
				return false;
			}
				
				*/
				
				$.ajax({
					url : "${APP_PATH}/emp",
					data : formData,
					type : "POST",
					success : function(result) {
						if(result.code == 100){
							alert('ok');
							$('#empAddModal').modal('hide');
							to_page(maxpagenum);
						}else{
							//显示失败信息
							console.log(result);
							var errorFields = result.map.errorFields;
							if(undefined != errorFields.empName){
								show_validate_msg(empName,'error',errorFields.empName);
							}
						}
					}
				});
			
			});
		});
	</script>


</body>
</html>