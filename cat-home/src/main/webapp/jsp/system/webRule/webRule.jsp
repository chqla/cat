<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="a" uri="/WEB-INF/app.tld"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="res" uri="http://www.unidal.org/webres"%>
<%@ taglib prefix="w" uri="http://www.unidal.org/web/core"%>

<jsp:useBean id="ctx" type="com.dianping.cat.system.page.config.Context" scope="request"/>
<jsp:useBean id="payload" type="com.dianping.cat.system.page.config.Payload" scope="request"/>
<jsp:useBean id="model" type="com.dianping.cat.system.page.config.Model" scope="request"/>

<a:config>
	<script type="text/javascript">
		$(document).ready(function() {
			$('#userMonitor_config').addClass('active open');
			$('#webRule').addClass('active');
 		});
	</script>
			<table class="table table-striped table-condensed table-bordered  table-hover" id="contents" width="100%">
			<thead>
				<tr >
					<th width="10%">告警名</th>
					<th width="10%">组</th>
					<th width="40%">URL</th>
					<th width="8%">省份</th>
					<th width="8%">城市</th>
					<th width="8%">运营商</th>
					<th width="8%">告警指标</th>
					<th width="8%">操作 <a href="?op=webRuleUpdate" class="btn btn-primary btn-xs" >
						<i class="ace-icon glyphicon glyphicon-plus bigger-120"></i></a></th>
				</tr></thead><tbody>

				<c:forEach var="item" items="${model.rules}" varStatus="status">
					<c:set var="strs" value="${fn:split(item.id, ':')}" />
					<c:set var="conditions" value="${fn:split(strs[0], ';')}" />
					<c:set var="urlId" value="${conditions[0]}" />
					<c:set var="index" value="${fn:indexOf(strs[0], ';')}" />
					<c:set var="length" value="${fn:length(strs[0])}" />
					<c:set var="cityOperator" value="${fn:substring(strs[0], index + 1, length)}" />
					<c:set var="cityStr" value="${fn:substringBefore(cityOperator, ';')}" />
					<c:set var="city" value="${fn:split(cityStr, '-')}" />
					<c:set var="operator" value="${fn:substringAfter(cityOperator, ';')}" />
					<c:set var="type" value="${strs[1]}" />
					<c:set var="name" value="${strs[2]}" />
					<tr class="">
						<td>${name}</td>
						<c:forEach var="i" items="${model.patternItems}">
							<c:if test="${i.name eq urlId}"><td>${i.group}</td><td>${i.pattern}</td></c:if>
						</c:forEach>
						<c:choose>
						<c:when test="${not empty city[0]}">
							<td>${city[0]}</td>
							<c:choose>
							<c:when test="${not empty city[1]}">
								<td>${city[1]}</td>
							</c:when>
							<c:otherwise>
								<td>All</td>
							</c:otherwise>
							</c:choose>
						</c:when>
						<c:otherwise>
							<td>All</td>
							<td>All</td>
						</c:otherwise>
						</c:choose>
						<c:choose>
						<c:when test="${not empty operator}">
							<td>${operator}</td>
						</c:when>
						<c:otherwise>
							<td>All</td>
						</c:otherwise>
						</c:choose>
						<td>
							<c:if test="${type eq 'request'}">请求数</c:if> 
							<c:if test="${type eq 'success'}">成功率</c:if>  
							<c:if test="${type eq 'delay'}">响应时间</c:if> 
						</td>
						<td><a href="?op=webRuleUpdate&ruleId=${item.id}" class="btn btn-primary btn-xs">
						<i class="ace-icon fa fa-pencil-square-o bigger-120"></i></a>
						<a href="?op=webRuleDelete&ruleId=${item.id}" class="btn btn-danger btn-xs delete" >
						<i class="ace-icon fa fa-trash-o bigger-120"></i></a></td>
					</tr>
				</c:forEach></tbody>
				</tbody>
			</table>
</a:config>
