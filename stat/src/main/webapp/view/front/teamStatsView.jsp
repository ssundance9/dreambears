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
        연도
        <select name="year" id="selectTeamYear">
            <option value="9999" <c:if test="${year == 9999}">selected="selected"</c:if>>통산</option>
            <option value="2019" <c:if test="${year == 2019}">selected="selected"</c:if>>2019</option>
            <option value="2018" <c:if test="${year == 2018}">selected="selected"</c:if>>2018</option>
            <option value="2017" <c:if test="${year == 2017}">selected="selected"</c:if>>2017</option>
            <option value="2016" <c:if test="${year == 2016}">selected="selected"</c:if>>2016</option>
            <option value="2015" <c:if test="${year == 2015}">selected="selected"</c:if>>2015</option>
            <option value="2014" <c:if test="${year == 2014}">selected="selected"</c:if>>2014</option>
            <option value="2013" <c:if test="${year == 2013}">selected="selected"</c:if>>2013</option>
            <option value="2012" <c:if test="${year == 2012}">selected="selected"</c:if>>2012</option>
            <option value="2011" <c:if test="${year == 2011}">selected="selected"</c:if>>2011</option>
            <option value="2010" <c:if test="${year == 2010}">selected="selected"</c:if>>2010</option>
            <option value="2009" <c:if test="${year == 2009}">selected="selected"</c:if>>2009</option>
        </select>
        
        <br/>
        <br/>
        <table id="table" class="display">
            <thead>
                <tr>
                    <!-- <th>Data</th>
                    <th>Ball<br/>Park</th>
                    <th>League<br/>/Practice</th>
                    <th>Home<br/>/Away</th>
                    <th>VS</th>
                    <th>Result</th> -->
                    <th style="white-space: nowrap;">날짜</th>
                    <th style="white-space: nowrap;">장소</th>
                    <th style="white-space: nowrap;">리그</th>
                    <th style="white-space: nowrap;">홈어웨이</th>
                    <th style="white-space: nowrap;">VS</th>
                    <th style="white-space: nowrap;">결과</th>
                </tr>
            </thead>
            <tbody>
            <c:forEach var="team" items="${list}" varStatus="vs">
                <%-- <c:if test="${team.name != 'TOTAL' }"> --%>
                <tr>
                    <th>
                        <fmt:formatNumber value="${team.month }" minIntegerDigits="2"/>.<fmt:formatNumber value="${team.date }" minIntegerDigits="2"/>
                    </th>
                    <td>
                        ${team.ballPark }
                    </td>
                    <td>
                        ${team.type }
                    </td>
                    <td>
                        ${team.homeAway}
                    </td>
                    <td>
                        ${team.opponent }
                    </td>
                    <td>
                        ${team.result }
                    </td>
                </tr>
                <%-- </c:if> --%>
            </c:forEach>
            </tbody>
            <tfoot>
                <%-- <c:forEach var="team" items="${list}" varStatus="vs">
                <c:if test="${team.name == 'TOTAL' }">
                <tr>
                    <th style="text-align: center;">
                        ${team.month }.${team.date }
                    </th>
                    <td>
                        ${team.ballPark }
                    </td>
                    <td>
                        ${team.type }
                    </td>
                    <td>
                        ${team.homeAway}
                    </td>
                    <td>
                        ${team.opponent }
                    </td>
                    <td>
                        ${team.result }
                    </td>
                </tr>
                </c:if>
                </c:forEach> --%>
                <tr>
                    <!-- <th>Data</th>
                    <th>Ball<br/>Park</th>
                    <th>League<br/>/Practice</th>
                    <th>Home<br/>/Away</th>
                    <th>VS</th>
                    <th>Result</th> -->
                    <th>날짜</th>
                    <th>장소</th>
                    <th>리그</th>
                    <th>홈어웨이</th>
                    <th>VS</th>
                    <th>결과</th>
                </tr>
            </tfoot>
        </table>
    </div>
</div>
<br/>

<a href="/battersStatView.do">DREAM BEARS STATS</a>

</body>
</html>