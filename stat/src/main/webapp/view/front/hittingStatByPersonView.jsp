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
<script type="text/javascript" src="/js/jui-core.min.js"></script>
<script type="text/javascript" src="/js/jui-chart.min.js"></script>
<script type="text/javascript" src="/js/common.js"></script>
<script type="text/javascript">
var data = new Array();
var date;
var avg;
var obp;
var slg;
var ops;
<c:forEach var="stat" items="${reverseList}">
    date = "${stat.year }-<fmt:formatNumber value="${stat.month }" minIntegerDigits="2" />-<fmt:formatNumber value="${stat.date }" minIntegerDigits="2" />";
    avg = "${stat.battingAvg}";
    obp = "${stat.onBasePcg}";
    slg = "${stat.sluggingPcg}";
    ops = "${stat.onBasePlusSlugging}";
    data.push({date : date, avg : avg, obp : obp, slg : slg, ops : ops});
</c:forEach>
jQuery(function($) {
    $("#tabs").tabs({
        active: 3
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
        document.location.href = "/pitcherStatsView.do?name=${param.name}";
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

    adjustTable($("#tabs-4"));

    $(window).resize(function() {
        adjustTable($("#tabs-4"));
    });
});

function drawGraph(data, stat) {
    var max = 1;
    var temp = new Array();
    var title = "";

    if (stat == "avg") {
        title = "AVG";
    } else if (stat == "obp") {
        title = "OBP";
    } else if (stat == "slg") { // max 2.5 ~ 3 사이에 버그, y값이 999999999
        title = "SLG";

        for (var i = 0; i < data.length; i++) {
            temp.push(data[i].slg);
        }

        max = Math.max.apply(null, temp);
        max = Math.ceil(max);
    } else if (stat == "ops") {
        title = "OPS";

        for (var i = 0; i < data.length; i++) {
            temp.push(data[i].ops);
        }
        max = Math.max.apply(null, temp);
        max = Math.ceil(max);
    }

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
    </ul>

    <div id="tabs-4">
        <button id="btnChart">테이블</button>
        <select id="selectStat">
            <option value="avg">AVG</option>
            <option value="obp">OBP</option>
            <option value="slg">SLG</option>
            <option value="ops">OPS</option>
        </select>
        <br/><br/>
        <div id="divTable">
            <table id="table" class="display">
                <thead>
                    <tr>
                        <th>Date</th>
                        <th>#</th>
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
                            ${batter.year }-<fmt:formatNumber value="${batter.month }" minIntegerDigits="2" />-<fmt:formatNumber value="${batter.date }" minIntegerDigits="2" />
                        </th>
                        <td>
                            ${batter.battingOrder }
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
                        <td class="avg">
                            <fmt:formatNumber value="${batter.battingAvg }" minFractionDigits="3" pattern=".###"/>
                        </td>
                        <td class="obp">
                            <fmt:formatNumber value="${batter.onBasePcg }" minFractionDigits="3"  pattern=".###"/>
                        </td>
                        <td class="slg">
                            <fmt:formatNumber value="${batter.sluggingPcg }" minFractionDigits="3"  pattern=".###"/>
                        </td>
                        <td class="ops">
                            <fmt:formatNumber value="${batter.onBasePlusSlugging }" minFractionDigits="3"  pattern=".###"/>
                        </td>
                        <td class="rc">
                            <fmt:formatNumber value="${batter.runsCreated }" minFractionDigits="3"  pattern=".###"/>
                        </td>
                        <td class="rc21">
                            <fmt:formatNumber value="${batter.runsCreated21 }" minFractionDigits="3"  pattern=".###"/>
                        </td>
                        <td class="gpa">
                            <fmt:formatNumber value="${batter.grossProductionAvg }" minFractionDigits="3"  pattern=".###"/>
                        </td>
                        <td class="babip">
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
                        <td>
                            -
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
                        <th>Date</th>
                        <th>#</th>
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
        <div id="divChart" style="display: none;">
        </div>
    </div>
</div>
<br/>
<a href="/battersStatView.do">DREAM BEARS STATS</a>
</body>
</html>