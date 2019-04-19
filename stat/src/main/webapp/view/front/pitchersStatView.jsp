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
    $("#tabs").tabs({
    	active: 1
    });
	
    $("#selectPitcherYear").on("change", function() {
    	document.location.href="/pitchersStatView.do?year=" + $(this).val();
    });
    
    $("#goBatters").on("click", function() {
    	document.location.href = "/main.do";
    });
})
</script>
</head>
<body>

<h2>DREAM BEARS STAT</h2>
<div id="tabs">
    <ul>
        <li><a href="#tabs-1" id="goBatters">타자</a></li>
        <li><a href="#tabs-2">투수</a></li>
        <li><a href="#tabs-3">팀</a></li>
    </ul>
    <div id="tabs-1">
    </div>
    <div id="tabs-2">
        연도
        <select name="year" id="selectPitcherYear">
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
            <option value="9999" <c:if test="${year == 9999}">selected="selected"</c:if>>통산</option>
        </select>
        <br/>
        <br/>
        <table>
            <tr>
                <th style="text-align: left;">Player</th>
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
            <c:forEach var="pitcher" items="${list}">
                <tr>
                    <td style="text-align: left;">
                        ${pitcher.name }
                    </td>
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
                    <td >
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
            </c:forEach>
        </table>
    </div>
    <div id="tabs-3">
    </div>
</div>
<br/>
<!-- <a href="/back/createBatterRecordView.do">기록입력</a> -->

</body>
</html>