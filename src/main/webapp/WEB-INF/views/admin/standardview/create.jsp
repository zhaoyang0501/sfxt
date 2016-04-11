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
							<h3>缴费单录入</h3>
						</div>
						<div class="widget-container">
							<form id='dayoffform' class="form-horizontal " method="post" action="work/save">
								<table id='' class=" responsive table table-striped table_bordered_black table-condensed formtable" >
									<tr>
										<td colspan="4">
											<div class="table_title">
												 <h3>缴费单录入</h3> 
											</div>
										</td>
									</tr>
									<tr>
										<td class='lable'>学号</td>
										<td class='lable' >
											<input type="text" value=" " name='grade'>
										</td>
										<td class='lable'>姓名</td>
										<td class='lable' >
											<input type="text" value=" " name='grade'>
										</td>
									</tr>
									
									<tr>
										<td class='lable'>院系</td>
										<td class='lable' >
											<input type="text" value=" " name='name'>
										</td>
										<td class='lable'>班级</td>
										<td class='lable' >
											<input type="text" value=" " name='type'>
										</td>
									</tr>
									
									<tr>
										<td class='lable'>缴费方式</td>
										<td class='lable' >
											<select style="width: 70%">
												<option>银行转账</option>
											</select>
										</td>
										<td class='lable'>学年</td>
										<td class='lable' >
											<select style="width: 70%">
												<option>2016学年</option>
											</select>
										</td>
									</tr>
									<tr>
										<td class='lable'>选择</td>
										<td class='lable'>项目</td>
										<td class='lable'>金额</td>
										<td class='lable'>备注</td>
									</tr>
									<tr>
										<td class='lable'> <input  type="checkbox"/></td>
										<td class='lable'>学费</td>
										<td class='lable'>100.00</td>
										<td class='lable'>必须要交</td>
									</tr>
									<tr>
										<td class='lable'> <input  type="checkbox"/></td>
										<td class='lable'>伙食费</td>
										<td class='lable'>100.00</td>
										<td class='lable'>必须要交</td>
									</tr>
									<tr>
										<td class='lable' colspan="2">合计</td>
										<td class='lable' colspan="2">200.00</td>
									</tr>
									<tr>
										<td class='lable' colspan="2">应交</td>
										<td class='lable' colspan="2">200.00</td>
									</tr>
									<tr>
										<td class='lable' colspan="2">实交</td>
										<td class='lable' colspan="2"><input type="text" value="" style="width: 60px" name='type'></td>
									</tr>
									<tr>
										<td class='lable' colspan="2">欠交</td>
										<td class='lable' colspan="2"><input type="text" value="" style="width: 60px" name='type'></td>
									</tr>
									<tr>
										<td class='lable'>备注：<span class="text-error">*</span></td>
										<td colspan="3" ><textarea  name='remark' style="width: 90%" rows="2" cols=""></textarea> </td>
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
									<button type="submit" class="btn btn-primary" >提交</button>
								</div>
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