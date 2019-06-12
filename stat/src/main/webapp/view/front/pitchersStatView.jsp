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
    $("#tabs").tabs({
        active: 1
    });

    $("#selectPitcherYear").selectmenu({
        width : 100
        , change : function(event, ui) {
            document.location.href="/pitchersStatView.do?year=" + $(this).val();
        }
    });

    $("#table").DataTable({
        paging: false,
        info: false,
        searching: false,
        fixedColumns: true,
        scrollCollapse: true,
        scrollX: true,
        columnDefs: [
            { width: 60, targets: 0 }
        ]
    });

    $("#goBatters").on("click", function() {
        document.location.href = "/battersStatView.do";
    });

    $("#goTeam").on("click", function() {
        document.location.href = "/teamStatsView.do";
    });

    $("#goHittingSeason").on("click", function() {
        document.location.href = "/hittingStatBySeasonView.do?season=2019";
    });

    $("#goPitchingSeason").on("click", function() {
        document.location.href = "/pitchingStatBySeasonView.do?season=2019";
    });

    $("#title").on("click", function() {
        document.location.href = "/battersStatView.do";
    });

    $("#btnFilter").on("click", function() {
        var ip = "${ip}";
        if (ip == "40") {
            document.location.href = "/pitchersStatView.do?year=9999";
        } else {
            document.location.href = "/pitchersStatView.do?year=9999&ip=40";
        }
    });

    adjustTable($("#tabs-2"));

    $(window).resize(function() {
        adjustTable($("#tabs-2"));
    });
})
</script>
</head>
<body>

<h2 id="title">DREAM BEARS STATS</h2>
<div id="tabs">
    <ul>
        <li><a href="#tabs-1" id="goBatters">타격</a></li>
        <li><a href="#tabs-2">투구</a></li>
        <li><a href="#tabs-3" id="goTeam">팀</a></li>
        <li><a href="#tabs-4" id="goHittingSeason">타격(2019)</a></li>
        <li><a href="#tabs-5" id="goPitchingSeason">투구(2019)</a></li>
    </ul>
    <div id="tabs-1">
    </div>
    <div id="tabs-2">
        연도
        <select name="year" id="selectPitcherYear">
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

        <c:if test="${year == '9999' }">
            <c:if test="${ip == '40' }">
                <button id="btnFilter">모든 이닝</button>
            </c:if>
            <c:if test="${ip != '40' }">
                <button id="btnFilter">40이닝 이상</button>
            </c:if>
        </c:if>

        <br/>
        <br/>
        <table id="table" class="display">
            <thead>
                <tr>
                    <th>Player</th>
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
            <c:forEach var="pitcher" items="${list}" varStatus="vs">
                <c:if test="${pitcher.name != 'TOTAL' }">
                <tr>
                    <th style="text-align: center;">
                        <a href="/pitcherStatsView.do?name=${pitcher.name }">${pitcher.name }</a>
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
                <c:forEach var="pitcher" items="${list}" varStatus="vs">
                <c:if test="${pitcher.name == 'TOTAL' }">
                <tr>
                    <th>
                        <a href="/pitcherStatsView.do?name=${pitcher.name }">${pitcher.name }</a>
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
                    <th>Player</th>
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
    <div id="tabs-3">
    </div>
</div>
<br/>
<a href="/battersStatView.do">DREAM BEARS STATS</a>

</body>
</html>