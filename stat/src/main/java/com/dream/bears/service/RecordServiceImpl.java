package com.dream.bears.service;

import org.springframework.stereotype.Service;

import com.dream.bears.model.BatterRecord;
import com.dream.bears.model.PitcherRecord;
import com.dream.bears.model.TeamRecord;
import com.google.cloud.datastore.Datastore;
import com.google.cloud.datastore.DatastoreOptions;
import com.google.cloud.datastore.Entity;
import com.google.cloud.datastore.Key;

@Service
public class RecordServiceImpl implements RecordService {
    Datastore datastore;
    final String batter = "batter";
    final String pitcher = "pitcher";
    final String team = "team";
    
    public Datastore getDatastore() {
        if (this.datastore == null) {
            this.datastore = DatastoreOptions.getDefaultInstance().getService();
        }
        
        return this.datastore;
    }

    @Override
    public void createBatterRecord(BatterRecord br) {
        // Instantiates a client
        Datastore datastore = this.getDatastore();

        // The kind for the new entity
        //String batter = "batter";
        // The name/ID for the new entity
        //String name = br.getName();
        // The Cloud Datastore key for the new entity
        Key batterKey = datastore.newKeyFactory().setKind(this.batter).newKey(br.getYear() + br.getName());
        
        // 지우고 다시 저장
        datastore.delete(batterKey);

        // Prepares the new entity
        Entity batterRecord = Entity.newBuilder(batterKey)
            .set("Year", br.getYear())
            .set("Name", br.getName())
            .set("Games", br.getGames())
            .set("PlateAppears", br.getPlateAppears())
            .set("AtBats", br.getAtBats())
            .set("Hits", br.getHits())
            .set("Singles", br.getSingles())
            .set("Doubles", br.getDoubles())
            .set("Triples", br.getTriples())
            .set("HomeRuns", br.getHomeRuns())
            .set("RunsScored", br.getRunsScored())
            .set("RunsBattedIn", br.getRunsBattedIn())
            .set("BasesOnBalls", br.getBasesOnBalls())
            .set("StrikeOuts", br.getStrikeOuts())
            .set("StolenBases", br.getStolenBases())
            .build();

        // Saves the entity
        datastore.put(batterRecord);
    }

    @Override
    public void createPitcherRecord(PitcherRecord pr) {
        // Instantiates a client
        Datastore datastore = this.getDatastore();

        // The kind for the new entity
        //String batter = "batter";
        // The name/ID for the new entity
        //String name = br.getName();
        // The Cloud Datastore key for the new entity
        Key pitcherKey = datastore.newKeyFactory().setKind(this.pitcher).newKey(pr.getYear() + pr.getName());
        
        // 지우고 다시 저장
        datastore.delete(pitcherKey);

        // Prepares the new entity
        Entity pitcherRecord = Entity.newBuilder(pitcherKey)
            .set("Year", pr.getYear())
            .set("Name", pr.getName())
            .set("Wins", pr.getWins())
            .set("Losses", pr.getLosses())
            .set("Saves", pr.getSaves())
            .set("InningsPitched", pr.getInningsPitched())
            .set("PlateAppears", pr.getPlateAppears())
            .set("AtBats", pr.getAtBats())
            .set("Hits", pr.getHits())
            .set("HomeRuns", pr.getHomeRuns())
            .set("SacrificeFly", pr.getSacrificeFly())
            .set("BasesOnBalls", pr.getBasesOnBalls())
            .set("StrikeOuts", pr.getStrikeOuts())
            .set("Runs", pr.getRuns())
            .set("EarnedRuns", pr.getEarnedRuns())
            .build();

        // Saves the entity
        datastore.put(pitcherRecord);
    }

    @Override
    public void createTeamRecord(TeamRecord tr) {
        // Instantiates a client
        Datastore datastore = this.getDatastore();

        // The kind for the new entity
        //String batter = "batter";
        // The name/ID for the new entity
        //String name = br.getName();
        // The Cloud Datastore key for the new entity
        Key teamKey = datastore.newKeyFactory().setKind(this.team).newKey(String.valueOf(tr.getYear()) + String.valueOf(tr.getMonth()) + String.valueOf(tr.getDate()) + tr.getOpponent() + tr.getHomeAway());
        
        // 지우고 다시 저장
        datastore.delete(teamKey);

        // Prepares the new entity
        Entity teamRecord = Entity.newBuilder(teamKey)
            .set("Year", tr.getYear())
            .set("Month", tr.getMonth())
            .set("Date", tr.getDate())
            .set("BallPark", tr.getBallPark())
            .set("Type", tr.getType())
            .set("HomeAway", tr.getHomeAway())
            .set("Result", tr.getResult())
            .set("Opponent", tr.getOpponent())
            .build();

        // Saves the entity
        datastore.put(teamRecord);
    }
}
