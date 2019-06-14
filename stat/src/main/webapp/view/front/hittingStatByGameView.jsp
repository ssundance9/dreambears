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
jQuery(function($) {
    $("#tabs").tabs({
        active: 3
    });

    $("#selectGameDate").selectmenu({
        width : 200
        , change : function(event, ui) {
            var a = ui.item; // javascript object
            var b = ui.item.element; // jqueryObject (selected option)

            if (a.value == "graph") {
                document.location.href = "/hittingStatByGameWithGraph.do?&season=" + b.data("season");
            } else {
                document.location.href = "/hittingStatByGameView.do?seq=" + a.value + "&season=" + b.data("season");
            }
        }
    });

    $("#btnChart, #btnSeason").button();

    $("#table").DataTable({
        paging: false,
        info: false,
        searching: false,
        fixedColumns: true,
        scrollCollapse: true,
        scrollX: true,
        columnDefs: [
            { width: 60, targets: 0 }
        ],
        order: [[ 1, "asc" ], [2, "desc"]]
    });

    $("#goBatters").on("click", function() {
        document.location.href = "/battersStatView.do";
    });

    $("#goPitchers").on("click", function() {
        document.location.href = "/pitchersStatView.do";
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
            var data = new Array();

            $("#table tbody tr").each(function() {
                var name = $(this).find("th a").text().trim();
                var avg;
                var obp;
                var slg;
                var ops;
                $(this).find("td").each(function() {
                    if ($(this).hasClass("avg")) {
                        avg = $(this).text().trim();
                    }
                    if ($(this).hasClass("obp")) {
                        obp = $(this).text().trim();
                    }
                    if ($(this).hasClass("slg")) {
                        slg = $(this).text().trim();
                    }
                    if ($(this).hasClass("ops")) {
                        ops = $(this).text().trim();
                    }
                });

                data.push({name : name, avg : avg, obp : obp, slg : slg, ops : ops});
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
    });

    $("#btnSeason").on("click", function() {
        document.location.href = "/hittingStatBySeasonView.do?season=" + $("#selectGameDate option:selected").data("season");
    });

    adjustTable($("#tabs-4"));

    $(window).resize(function() {
        adjustTable($("#tabs-4"));
    });
});

function drawGraph(data) {
    graph.ready([ "chart.builder" ], function(builder) {
        builder("#divChart", {
            width: $("body").width() - 30,
            height: 600,
            axis : {
                x : {
                    type : "range",
                    domain : [0, 2],
                    step : 10,
                    line : true
                },
                y : {
                    type : "block",
                    domain : "name",
                    line : true
                },
                data : data
            },
            brush : {
                type : "bar",
                target : ["avg", "obp", "slg", "ops"]
            },
            widget : [
                //{ type : "title", text : "Hitting" },
                { type : "tooltip", orient: "right" },
                { type : "legend" }
            ]
        });
    });
}
</script>
</head>
<body>

<h2 id="title">DREAM BEARS STATS</h2>
<div id="tabs">
    <ul>
        <li><a href="#tabs-1" id="goBatters">타격</a></li>
        <li><a href="#tabs-2" id="goPitchers">투구</a></li>
        <li><a href="#tabs-3" id="goTeam">팀</a></li>
        <li><a href="#tabs-4" id="goHittingSeason">타격(2019)</a></li>
        <li><a href="#tabs-5" id="goPitchingSeason">투구(2019)</a></li>
        <li><a href="#tabs-6" id="goTeamSeason">팀(2019)</a></li>
    </ul>

    <div id="tabs-4">
        <button id="btnSeason">게임</button>
        <select name="gameDate" id="selectGameDate">
            <c:forEach var="game" items="${gameList }">
            <option data-season="${game.season }" value="${game.seq }" <c:if test="${game.seq == param.seq }">selected="selected"</c:if>>
                <fmt:formatNumber value="${game.month }" minIntegerDigits="2" />-<fmt:formatNumber value="${game.date }" minIntegerDigits="2" /> vs ${game.opponent }
            </option>
            </c:forEach>
            <%-- <option data-season="${param.season }" value="graph">그래프</option> --%>
        </select>
        <br/><br/>
        <button id="btnChart">테이블</button>
        <br/>
        <br/>
        <div id="divTable">
            <table id="table" class="display">
                <thead>
                    <tr>
                        <th>Player</th>
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
                <c:forEach var="batter" items="${list}" varStatus="vs">
                    <c:if test="${batter.name != 'TOTAL' }">
                    <tr>
                        <th style="text-align: center;">
                            <a href="/hittingStatByPersonView.do?season=${batter.season }&name=${batter.name }">${batter.name }</a>
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
                    <c:forEach var="batter" items="${list}" varStatus="vs">
                    <c:if test="${batter.name == 'TOTAL' }">
                    <tr>
                        <th>
                            TOTAL
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
                        <th>Player</th>
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