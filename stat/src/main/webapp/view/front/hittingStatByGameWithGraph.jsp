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
var stat;
var statList = new Array();
<c:forEach var="statList" items="${list}">
stat = new Array();

<c:forEach var="stat" items="${statList}">
stat.push({name : "${stat.name}", avg : "${stat.battingAvg}", obp : "${stat.onBasePcg}", slg : "${stat.sluggingPcg}", ops : "${stat.onBasePlusSlugging}"});
</c:forEach>

statList.push(stat);
</c:forEach>
jQuery(function($) {
    $("#tabs").tabs({
        active: 3
    });

    $("#selectGameDate").selectmenu({
        width : 250
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
    //$("#btnChart, #btnSeason").button();

    /* $("#table").DataTable({
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
    }); */

    $("#goBatters").on("click", function() {
        document.location.href = "/battersStatView.do";
    });

    $("#goPitchers").on("click", function() {
        document.location.href = "/pitchersStatView.do";
    });

    $("#goTeam").on("click", function() {
        document.location.href = "/teamStatsView.do";
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

    /* $("#btnSeason").on("click", function() {
        document.location.href = "/hittingStatBySeasonView.do?season=" + $("#selectGameDate option:selected").data("season");
    }); */

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
        <li><a href="#tabs-4">타격G</a></li>
    </ul>

    <div id="tabs-4">
        <!-- <button id="btnSeason">게임</button> -->

        <select name="gameDate" id="selectGameDate">
            <c:forEach var="game" items="${gameList }">
            <option data-season="${game.season }" value="${game.seq }" <c:if test="${game.seq == param.seq }">selected="selected"</c:if>>${game.year }-${game.month }-${game.date } vs ${game.opponent }</option>
            </c:forEach>
            <option data-season="${game.season }" value="graph">그래프</option>
        </select>
        <br/>
        <!-- <button id="btnChart">테이블</button> -->

        <div id="divChart">
        1111
        </div>
    </div>
</div>
<br/>
<a href="/battersStatView.do">DREAM BEARS STATS</a>

</body>
</html>