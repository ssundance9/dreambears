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
    text-align: right;
  }
</style>
<script type="text/javascript"  src="/js/jquery-3.4.0.min.js"></script>
<script type="text/javascript"  src="/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="/js/datatables.min.js"></script>
<script type="text/javascript" src="/js/common.js"></script>
<script type="text/javascript">
jQuery(function($) {
	$("#tabs").tabs();
	
	$("#table").DataTable({
		order: [[ 0, "desc" ]],
		paging: false,
    	info: false,
    	searching: false,
    	fixedColumns: true,
    	scrollCollapse: true,
    	scrollX: true
    });
	
    $("#goPitcher").on("click", function() {
    	document.location.href = "/pitcherStatsView.do?name=${param.name}";
    });
    
    $("#title").on("click", function() {
    	document.location.href = "/battersStatView.do";
    });
    
    adjustTable($("#tabs-1"));
    
    $(window).resize(function() {
    	adjustTable($("#tabs-1"));
    });
})
</script>
</head>
<body>

<h2><span id="title">DREAM BEARS STATS</span> - ${param.name }</h2>
<div id="tabs">
    <ul>
        <li><a href="#tabs-1">타격</a></li>
        <li><a href="#tabs-2" id="goPitcher">투구</a></li>
    </ul>
    <div id="tabs-1">
        <table id="table" class="display">
            <thead>
                <tr>
                    <th>Year</th>
                    <c:if test="${param.name != 'TOTAL' }">
                    <th>G</th>
                    </c:if>
                    <th>PA</th>
                    <th>AB</th>
                    <th>H</th>
                    <th>1B</th>
                    <th>2B</th>
                    <th>3B</th>
                    <th>HR</th>
                    <th>R</th>
                    <th>RBI</th>
                    <th>BB</th>
                    <th>SO</th>
                    <th>SB</th>
                    <th>AVG</th>
                    <th>OBP</th>
                    <th>SLG</th>
                    <th>OPS</th>
                    <th>RC</th>
                    <th>RC/21</th>
                    <th>GPA</th>
                    <th>BABIP</th>
                </tr>
            </thead>
            <tbody>
            <c:forEach var="batter" items="${list}">
                <c:if test="${batter.name != 'TOTAL' }">
                <tr>
                    <th style="text-align: center;">
                        ${batter.year }
                    </th>
                    <c:if test="${param.name != 'TOTAL' }">
                    <td>
                        ${batter.games }
                    </td>
                    </c:if>
                    <td>
                        ${batter.plateAppears }
                    </td>
                    <td>
                        ${batter.atBats }
                    </td>
                    <td>
                        ${batter.hits }
                    </td>
                    <td>
                        ${batter.singles }
                    </td>
                    <td>
                        ${batter.doubles }
                    </td>
                    <td>
                        ${batter.triples }
                    </td>
                    <td>
                        ${batter.homeRuns }
                    </td>
                    <td>
                        ${batter.runsScored }
                    </td>
                    <td>
                        ${batter.runsBattedIn }
                    </td>
                    <td>
                        ${batter.basesOnBalls }
                    </td>
                    <td>
                        ${batter.strikeOuts }
                    </td>
                    <td>
                        ${batter.stolenBases }
                    </td>
                    <td>
                        <fmt:formatNumber value="${batter.battingAvg }" minFractionDigits="3" pattern=".###"/>
                    </td>
                    <td>
                        <fmt:formatNumber value="${batter.onBasePcg }" minFractionDigits="3"  pattern=".###"/>
                    </td>
                    <td>
                        <fmt:formatNumber value="${batter.sluggingPcg }" minFractionDigits="3"  pattern=".###"/>
                    </td>
                    <td>
                        <fmt:formatNumber value="${batter.onBasePlusSlugging }" minFractionDigits="3"  pattern=".###"/>
                    </td>
                    <td>
                        <fmt:formatNumber value="${batter.runsCreated }" minFractionDigits="3"  pattern=".###"/>
                    </td>
                    <td>
                        <fmt:formatNumber value="${batter.runsCreated21 }" minFractionDigits="3"  pattern=".###"/>
                    </td>
                    <td>
                        <fmt:formatNumber value="${batter.grossProductionAvg }" minFractionDigits="3"  pattern=".###"/>
                    </td>
                    <td>
                        <fmt:formatNumber value="${batter.battingAvgOnBIP }" minFractionDigits="3"  pattern=".###"/>
                    </td>
                </tr>
                </c:if>
            </c:forEach>
            </tbody>
            <tfoot>
                <c:forEach var="batter" items="${list}">
                <c:if test="${batter.name == 'TOTAL' }">
                <tr>
                    <th>
                        ${batter.name }
                    </th>
                    <c:if test="${param.name != 'TOTAL' }">
                    <td>
                        ${batter.games }
                    </td>
                    </c:if>
                    <td>
                        ${batter.plateAppears }
                    </td>
                    <td>
                        ${batter.atBats }
                    </td>
                    <td>
                        ${batter.hits }
                    </td>
                    <td>
                        ${batter.singles }
                    </td>
                    <td>
                        ${batter.doubles }
                    </td>
                    <td>
                        ${batter.triples }
                    </td>
                    <td>
                        ${batter.homeRuns }
                    </td>
                    <td>
                        ${batter.runsScored }
                    </td>
                    <td>
                        ${batter.runsBattedIn }
                    </td>
                    <td>
                        ${batter.basesOnBalls }
                    </td>
                    <td>
                        ${batter.strikeOuts }
                    </td>
                    <td>
                        ${batter.stolenBases }
                    </td>
                    <td>
                        <fmt:formatNumber value="${batter.battingAvg }" minFractionDigits="3" pattern=".###"/>
                    </td>
                    <td>
                        <fmt:formatNumber value="${batter.onBasePcg }" minFractionDigits="3"  pattern=".###"/>
                    </td>
                    <td>
                        <fmt:formatNumber value="${batter.sluggingPcg }" minFractionDigits="3"  pattern=".###"/>
                    </td>
                    <td>
                        <fmt:formatNumber value="${batter.onBasePlusSlugging }" minFractionDigits="3"  pattern=".###"/>
                    </td>
                    <td>
                        <fmt:formatNumber value="${batter.runsCreated }" minFractionDigits="3"  pattern=".###"/>
                    </td>
                    <td>
                        <fmt:formatNumber value="${batter.runsCreated21 }" minFractionDigits="3"  pattern=".###"/>
                    </td>
                    <td>
                        <fmt:formatNumber value="${batter.grossProductionAvg }" minFractionDigits="3"  pattern=".###"/>
                    </td>
                    <td>
                        <fmt:formatNumber value="${batter.battingAvgOnBIP }" minFractionDigits="3"  pattern=".###"/>
                    </td>
                </tr>
                </c:if>
                </c:forEach>
                <tr>
                    <th>Year</th>
                    <c:if test="${param.name != 'TOTAL' }">
                    <th>G</th>
                    </c:if>
                    <th>PA</th>
                    <th>AB</th>
                    <th>H</th>
                    <th>1B</th>
                    <th>2B</th>
                    <th>3B</th>
                    <th>HR</th>
                    <th>R</th>
                    <th>RBI</th>
                    <th>BB</th>
                    <th>SO</th>
                    <th>SB</th>
                    <th>AVG</th>
                    <th>OBP</th>
                    <th>SLG</th>
                    <th>OPS</th>
                    <th>RC</th>
                    <th>RC/21</th>
                    <th>GPA</th>
                    <th>BABIP</th>
                </tr>
            </tfoot>
        </table>
    </div>
    <div id="tabs-2">
    </div>
</div>
<br/>
<a href="/battersStatView.do">DREAM BEARS STATS</a>
</body>
</html>