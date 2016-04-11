<!DOCTYPE html>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html lang="ch">
<%@ include file="../common/meta.jsp"%>
<head>
<script type="text/javascript" src="${pageContext.request.contextPath}/admin/js/ace/admin.standardview.js"></script>
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
	
	function fun_changemajor(){
		var id=$("#_major").val();
		$.ajax({
			type : "get",
			url : $.ace.getContextPath() + "/admin/standard/getGrades?id="+id,
			dataType : "json",
			success : function(json) {
				$("#_grade").empty();
				$("#_grade").append("<option value=''>--请选择--</option>");
				for(i=0;i<json.length;i++){
					$("#_grade").append("<option value='"+json[i].id+"'>"+json[i].name+"</option>");
				}
			}
		});
	}
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
								<h3>收费标准查询</h3>
							</div>
							<div class="box well form-inline">
								学年
								<select id='_year'>
									<option value="2017">2017学年</option>
									<option value="2016" selected="selected">2016学年</option>
									<option value="2015">2015学年</option>
									<option value="2014">2014学年</option>
								</select>
								专业
								<select id='_major' onchange="fun_changemajor()">
								<option value="">---全部--</option>
									<c:forEach items="${majors }" var="bean">
										<option value="${bean.id }">${bean.name }</option>
									</c:forEach>
								</select>
								年级
								<select id='_grade'>
									<option value=''>--请选择--</option>
								</select>
								<a onclick="$.standardview.initSearchDataTable()"
									class="btn btn-info" data-loading-text="正在加载..."><i class="icon-search"></i>查询</a>
							</div>
							<div class="row-fluid ">
								<table class="responsive table table-striped table-bordered"
									id="dt_table_view">
									<thead>
										<tr>
										    <th >学年</th>
											<th >专业</th>
											<th >年级</th>
											<th >学费合计</th>
											<th >状态</th>
											<th >查看详情</th>
										</tr>
									</thead>
									<tbody>
									</tbody>
								</table>
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
		<div class="modal-header blue"> 学费标准详情
			<button type="button" class="close" data-dismiss="modal">×</button>
			<label id="_modal_header_label"></label>
		</div>
		<div class="modal-body" >
			<div class="row-fluid">
				<div class="span12">
					<div class="form-container grid-form form-background left-align form-horizontal">
						<form action="" method="get" id='_form' >
						</form>
					</div>
				</div>
			</div>
		</div>
		
		<div class="modal-footer center" id="div_footer">
			<a href="#" class="btn" data-dismiss="modal" id="closeViewModal">返回</a>
		</div>
	</div>
</body>
</html>