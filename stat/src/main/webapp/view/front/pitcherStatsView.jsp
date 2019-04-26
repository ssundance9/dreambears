<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Dream Bears Stats</title>
<meta name="viewport" content="width=device-width, maximum-scale=1.0, initial-scale=0.8, minimum-scale=0.8">
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
    text-align: right;
  }
</style>
<script type="text/javascript"  src="/js/jquery-3.4.0.min.js"></script>
<script type="text/javascript"  src="/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="/js/datatables.min.js"></script>
<script type="text/javascript" src="/js/common.js"></script>
<script type="text/javascript">
jQuery(function($) {
    $("#tabs").tabs({
        active: 1
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
    
    $("#goBatter").on("click", function() {
        document.location.href = "/batterStatsView.do?name=${param.name}";
    });
    
    $("#title").on("click", function() {
    	document.location.href = "/battersStatView.do";
    });
    
    adjustTable($("#tabs-2"));
    
    $(window).resize(function() {
    	adjustTable($("#tabs-2"));
    });
})
</script>
</head>
<body>

<h2><span id="title">DREAM BEARS STATS</span> - ${param.name }</h2>
<div id="tabs">
    <ul>
        <li><a href="#tabs-1" id="goBatter">타격</a></li>
        <li><a href="#tabs-2">투구</a></li>
    </ul>
    <div id="tabs-1">
    </div>
    <div id="tabs-2">
        <table id="table" class="display">
            <thead>
                <tr>
                    <th>Year</th>
                    <th>W</th>
                    <th>L</th>
                    <th>SV</th>
                    <th>IP</th>
                    <th>PA</th>
                    <th>AB</th>
                    <th>H</th>
                    <th>HR</th>
                    <th>SF</th>
                    <th>BB</th>
                    <th>SO</th>
                    <th>R</th>
                    <th>ER</th>
                    <th>ERA</th>
                    <th>AVG</th>
                    <th>WHIP</th>
                    <th>FIP/IP</th>
                </tr>
            </thead>
            <tbody>
            <c:forEach var="pitcher" items="${list}">
                <c:if test="${pitcher.name != 'TOTAL' }">
                <tr>
                    <th style="text-align: center;">
                        ${pitcher.year }
                    </th>
                    <td>
                        ${pitcher.wins }
                    </td>
                    <td>
                        ${pitcher.losses }
                    </td>
                    <td>
                        ${pitcher.saves }
                    </td>
                    <td>
                        ${pitcher.inningsPitched }
                    </td>
                    <td>
                        ${pitcher.plateAppears }
                    </td>
                    <td>
                        ${pitcher.atBats }
                    </td>
                    <td>
                        ${pitcher.hits }
                    </td>
                    <td>
                        ${pitcher.homeRuns }
                    </td>
                    <td>
                        ${pitcher.sacrificeFly }
                    </td>
                    <td>
                        ${pitcher.basesOnBalls }
                    </td>
                    <td>
                        ${pitcher.strikeOuts }
                    </td>
                    <td>
                        ${pitcher.runs }
                    </td>
                    <td>
                        ${pitcher.earnedRuns }
                    </td>
                    <td>
                        <fmt:formatNumber value="${pitcher.earnedRunAvg }" minFractionDigits="2" pattern=".##"/>
                    </td>
                    <td>
                        <fmt:formatNumber value="${pitcher.battingAvg }" minFractionDigits="3"  pattern=".###"/>
                    </td>
                    <td>
                        <fmt:formatNumber value="${pitcher.walksHitsIP }" minFractionDigits="2"  pattern=".##"/>
                    </td>
                    <td>
                        <fmt:formatNumber value="${pitcher.fieldingIndependentPitching }" minFractionDigits="2"  pattern=".##"/>
                    </td>
                </tr>
                </c:if>
            </c:forEach>
            </tbody>
            <tfoot>
                <c:forEach var="pitcher" items="${list}">
                <c:if test="${pitcher.name == 'TOTAL' }">
                <tr>
                    <th>
                        ${pitcher.name }
                    </th>
                    <td>
                        ${pitcher.wins }
                    </td>
                    <td>
                        ${pitcher.losses }
                    </td>
                    <td>
                        ${pitcher.saves }
                    </td>
                    <td>
                        ${pitcher.inningsPitched }
                    </td>
                    <td>
                        ${pitcher.plateAppears }
                    </td>
                    <td>
                        ${pitcher.atBats }
                    </td>
                    <td>
                        ${pitcher.hits }
                    </td>
                    <td>
                        ${pitcher.homeRuns }
                    </td>
                    <td>
                        ${pitcher.sacrificeFly }
                    </td>
                    <td>
                        ${pitcher.basesOnBalls }
                    </td>
                    <td>
                        ${pitcher.strikeOuts }
                    </td>
                    <td>
                        ${pitcher.runs }
                    </td>
                    <td>
                        ${pitcher.earnedRuns }
                    </td>
                    <td>
                        <fmt:formatNumber value="${pitcher.earnedRunAvg }" minFractionDigits="2" pattern=".##"/>
                    </td>
                    <td>
                        <fmt:formatNumber value="${pitcher.battingAvg }" minFractionDigits="3"  pattern=".###"/>
                    </td>
                    <td>
                        <fmt:formatNumber value="${pitcher.walksHitsIP }" minFractionDigits="2"  pattern=".##"/>
                    </td>
                    <td>
                        <fmt:formatNumber value="${pitcher.fieldingIndependentPitching }" minFractionDigits="2"  pattern=".##"/>
                    </td>
                </tr>
                </c:if>
                </c:forEach>
                <tr>
                    <th>Year</th>
                    <th>W</th>
                    <th>L</th>
                    <th>SV</th>
                    <th>IP</th>
                    <th>PA</th>
                    <th>AB</th>
                    <th>H</th>
                    <th>HR</th>
                    <th>SF</th>
                    <th>BB</th>
                    <th>SO</th>
                    <th>R</th>
                    <th>ER</th>
                    <th>ERA</th>
                    <th>AVG</th>
                    <th>WHIP</th>
                    <th>FIP/IP</th>
                </tr>
            </tfoot>
        </table>
    </div>
</div>
<br/>
<a href="/battersStatView.do">DREAM BEARS STATS</a>

</body>
</html>