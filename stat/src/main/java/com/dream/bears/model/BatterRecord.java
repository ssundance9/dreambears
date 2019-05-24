package com.dream.bears.model;

public class BatterRecord {
    private long year;
    
    private long month;
    
    private long date;
    
    private String name;
    
    private long games;
    
    private long plateAppears;
    
    private long atBats;
    
    private long hits;
    
    private long singles;
    
    private long doubles;
    
    private long triples;
    
    private long homeRuns;
    
    private long runsScored;
    
    private long runsBattedIn;
    
    private long basesOnBalls;
    
    private long strikeOuts;
    
    private long stolenBases;
    
    private double battingAvg;
    
    private double onBasePcg;
    
    private double sluggingPcg;
    
    private double onBasePlusSlugging;
    
    private double runsCreated;
    
    private double runsCreated21;
    
    private double grossProductionAvg;
    
    private double battingAvgOnBIP;

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

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public long getGames() {
        return games;
    }

    public void setGames(long games) {
        this.games = games;
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

    public long getSingles() {
        return singles;
    }

    public void setSingles(long singles) {
        this.singles = singles;
    }

    public long getDoubles() {
        return doubles;
    }

    public void setDoubles(long doubles) {
        this.doubles = doubles;
    }

    public long getTriples() {
        return triples;
    }

    public void setTriples(long triples) {
        this.triples = triples;
    }

    public long getHomeRuns() {
        return homeRuns;
    }

    public void setHomeRuns(long homeRuns) {
        this.homeRuns = homeRuns;
    }

    public long getRunsScored() {
        return runsScored;
    }

    public void setRunsScored(long runsScored) {
        this.runsScored = runsScored;
    }

    public long getRunsBattedIn() {
        return runsBattedIn;
    }

    public void setRunsBattedIn(long runsBattedIn) {
        this.runsBattedIn = runsBattedIn;
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

    public long getStolenBases() {
        return stolenBases;
    }

    public void setStolenBases(long stolenBases) {
        this.stolenBases = stolenBases;
    }

    public double getBattingAvg() {
        if (this.atBats > 0) {
            double a = ((double) this.hits) / ((double) this.atBats) * 1000D;
            return Math.round(a) / 1000D;
        } else {
            return 0D;
        }
    }
    
    public double getOnBasePcg() {
        if (this.plateAppears > 0) {
            double a = ((double) (this.hits + this.basesOnBalls)) / ((double) this.plateAppears) * 1000D;
            return Math.round(a) / 1000D;
        } else {
            return 0D;
        }
    }

    public double getSluggingPcg() {
        double a = ((double) (this.singles + 2 * this.doubles + 3 * this.triples + 4 * this.homeRuns)) / ((double) this.atBats) * 1000D;
        return Math.round(a) / 1000D;
    }
    
    public double getOnBasePlusSlugging() {
        double a = (getOnBasePcg() + getSluggingPcg()) * 1000D;
        return Math.round(a) / 1000D;
    }
    
    public double getRunsCreated() {
        double a = ((double) (this.hits + this.basesOnBalls)) * (getSluggingPcg() * ((double) this.atBats) + 0.52D * ((double) this.stolenBases) + 0.26D * ((double) this.basesOnBalls)) / ((double) this.plateAppears) * 1000D;
        return Math.round(a) / 1000D;
    }
    
    public double getRunsCreated21() {
        if (this.atBats - this.hits > 0) {
            double a = getRunsCreated() / ((double) this.atBats - this.hits) * 21D * 1000D;
            return Math.round(a) / 1000D;
        } else {
            return 0D;
        }
    }
    
    public double getGrossProductionAvg() {
        double a = (getOnBasePcg() * 1.8D + getSluggingPcg()) / 4D * 1000D;
        return Math.round(a) / 1000D;
    }
    
    public double getBattingAvgOnBIP() {
        double a = ((double) this.hits - this.homeRuns) / ((double) this.atBats - this.homeRuns - this.strikeOuts) * 1000D;
        return Math.round(a) / 1000D;
    }

}
