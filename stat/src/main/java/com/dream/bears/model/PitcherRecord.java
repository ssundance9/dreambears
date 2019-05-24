package com.dream.bears.model;

public class PitcherRecord {
    private long year;
    
    private long month;
    
    private long date;
    
    private long gameSeq;
    
    private String name;
    
    private long wins;
    
    private long losses;
    
    private long saves;
    
    private double inningsPitched;
    
    private long plateAppears;
    
    private long atBats;
    
    private long hits;
    
    private long homeRuns;
    
    private long sacrificeFly;
    
    private long basesOnBalls;
    
    private long strikeOuts;
    
    private long runs;
    
    private long earnedRuns;
    
    private double earnedRunAvg;
    
    private double battingAvg;
    
    private double walksHitsIP;
    
    private double fieldingIndependentPitching;

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

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public long getWins() {
        return wins;
    }

    public void setWins(long wins) {
        this.wins = wins;
    }

    public long getLosses() {
        return losses;
    }

    public void setLosses(long losses) {
        this.losses = losses;
    }

    public long getSaves() {
        return saves;
    }

    public void setSaves(long saves) {
        this.saves = saves;
    }

    public double getInningsPitched() {
        double a = inningsPitched * 10D;
        return Math.round(a) / 10D;
    }

    public void setInningsPitched(double inningsPitched) {
        this.inningsPitched = inningsPitched;
    }

    public long getPlateAppears() {
        return plateAppears;
    }

    public void setPlateAppears(long plateAppears) {
        this.plateAppears = plateAppears;
    }

    public long getAtBats() {
        return atBats;
    }

    public void setAtBats(long atBats) {
        this.atBats = atBats;
    }

    public long getHits() {
        return hits;
    }

    public void setHits(long hits) {
        this.hits = hits;
    }

    public long getHomeRuns() {
        return homeRuns;
    }

    public void setHomeRuns(long homeRuns) {
        this.homeRuns = homeRuns;
    }

    public long getSacrificeFly() {
        return sacrificeFly;
    }

    public void setSacrificeFly(long sacrificeFly) {
        this.sacrificeFly = sacrificeFly;
    }

    public long getBasesOnBalls() {
        return basesOnBalls;
    }

    public void setBasesOnBalls(long basesOnBalls) {
        this.basesOnBalls = basesOnBalls;
    }

    public long getStrikeOuts() {
        return strikeOuts;
    }

    public void setStrikeOuts(long strikeOuts) {
        this.strikeOuts = strikeOuts;
    }

    public long getRuns() {
        return runs;
    }

    public void setRuns(long runs) {
        this.runs = runs;
    }

    public long getEarnedRuns() {
        return earnedRuns;
    }

    public void setEarnedRuns(long earnedRuns) {
        this.earnedRuns = earnedRuns;
    }

    public double getEarnedRunAvg() {
        if (this.inningsPitched > 0) {
            double a = ((double) this.earnedRuns) / ((double) this.inningsPitched) * 7D * 100D;
            return Math.round(a) / 100D;
        } else {
            return 0D;
        }
    }

    public double getBattingAvg() {
        if (this.atBats > 0) {
            double a = ((double) this.hits) / ((double) this.atBats) * 1000D;
            return Math.round(a) / 1000D;
        } else {
            return 0D;
        }
    }

    public double getWalksHitsIP() {
        if (this.inningsPitched > 0) {
            double a = (((double) this.hits) + ((double) this.basesOnBalls)) / ((double) this.inningsPitched) * 100D;
            return Math.round(a) / 100D;
        } else {
            return 0D;
        }
    }
    
    public double getFieldingIndependentPitching() {
        if (this.inningsPitched > 0) {
            double a = ((13 * ((double) this.homeRuns) + 3 * ((double) this.basesOnBalls) - 2 * ((double) this.strikeOuts)) / ((double) this.inningsPitched) + 3.2D) * 100D;
            return Math.round(a) / 100D;
        } else {
            return 0D;
        }
    }
}
