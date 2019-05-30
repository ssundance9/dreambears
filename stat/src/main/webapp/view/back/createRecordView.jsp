<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Dream Bears Stat</title>
<link rel="stylesheet" type="text/css" href="/css/jquery-ui.min.css">
<link rel="stylesheet" type="text/css" href="/css/jquery-ui.theme.min.css">
<script type="text/javascript"  src="/js/jquery-3.4.0.min.js"></script>
<script type="text/javascript"  src="/js/jquery-ui.min.js"></script>
</head>
<body>
<form name="createForm" action="/back/createBatterRecord.do" method="post">
    연도<select name="year">
            <option value="2009">2009</option>
            <option value="2010">2010</option>
            <option value="2011">2011</option>
            <option value="2012">2012</option>
            <option value="2013">2013</option>
            <option value="2014">2014</option>
            <option value="2015">2015</option>
            <option value="2016">2016</option>
            <option value="2017">2017</option>
            <option value="2018">2018</option>
            <option value="2019">2019</option>
        </select>
    <br/>
    타자기록<textarea name="recordStr" rows="20" cols="50"></textarea>
    <button type="submit">입력</button>
</form>
<br/>
<form name="createForm" action="/back/createPitcherRecord.do" method="post">
    연도<select name="year">
            <option value="2009">2009</option>
            <option value="2010">2010</option>
            <option value="2011">2011</option>
            <option value="2012">2012</option>
            <option value="2013">2013</option>
            <option value="2014">2014</option>
            <option value="2015">2015</option>
            <option value="2016">2016</option>
            <option value="2017">2017</option>
            <option value="2018">2018</option>
            <option value="2019">2019</option>
        </select>
    <br/>
    투수기록<textarea name="recordStr" rows="20" cols="50"></textarea>
    <button type="submit">입력</button>
</form>
<br/>
<form name="createForm" action="/back/createTeamRecord.do" method="post">
    팀기록<textarea name="recordStr" rows="20" cols="50"></textarea>
    <button type="submit">입력</button>
</form>
<br/>
<form name="createForm" action="/back/createBatterRecordByDate.do" method="post">
    <input type="text" name="season" value=""/>시즌
    <br/>
    <input type="text" name="year" value=""/>년 <input type="text" name="month" value=""/>월 <input type="text" name="date" value=""/>일 <input type="text" name="gameSeq" value="1"/>gameSeq
    <br/>
    경기별타자기록<textarea name="recordStr" rows="20" cols="100"></textarea>
    <button type="submit">입력</button>
</form>
<br/>
<form name="createForm" action="/back/createPitcherRecordByDate.do" method="post">
    <input type="text" name="season" value=""/>시즌
    <br/>
    <input type="text" name="year" value=""/>년 <input type="text" name="month" value=""/>월 <input type="text" name="date" value=""/>일 <input type="text" name="gameSeq" value="1"/>gameSeq
    <br/>
    경기별투수기록<textarea name="recordStr" rows="20" cols="100"></textarea>
    <button type="submit">입력</button>
</form>
<br/>
<form name="createForm" action="/back/createTeamRecordByDate.do" method="post">
    <input type="text" name="season" value=""/>시즌
    <br/>
    팀기록<textarea name="recordStr" rows="20" cols="100"></textarea>
    <button type="submit">입력</button>
</form>
<br/>
<a href="/main.do">메인</a>
<br/>
<a href="/selectTest.do">쿼리테스트</a>
</body>
</html>