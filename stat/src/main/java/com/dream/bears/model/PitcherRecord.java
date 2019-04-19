package com.dream.bears.model;

public class PitcherRecord {
    private Long year;
    
    private String name;
    
    private Long wins;
    
    private Long losses;
    
    private Long saves;
    
    private Double inningsPitched;
    
    private Long plateAppears;
    
    private Long atBats;
    
    private Long hits;
    
    private Long homeRuns;
    
    private Long sacrificeFly;
    
    private Long basesOnBalls;
    
    private Long strikeOuts;
    
    private Long runs;
    
    private Long earnedRuns;
    
    private Double earnedRunAvg;
    
    private Double battingAvg;
    
    private Double walksHitsIP;
    
    private Double fieldingIndependentPitching;

    public Long getYear() {
        return year;
    }

    public void setYear(Long year) {
        this.year = year;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Long getWins() {
        return wins;
    }

    public void setWins(Long wins) {
        this.wins = wins;
    }

    public Long getLosses() {
        return losses;
    }

    public void setLosses(Long losses) {
        this.losses = losses;
    }

    public Long getSaves() {
        return saves;
    }

    public void setSaves(Long saves) {
        this.saves = saves;
    }

    public Double getInningsPitched() {
        return inningsPitched;
    }

    public void setInningsPitched(Double inningsPitched) {
        this.inningsPitched = inningsPitched;
    }

    public Long getPlateAppears() {
        return plateAppears;
    }

    public void setPlateAppears(Long plateAppears) {
        this.plateAppears = plateAppears;
    }

    public Long getAtBats() {
        return atBats;
    }

    public void setAtBats(Long atBats) {
        this.atBats = atBats;
    }

    public Long getHits() {
        return hits;
    }

    public void setHits(Long hits) {
        this.hits = hits;
    }

    public Long getHomeRuns() {
        return homeRuns;
    }

    public void setHomeRuns(Long homeRuns) {
        this.homeRuns = homeRuns;
    }

    public Long getSacrificeFly() {
        return sacrificeFly;
    }

    public void setSacrificeFly(Long sacrificeFly) {
        this.sacrificeFly = sacrificeFly;
    }

    public Long getBasesOnBalls() {
        return basesOnBalls;
    }

    public void setBasesOnBalls(Long basesOnBalls) {
        this.basesOnBalls = basesOnBalls;
    }

    public Long getStrikeOuts() {
        return strikeOuts;
    }

    public void setStrikeOuts(Long strikeOuts) {
        this.strikeOuts = strikeOuts;
    }

    public Long getRuns() {
        return runs;
    }

    public void setRuns(Long runs) {
        this.runs = runs;
    }

    public Long getEarnedRuns() {
        return earnedRuns;
    }

    public void setEarnedRuns(Long earnedRuns) {
        this.earnedRuns = earnedRuns;
    }

    public Double getEarnedRunAvg() {
        if (this.inningsPitched > 0) {
            Double a = ((double) this.earnedRuns) / ((double) this.inningsPitched) * 7D * 100D;
            return Math.round(a) / 100D;
        } else {
            return 0D;
        }
    }

    public Double getBattingAvg() {
        if (this.atBats > 0) {
            Double a = ((double) this.hits) / ((double) this.atBats) * 1000D;
            return Math.round(a) / 1000D;
        } else {
            return 0D;
        }
    }

    public Double getWalksHitsIP() {
        if (this.inningsPitched > 0) {
            Double a = (((double) this.hits) + ((double) this.basesOnBalls)) / ((double) this.inningsPitched) * 100D;
            return Math.round(a) / 100D;
        } else {
            return 0D;
        }
    }
    
    public Double getFieldingIndependentPitching() {
        if (this.inningsPitched > 0) {
            Double a = ((13 * ((double) this.homeRuns) + 3 * ((double) this.basesOnBalls) - 2 * ((double) this.strikeOuts)) / ((double) this.inningsPitched) + 3.2D) * 100D;
            return Math.round(a) / 100D;
        } else {
            return 0D;
        }
    }
}
