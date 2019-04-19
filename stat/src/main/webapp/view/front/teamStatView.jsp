<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Dream Bears Stat</title>
<link rel="stylesheet" type="text/css" href="/css/jquery-ui.min.css">
<link rel="stylesheet" type="text/css" href="/css/jquery-ui.structure.min.css">
<link rel="stylesheet" type="text/css" href="/css/jquery-ui.theme.min.css">
<style>
  table {
    width: 100%;
    border-top: 1px solid #444444;
    border-collapse: collapse;
  }
  th {
    text-align: center;
    border-bottom: 1px solid #444444;
    padding: 3px;
  }
  tr {
    text-align: right;
  }
  td {
    border-bottom: 1px solid #444444;
    padding: 3px;
  }
</style>

<script type="text/javascript"  src="/js/jquery-3.4.0.min.js"></script>
<script type="text/javascript"  src="/js/jquery-ui.min.js"></script>
<script type="text/javascript">
jQuery(function($) {
	$( "#tabs" ).tabs();
	
    $("#selectBatterYear").on("change", function() {
    	document.location.href="/main.do?year=" + $(this).val();
    });
})
</script>
</head>
<body>

<h2>DREAM BEARS STAT</h2>
<div id="tabs">
    <ul>
        <li><a href="#tabs-1">타자</a></li>
        <li><a href="#tabs-2">투수</a></li>
        <li><a href="#tabs-3">팀</a></li>
    </ul>
    <div id="tabs-1">
        연도
        <select name="year" id="selectBatterYear">
            <option value="2009" <c:if test="${year == 2009}">selected="selected"</c:if>>2009</option>
            <option value="2010" <c:if test="${year == 2010}">selected="selected"</c:if>>2010</option>
            <option value="2011" <c:if test="${year == 2011}">selected="selected"</c:if>>2011</option>
            <option value="2012" <c:if test="${year == 2012}">selected="selected"</c:if>>2012</option>
            <option value="2013" <c:if test="${year == 2013}">selected="selected"</c:if>>2013</option>
            <option value="2014" <c:if test="${year == 2014}">selected="selected"</c:if>>2014</option>
            <option value="2015" <c:if test="${year == 2015}">selected="selected"</c:if>>2015</option>
            <option value="2016" <c:if test="${year == 2016}">selected="selected"</c:if>>2016</option>
            <option value="2017" <c:if test="${year == 2017}">selected="selected"</c:if>>2017</option>
            <option value="2018" <c:if test="${year == 2018}">selected="selected"</c:if>>2018</option>
            <option value="2019" <c:if test="${year == 2019}">selected="selected"</c:if>>2019</option>
            <option value="0000" <c:if test="${year == 0000}">selected="selected"</c:if>>통산</option>
        </select>
        <br/>
        <br/>
        <table>
            <tr>
                <th style="text-align: left;">Player</th>
                <th>G</th>
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
            <c:forEach var="batter" items="${list}">
                <tr>
                    <td style="text-align: left;">
                        ${batter.name }
                    </td>
                    <td>
                        ${batter.games }
                    </td>
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
                    <td >
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
            </c:forEach>
        </table>
    </div>
    <div id="tabs-2">
    </div>
    <div id="tabs-3">
    </div>
</div>
<br/>
<!-- <a href="/back/createBatterRecordView.do">기록입력</a> -->




</body>
</html>