<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="leftbar leftbar-close clearfix">
	<div class="admin-info clearfix">
		<div class="admin-thumb">
			<i class="icon-user"></i>
		</div>
		<div class="admin-meta">
			<ul>
				<li class="admin-username" style="margin-top: 10px;">欢迎你 ${sessionScope.adminuser.name}</li>
				<li><a href="${pageContext.request.contextPath}/admin/loginout">
				<i class="icon-lock"></i> 退出</a></li>
			</ul>
		</div>
	</div>

	<div class="left-nav clearfix">
		<div class="left-primary-nav">
			<ul id="myTab">
				<li  class="active"><a href="#dailyreport" class="icon-calendar" data-original-title="订单"></a></li>
			</ul>
		</div>
		<div class="responsive-leftbar">
			<i class="icon-list"></i>
		</div>
		<div class="left-secondary-nav tab-content" >
			<div class="tab-pane active dailyreport" id="dailyreport">
				<ul id="nav" class="accordion-nav" >
				<c:if test="${sessionScope.adminuser.username=='admin'||sessionScope.adminuser.username=='admin2'}">
					<li><a href="${pageContext.request.contextPath}/admin/user/index"><i class="icon-pencil"></i>学生管理</a></li>
					<li><a href="${pageContext.request.contextPath}/admin/category/index"><i class="icon-pencil"></i>收费项目管理</a></li>
					<li><a href="${pageContext.request.contextPath}/admin/standard/index"><i class="icon-pencil"></i>收费标准设置</a></li>
					<li><a href="${pageContext.request.contextPath}/admin/fee/create"><i class="icon-pencil"></i>收费登记</a></li>
					<li><a href="${pageContext.request.contextPath}/admin/fee/index"><i class="icon-pencil"></i>收费查询</a></li>
			     
				</c:if>
				<c:if test="${sessionScope.adminuser.username!='admin1'&&sessionScope.adminuser.username!='admin2'}">
					 <!--
					<li><a href="${pageContext.request.contextPath}/admin/user/index"><i class="icon-pencil"></i>学生管理</a></li>
					<li><a href="${pageContext.request.contextPath}/admin/category/index"><i class="icon-pencil"></i>收费项目管理</a></li>
					<li><a href="${pageContext.request.contextPath}/admin/standard/index"><i class="icon-pencil"></i>收费标准设置</a></li>
					<li><a href="${pageContext.request.contextPath}/admin/fee/create"><i class="icon-pencil"></i>收费登记</a></li>
					<li><a href="${pageContext.request.contextPath}/admin/fee/index"><i class="icon-pencil"></i>收费查询</a></li>
			      -->
			      <li><a href="${pageContext.request.contextPath}/admin/center/index"><i class="icon-pencil"></i>个人中心</a></li>
			   
			    <li><a href="${pageContext.request.contextPath}/admin/standardview/index"><i class="icon-pencil"></i>收费标准查询</a></li>
			   <li><a href="${pageContext.request.contextPath}/admin/fee/topayfee"><i class="icon-pencil"></i>待缴费用</a></li>
			
			  <li><a href="${pageContext.request.contextPath}/admin/fee/myfee"><i class="icon-pencil"></i>我的缴费记录</a></li>
			
				</c:if>
				</ul>
			</div>
		</div>
	</div>
</div>