<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, maximum-scale=1.0, initial-scale=0.8, minimum-scale=0.8">
<title>Dream Bears Stats</title>
<link rel="stylesheet" type="text/css" href="/css/jquery-ui.min.css">
<link rel="stylesheet" type="text/css" href="/css/jquery-ui.theme.min.css">
<!-- <link rel="stylesheet" type="text/css" href="/css/bootstrap.min.css"> -->
<link rel="stylesheet" type="text/css" href="/css/datatables.min.css">
<!-- <link rel="stylesheet" type="text/css" href="/css/dataTables.jqueryui.min.css"> -->
<style>
th {
    text-align: center;
  }
tr {
    text-align: center;
  }
</style>
<script type="text/javascript" src="/js/jquery-3.4.0.min.js"></script>
<script type="text/javascript" src="/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="/js/datatables.min.js"></script>
<script type="text/javascript" src="/js/common.js"></script>
<script type="text/javascript">
jQuery(function($) {
    $("#tabs").tabs({
    	active: 2
    });
    
    $("#table").DataTable({
    	order: [[ 0, "desc" ]],
		paging: false,
    	info: false,
    	searching: false,
    	fixedColumns: true,
    	scrollCollapse: true,
    	scrollX: true
    });
    
    $("#selectTeamYear").on("change", function() {
    	document.location.href = "/teamStatsView.do?year=" + $(this).val();
    });
    
    $("#goBatters").on("click", function() {
    	document.location.href = "/battersStatView.do";
    });
    
    $("#goPitchers").on("click", function() {
    	document.location.href = "/pitchersStatView.do";
    });
    
    $("#title").on("click", function() {
    	document.location.href = "/battersStatView.do";
    });
    
    $("#btnFilter").on("click", function() {
    	var pa = "${pa}";
    	if (pa == "200") {
    		document.location.href = "/battersStatView.do?year=9999";
    	} else {
    		document.location.href = "/battersStatView.do?year=9999&pa=200";
    	}
    });
    
    adjustTable($("#tabs-3"));
    
    $(window).resize(function() {
    	adjustTable($("#tabs-3"));
    });
})
</script>
</head>
<body>

<h2 id="title">DREAM BEARS STATS</h2>
<div id="tabs">
    <ul>
        <li><a href="#tabs-1" id="goBatters">타격</a></li>
        <li><a href="#tabs-2" id="goPitchers">투구</a></li>
        <li><a href="#tabs-3">팀</a></li>
    </ul>
    <div id="tabs-1">
    </div>
    <div id="tabs-2">
    </div>
    <div id="tabs-3">
        <table id="table" class="display">
            <thead>
                <tr>
                    <th>Year</th>
                    <th>W</th>
                    <th>D</th>
                    <th>L</th>
                    <th>Games</th>
                    <th>Win%</th>
                </tr>
            </thead>
            <tbody>
            <c:forEach var="team" items="${list}" varStatus="vs">
                <c:if test="${team.year != 9999 }">
                <tr>
                    <th>
                        
                        <a href="/teamStatsView.do?year=${team.year }">${team.year }</a>
                    </th>
                    <td>
                        ${team.wins}
                    </td>
                    <td>
                        ${team.draws }
                    </td>
                    <td>
                        ${team.losses}
                    </td>
                    <td>
                        ${team.totalGames }
                    </td>
                    <td>
                        <fmt:formatNumber value="${team.winPcg }" minFractionDigits="3" pattern=".###"/>
                    </td>
                </tr>
                </c:if>
            </c:forEach>
            </tbody>
            <tfoot>
                <c:forEach var="team" items="${list}" varStatus="vs">
                <c:if test="${team.year == 9999 }">
                <tr>
                    <th>
                        TOTAL
                    </th>
                    <td>
                        ${team.wins}
                    </td>
                    <td>
                        ${team.draws }
                    </td>
                    <td>
                        ${team.losses}
                    </td>
                    <td>
                        ${team.totalGames }
                    </td>
                    <td>
                        <fmt:formatNumber value="${team.winPcg }" minFractionDigits="3" pattern=".###"/>
                    </td>
                </tr>
                </c:if>
                </c:forEach>
                <tr>
                    <th>Year</th>
                    <th>W</th>
                    <th>D</th>
                    <th>L</th>
                    <th>Games</th>
                    <th>Win%</th>
                </tr>
            </tfoot>
        </table>
    </div>
</div>
<br/>

<a href="/battersStatView.do">DREAM BEARS STATS</a>

</body>
</html>