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
        active: 4
    });

    $("#selectSeason").selectmenu({
        width : 200
        , change : function(event, ui) {
            var a = ui.item; // javascript object
            var b = ui.item.element; // jqueryObject (selected option)

            /* if (a.value == "graph") {
                document.location.href = "/hittingStatByGameWithGraph.do?&season=" + b.data("season");
            } else {
                document.location.href = "/hittingStatByGameView.do?seq=" + a.value + "&season=" + b.data("season");
            } */
        }
    });

    $("#btnChart, #btnGame").button();

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

    $("#title").on("click", function() {
        document.location.href = "/battersStatView.do";
    });

    $("#btnChart").on("click", function() {
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
    });

    $("#btnGame").on("click", function() {
        document.location.href = "/pitchingStatByGameView.do?season=" + $("#selectSeason").val();
    });

    adjustTable($("#tabs-5"));

    $(window).resize(function() {
        adjustTable($("#tabs-5"));
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
                    domain : [0, 10],
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
                target : ["era", "avg", "whip", "fip"]
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
        <li><a href="#tabs-5">투구(2019)</a></li>
    </ul>
    <div id="tabs-5">
        <button id="btnGame">시즌</button>
        <select name="year" id="selectSeason">
            <%-- <option value="9999" <c:if test="${param.year == 9999}">selected="selected"</c:if>>통산</option> --%>
            <option value="2019" <c:if test="${param.year == 2019}">selected="selected"</c:if>>2019</option>
            <%-- <option value="2018" <c:if test="${param.year == 2018}">selected="selected"</c:if>>2018</option>
            <option value="2017" <c:if test="${param.year == 2017}">selected="selected"</c:if>>2017</option>
            <option value="2016" <c:if test="${param.year == 2016}">selected="selected"</c:if>>2016</option>
            <option value="2015" <c:if test="${param.year == 2015}">selected="selected"</c:if>>2015</option>
            <option value="2014" <c:if test="${param.year == 2014}">selected="selected"</c:if>>2014</option>
            <option value="2013" <c:if test="${param.year == 2013}">selected="selected"</c:if>>2013</option>
            <option value="2012" <c:if test="${param.year == 2012}">selected="selected"</c:if>>2012</option>
            <option value="2011" <c:if test="${param.year == 2011}">selected="selected"</c:if>>2011</option>
            <option value="2010" <c:if test="${param.year == 2010}">selected="selected"</c:if>>2010</option>
            <option value="2009" <c:if test="${param.year == 2009}">selected="selected"</c:if>>2009</option> --%>
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
                        <th>G</th>
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
                            <a href="/pitcherStatsView.do?name=${pitcher.name }">${pitcher.name }</a>
                        </th>
                        <td>
                            ${pitcher.games }
                        </td>
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
                            <a href="/pitcherStatsView.do?name=${pitcher.name }">${pitcher.name }</a>
                        </th>
                        <td>
                            -
                        </td>
                        <td>
                            -
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
                        <th>Player</th>
                        <th>G</th>
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