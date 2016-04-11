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
		function fun_getstandard(){
			$.ajax({
				type : "get",
				url : $.ace.getContextPath() + "/admin/fee/getstandard?gid="+$("#_grade").val()+"&year="+$("#_year").val(),
				dataType : "json",
				success : function(json) {
					if(json.object.items.length!=4) return ;
					var all=0;
					for(i=0;i<json.object.items.length;i++){
						all+=(0+json.object.items[i].fee);
						$("#fee_"+json.object.items[i].category.id).val(json.object.items[i].fee);
					}
					//alert(all);
					$("._all").html(all);
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
		<div class="main-wrapper">
			<div class="container-fluid">
				<div class="row-fluid ">
					<div class="span12">
						<div class="content-widgets ">
						<div class="widget-head  bondi-blue">
							<h3>缴费单录入</h3>
						</div>
						<div class="widget-container">
							<form id='dayoffform' class="form-horizontal " method="post" action="fee/save">
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
											<input type="text" value=" " name='user.username'>
										</td>
										<td class='lable'>姓名</td>
										<td class='lable' >
											<input type="text" value=" " name='grade'>
										</td>
									</tr>
									
									<tr>
										<td class='lable'>院系专业</td>
										<td class='lable' >
											<select id='_major' onchange="fun_changemajor()" style="width: 73%">
												<option value="">---全部--</option>
													<c:forEach items="${majors }" var="bean">
														<option value="${bean.id }">${bean.name }</option>
													</c:forEach>
											</select>
										</td>
										<td class='lable'>班级</td>
										<td class='lable' >
											<select id='_grade' style="width: 73%">
												<option value=''>--请选择--</option>
											</select>
										</td>
									</tr>
									
									<tr>
										<td class='lable'>缴费方式</td>
										<td class='lable' >
											<select style="width: 73%" name="paytype">
												<option value="银行转账">银行转账</option>
												<option value="现金">现金</option>
												<option value="支票">支票</option>
													<option value="自助缴费">自助缴费</option>
											</select>
										</td>
										<td class='lable'>学年</td>
										<td class='lable' >
											<select id='_year' style="width: 73%" name='year' onchange="fun_getstandard()">
												<option value="2017">2017学年</option>
													<option value="2016" selected="selected">2016学年</option>
													<option value="2015">2015学年</option>
													<option value="2014">2014学年</option>
											</select>
										</td>
									</tr>
									<tr>
										<td class='lable'>选择</td>
										<td class='lable'>项目</td>
										<td class='lable'>金额</td>
										<td class='lable'>备注</td>
									</tr>
									<c:forEach items="${categorys }" var="bean"  varStatus="status">
										<tr>
										<input type="hidden" name='feeitems[${status.index}].category.id' value="${bean.id }"/>
											<td class='lable'> <input  type="checkbox"/></td>
											<td class='lable'>${bean.name }</td>
											<td class='lable'><input type="text" id='fee_${bean.id }' name='feeitems[${status.index}].fee' style="width: 60px"/>
									</td>
											<td class='lable'>${bean.remark }</td>
										</tr>
									</c:forEach>
								
									<tr>
										<td class='lable' colspan="2">合计</td>
										<td class='lable' colspan="2"><span class='_all'></span> </td>
									</tr>
									<tr>
										<td class='lable' colspan="2">应交</td>
										<td class='lable' colspan="2"><span class='_all'></span></td>
									</tr>
									<tr>
										<td class='lable' colspan="2">实交</td>
										<td class='lable' colspan="2"><input type="text" value="" style="width: 60px" name='payfee'></td>
									</tr>
									<tr>
										<td class='lable' colspan="2">欠交</td>
										<td class='lable' colspan="2"><input type="text" value="" style="width: 60px" name='lastfee'></td>
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