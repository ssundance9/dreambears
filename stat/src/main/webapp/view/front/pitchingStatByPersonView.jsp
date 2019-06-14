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
<script type="text/javascript" src="/js/jquery-3.4.0.min.js"></script>
<script type="text/javascript" src="/js/jquery-ui.min.js"></script>
<script type="text/javascript" src="/js/datatables.min.js"></script>
<script type="text/javascript" src="/js/jui-core.min.js"></script>
<script type="text/javascript" src="/js/jui-chart.min.js"></script>
<script type="text/javascript" src="/js/common.js"></script>
<script type="text/javascript">
var data = new Array();
var date;
var era;
var avg;
var whip;
var fip;
<c:forEach var="stat" items="${reverseList}" varStatus="vs">
    <c:if test="${vs.index > 0}">
    date = "${stat.year }-<fmt:formatNumber value="${stat.month }" minIntegerDigits="2" />-<fmt:formatNumber value="${stat.date }" minIntegerDigits="2" />";
    era = "${stat.earnedRunAvg}";
    avg = "${stat.battingAvg}";
    whip = "${stat.walksHitsIP}";
    fip = "${stat.fieldingIndependentPitching}";
    data.push({date : date, era : era, avg : avg, whip : whip, fip : fip});
    </c:if>
</c:forEach>
jQuery(function($) {
    $("#tabs").tabs({
        active: 4
    });

    $("#btnChart").button();

    $("#selectStat").selectmenu({
        width : 100
        , change : function(event, ui) {
            $("#divChart").html("");
            drawGraph(data, $(this).val());
        }
        , disabled : true
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

    $("#goBatters").on("click", function() {
        document.location.href = "/battersStatView.do";
    });

    $("#goPitchers").on("click", function() {
        document.location.href = "/pitchersStatsView.do";
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

    $("#goTeamSeason").on("click", function() {
        document.location.href = "/teamStatBySeasonView.do?season=2019";
    });

    $("#title").on("click", function() {
        document.location.href = "/battersStatView.do";
    });

    $("#btnChart").on("click", function() {
        if ($("#divTable").css("display") == "block") {
            $("#divChart").html("");
            drawGraph(data, $("#selectStat").val());

            $(this).text("그래프");
            $("#divTable").hide();
            $("#divChart").show();
            $("#selectStat").selectmenu({disabled : false});
        } else {
            $(this).text("테이블");
            $("#divTable").show();
            $("#divChart").html("").hide();
            $("#selectStat").selectmenu({disabled : true});
        }
    });

    /* $("#btnChart").on("click", function() {
        if ($("#divTable").css("display") == "block") {
            var data = new Array();

            $("#table tbody tr").each(function() {
                var name = $(this).find("th a").text().trim();
                var era;
                var avg;
                var whip;
                var fip;
                $(this).find("td").each(function() {
                    if ($(this).hasClass("era")) {
                        era = $(this).text().trim();
                    }
                    if ($(this).hasClass("avg")) {
                        avg = $(this).text().trim();
                    }
                    if ($(this).hasClass("whip")) {
                        whip = $(this).text().trim();
                    }
                    if ($(this).hasClass("fip")) {
                        fip = $(this).text().trim();
                    }
                });

                data.push({name : name, era : era, avg : avg, whip : whip, fip : fip});
            });

            drawGraph(data);

            $(this).text("그래프");
            $("#divTable").hide();
            $("#divChart").show();
        } else {
            $(this).text("테이블");
            $("#divTable").show();
            $("#divChart").html("").hide();
        }
    }); */

    adjustTable($("#tabs-5"));

    $(window).resize(function() {
        adjustTable($("#tabs-5"));
    });
});

function drawGraph(data, stat) {
    var max = 1;
    var temp = new Array();
    var title = "";

    if (stat == "era") {
        title = "ERA";

        for (var i = 0; i < data.length; i++) {
            temp.push(data[i].era);
        }
        max = Math.max.apply(null, temp);
    } else if (stat == "avg") {
        title = "AVG";
    } else if (stat == "whip") { // max 2.5 ~ 3 사이에 버그, y값이 999999999
        title = "WHIP";

        for (var i = 0; i < data.length; i++) {
            temp.push(data[i].whip);
        }
        max = Math.max.apply(null, temp);
    } else if (stat == "fip") {
        title = "FIP";

        for (var i = 0; i < data.length; i++) {
            temp.push(data[i].fip);
        }
        max = Math.max.apply(null, temp);
    }

    max = Math.ceil(max);

    graph.ready([ "chart.builder" ], function(builder) {
        builder("#divChart", {
            width: $("body").width() - 30,
            height: 600,
            axis : {
                x : {
                    type : "fullblock",
                    domain : "date",
                    line : true,
                    reverse : true,
                    textRotate : -20
                },
                y : {
                    type : "range",
                    domain : [0, max],
                    step : 10
                },
                data : data
            },
            brush : [{
                type : "line"
                , target : stat
            }, {
                type : "scatter"
                , target : stat
            }],
            widget : [
                { type : "title", text : title },
                { type : "legend" },
                { type : "tooltip", brush : 1 }
            ]
        });
    });
}
</script>
</head>
<body>

<h2><span id="title">DREAM BEARS STATS</span> - ${param.name }</h2>
<div id="tabs">
    <ul>
        <li><a href="#tabs-1" id="goBatters">타격</a></li>
        <li><a href="#tabs-2" id="goPitchers">투구</a></li>
        <li><a href="#tabs-3" id="goTeam">팀</a></li>
        <li><a href="#tabs-4" id="goHittingSeason">타격(2019)</a></li>
        <li><a href="#tabs-5" id="goPitchingSeason">투구(2019)</a></li>
        <li><a href="#tabs-6" id="goTeamSeason">팀(2019)</a></li>
    </ul>
    <div id="tabs-5">
        <button id="btnChart">테이블</button>
        <select id="selectStat">
            <option value="era">ERA</option>
            <option value="avg">AVG</option>
            <option value="whip">WHIP</option>
            <option value="fip">FIP</option>
        </select>
        <br/><br/>
        <div id="divTable">
            <table id="table" class="display">
                <thead>
                    <tr>
                        <th>Date</th>
                        <th>GS</th>
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
                            <fmt:formatNumber value="${pitcher.month }" minIntegerDigits="2" />-<fmt:formatNumber value="${pitcher.date }" minIntegerDigits="2" />
                        </th>
                        <td>
                            <c:if test="${pitcher.gameStarted == 1 }">S</c:if>
                            <c:if test="${pitcher.gameStarted != 1 }">R</c:if>
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
                        <td class="era">
                            <fmt:formatNumber value="${pitcher.earnedRunAvg }" minFractionDigits="2" pattern=".##"/>
                        </td>
                        <td class="avg">
                            <fmt:formatNumber value="${pitcher.battingAvg }" minFractionDigits="3"  pattern=".###"/>
                        </td>
                        <td class="whip">
                            <fmt:formatNumber value="${pitcher.walksHitsIP }" minFractionDigits="2"  pattern=".##"/>
                        </td>
                        <td class="fip">
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
                            TOTAL
                        </th>
                        <td>
                            ${pitcher.gameStarted }
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
                        <th>Date</th>
                        <th>GS</th>
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
    <div id="divChart" style="display: none;">
    </div>
</div>
<br/>
<a href="/battersStatView.do">DREAM BEARS STATS</a>

</body>
</html>