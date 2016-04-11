<!DOCTYPE html>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html lang="ch">
<%@ include file="../common/meta.jsp"%>
<head>
<script type="text/javascript" src="${pageContext.request.contextPath}/admin/js/ace/admin.item.js"></script>
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
		if("${tip}" != null && "${tip}" != ""){
			noty({"text":"${tip}","layout":"top","type":"success","timeout":"2000"});
		}
	});
</script>
</head>
	
	<script type="text/javascript">
		$(function() {
		});
	</script>
</head>
<body>
	<div class="layout">
		<!-- top -->
		<%@ include file="../top.jsp"%>
		<!-- 导航 -->
		<%@ include file="../menu.jsp"%>
		<div class="main-wrapper">
			<div class="container-fluid">
				<div class="row-fluid ">
					<div class="span12">
						<div class="content-widgets ">
						<div class="widget-head  bondi-blue">
							<h3>课堂教学督导评价综合意见表</h3>
						</div>
						<div class="widget-container">
							<form id='dayoffform' class="form-horizontal " method="post" action="report/save">
								<input type="hidden" name="work.id" value="${work.id}"/>
								<table id='' class=" responsive table table-striped table_bordered_black table-condensed formtable" >
									<tr>
										<td colspan="4">
											<div class="table_title">
												 <h3>课堂教学督导评价综合意见表</h3> 
											</div>
										</td>
									</tr>
									<tr>
										<td class='lable'>任课老师</td>
										<td class='lable' >
											${work.user.name }
										</td>
										<td class='lable'>所在院系</td>
										<td class='lable' >
											${work.grade }
										</td>
									</tr>
									
									<tr>
										<td class='lable'>课程名称</td>
										<td class='lable' >
												${work.name }
										</td>
										<td class='lable'>教师类型</td>
										<td class='lable' >
											${work.lessonafter }
										</td>
									</tr>
									
									<tr>
										<td class='lable'>教学内容</td>
										<td class='lable' >
											${work.title }
										</td>
										<td class='lable'>班级</td>
										<td class='lable' >
												${work.clazz }
										</td>
									</tr>
									<tr>
										<td class='lable'>听课时间</td>
										<td class='lable' >
											${work.lessonbefore }
										</td>
										<td class='lable'>评课时间</td>
										<td class='lable' >
											${work.lessonbefore }
										</td>
									</tr>
									<tr>
										<td class='lable'>评定结果</td>
										<td class='lable' >
											良好
										</td>
										<td class='lable'>评分</td>
										<td class='lable' >
											${score }
										</td>
									</tr>
									
									<tr>
										<td class='lable'>评价人</td>
										<td class='lable' colspan="3" >
											${teacher }
										</td>
										
									</tr>
									
									<tr>
										<td class='lable'>评价纪要</td>
										<td class='lable' colspan="3" >
											<textarea name='remark1' rows="9" cols="" style="width: 90%;">${remark1 }</textarea>
										</td>
									</tr>
									
									<tr>
										<td class='lable'>评  价意见</td>
										<td class='lable' colspan="3" >
											<textarea name='remark2' rows="9" cols="" style="width: 90%;">${remark2 }</textarea>
										</td>
									</tr>
									<tr>
										<td class='lable'>后续工作</td>
										<td class='lable' colspan="3" >
											<textarea name='remark3' rows="9" cols="" style="width: 90%;">${remark3 }</textarea>
										</td>
									</tr>
									
									<tr>
										<td class='lable'>备注：<span class="text-error">*</span></td>
										<td colspan="3" ><textarea  name='remark4' style="width: 90%" rows="9" cols="">${remark4}</textarea> </td>
									</tr>
									<tr  class='remark'>
										<td colspan="4">
											<ol>
											  <li>请如实填写资料</li>
											  <li>所有信息可能会被核查</li>
											</ol>
										</td>
									</tr>
								</table>
								<div >
								</div>
							</form>
							
							
							
								<div class="widget-header-block">
									<h4 class="widget-header">留言列表</h4>
								</div>
								<table id='dt_weekReport' class="responsive table table-striped table-bordered table-condensed ">
									<thead>
										<tr>
											<th>留言人</th>
											<th>日期</th>
											<th>内容</th>
										</tr>
									</thead>
									<tbody>
									<c:forEach items="${msgboxs }" var="bean">
										<tr>
											<td>${bean.user.name }</td>
											<td>${bean.createDate }</td>
											<td>${bean.remark }</td>
										</tr>
									</c:forEach>
									</tbody>
								</table>
								
							
							
							
							<form  id='workflowform' class="form-horizontal " method="post" action="msgbox/save">
									<input type="hidden" name='work.id' value="${work.id }">
									<fieldset class="default">
										<legend>发表留言</legend>
										<div class="control-group">
											<label class="control-label"><span class="error">* </span>内容</label>
											<div class="controls">
												<textarea  name="remark" rows="3" class="span12"></textarea>
											</div>
										</div>
										<div class="control-group">
											<div class="controls">
														<button type="submit"  class="btn btn-primary">发表</button>
											</div>
										</div>
									</fieldset>
								</form>
							
							
							
							
						</div>
					</div>
					
					</div>
				</div>
			</div>
		</div>
		<%@ include file="../foot.jsp"%>
	</div>
</body>
</html>