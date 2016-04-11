<!DOCTYPE html>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html lang="ch">
<%@ include file="../common/meta.jsp"%>
<head>
<script type="text/javascript" src="${pageContext.request.contextPath}/admin/js/ace/admin.work.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/admin/js/falgun/bootbox.js"></script>
<script src="${pageContext.request.contextPath}/admin/js/falgun/bootstrap-datetimepicker.min.js"></script>
<script src="${pageContext.request.contextPath}/admin/js/falgun/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		$(".date").datetimepicker({
			language:  'zh-CN',
	        weekStart: 1,
	        todayBtn:  1,
	        format:'yyyy-mm-dd',
			autoclose: 1,
			todayHighlight: 1,
			startView: 2,
			minView: 2,
			forceParse: 0
	    });
	});
</script>
</head>
<body>
	<div class="layout">
		<!-- top -->
		<%@ include file="../top.jsp"%>
		<!-- 导航 -->
		<%@ include file="../menu.jsp"%>
		
		<input type="hidden" id="hf_id" />

		<div class="main-wrapper">
			<div class="container-fluid">
				<div class="row-fluid ">
					<div class="span12">
						<div class="content-widgets ">
							<div class="widget-head  bondi-blue" >
								<h3>评价管理</h3>
							</div>
						
							<div class="row-fluid ">	
							<ul class="nav nav-tabs" id="myTab">
								  <li class="active"><a href="#home">待考评</a></li>
								  <li><a href="#profile">已考评</a></li>
							</ul>
		 
								<div class="tab-content">
								  <div class="tab-pane active" id="home">
									  <table class="responsive table table-striped table-bordered"
										id="dt_table_view">
										<thead>
											<tr>
												<th >id</th>
												<th >教师</th>
												<th >听课日期</th>
												<th >课程名称</th>
												<th >班级</th>
												<th >状态</th>
												<th >操作</th>
											</tr>
										</thead>
										<tbody>
										<c:forEach items="${todo }" var="bean">
											<tr>
												<td>${bean.id }</td>
												<td>${bean.user.name }</td>
												<td>${bean.lessonbefore }</td>
												<td>${bean.name }</td>
												<td>${bean.clazz }</td>
												<td><span class="label label-info">${bean.state}</span></td>
												<td><a href="report/create?id=${bean.id}">开始考评</a>
													<a href="work/viewreport?id=${bean.id}">查看结果</a>
												</td>
											</tr>
										</c:forEach>
										</tbody>
									</table>
								  </div>
								  <div class="tab-pane" id="profile">
								    <table class="responsive table table-striped table-bordered"
										id="dt_table_view">
										<thead>
											<tr>
												<th >id</th>
												<th >教师</th>
												<th >听课日期</th>
												<th >课程名称</th>
												<th >班级</th>
												<th >状态</th>
												<th >操作</th>
											</tr>
										</thead>
										<tbody>
										<c:forEach items="${done }" var="bean">
											<tr>
												<td>${bean.id }</td>
												<td>${bean.user.name }</td>
												<td>${bean.lessonbefore }</td>
												<td>${bean.name }</td>
												<td>${bean.clazz }</td>
												<td><span class="label label-info">${bean.state}</span></td>
												<td>
													<a href="work/viewreport?id=${bean.id}">查看结果</a>
												</td>
											</tr>
										</c:forEach>
										</tbody>
									</table>
								  </div>
								  
								</div>
							</div>						
						</div>
					</div>
				</div>
			</div>
		</div>
		<%@ include file="../foot.jsp"%>
	</div>

	<!-- 编辑新增弹出框 -->
	<div class="modal hide fade" id="_modal">
		<div class="modal-header blue">
			<button type="button" class="close" data-dismiss="modal">×</button>
			<label id="_modal_header_label"></label>
		</div>
		<div class="modal-body" >
			<div class="row-fluid">
				<div class="span12">
					<div class="form-container grid-form form-background left-align form-horizontal">
						<form action="" method="get" id=''>
							<input type="hidden"  name='id' id="id" value="">
							
							<div class="control-group">
								<label for="title" class="control-label">学生：</label>
								<div class="controls">
									<select name='user.id'>
										<c:forEach items="${users }" var="bean">
											<option value="${bean.id }">${bean.name }</option>
										</c:forEach>
									</select>
								</div>
							</div>
							<div class="control-group">
								<label for="title" class="control-label">月薪：</label>
								<div class="controls">
									<input type="text" name='cash' id="cash" placeholder="">
								</div>
							</div>
							<div class="control-group">
								<label for="title" class="control-label">工作时间：</label>
								<div class="controls">
									<div class="input-append date">
									 <input id='workdate' name="workdate" style="width:120px;" type="text" value="" readonly="readonly">
									 <span class="add-on"><i class="icon-th"></i></span>
								</div>
								</div>
							</div>
							<div class="control-group">
								<label for="title" class="control-label">工作单位：</label>
								<div class="controls">
									<input type="text" name='unit' id="unit" placeholder="">
								</div>
							</div>
							<div class="control-group">
								<label for="title" class="control-label">毕业学校：</label>
								<div class="controls">
									<input type="text" name='school' id="school" placeholder="">
								</div>
							</div>
								
							<div class="control-group">
								<label for="title" class="control-label">就业反馈：</label>
								<div class="controls">
								<textarea rows="5" cols="" name='remark'></textarea>
								</div>
							</div>
							
						</form>
					</div>
				</div>
			</div>
		</div>
		
		<div class="modal-footer center" id="div_footer">
			<a class="btn btn-primary" onclick="$.work.saveUser()">保存</a>
			<a href="#" class="btn" data-dismiss="modal" id="closeViewModal">关闭</a>
		</div>
	</div>
</body>
</html>