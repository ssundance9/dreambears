package com.dream.bears.model;

public class TeamRecord {
    private long year;

    private long month;

    private long date;

    private long gameSeq;

    private String ballPark;

    private String type;

    private String homeAway;

    private String result;

    private String opponent;

    private long wins;

    private long draws;

    private long losses;

    private long totalGames;

    private double winPcg;

    public long getYear() {
        return year;
    }

    public void setYear(long year) {
        this.year = year;
    }

    public long getMonth() {
        return month;
    }

    public void setMonth(long month) {
        this.month = month;
    }

    public long getDate() {
        return date;
    }

    public void setDate(long date) {
        this.date = date;
    }

    public long getGameSeq() {
        return gameSeq;
    }

    public void setGameSeq(long gameSeq) {
        this.gameSeq = gameSeq;
    }

    public String getBallPark() {
        return ballPark;
    }

    public void setBallPark(String ballPark) {
        this.ballPark = ballPark;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getHomeAway() {
        return homeAway;
    }

    public void setHomeAway(String homeAway) {
        this.homeAway = homeAway;
    }

    public String getResult() {
        return result;
    }

    public void setResult(String result) {
        this.result = result;
    }

    public String getOpponent() {
        return opponent;
    }

    public void setOpponent(String opponent) {
        this.opponent = opponent;
    }

    public long getWins() {
        return wins;
    }

    public void setWins(long wins) {
        this.wins = wins;
    }

    public long getDraws() {
        return draws;
    }

    public void setDraws(long draws) {
        this.draws = draws;
    }

    public long getLosses() {
        return losses;
    }

    public void setLosses(long losses) {
        this.losses = losses;
    }

    public long getTotalGames() {
        return totalGames;
    }

    public void setTotalGames(long totalGames) {
        this.totalGames = totalGames;
    }

    public double getWinPcg() {
        if (this.wins + this.draws + this.losses > 0) {
            double a = ((double) (this.wins)) / ((double) (this.wins + this.draws + this.losses)) * 1000D;
            return Math.round(a) / 1000D;
        } else {
            return 0D;
        }
    }
}
