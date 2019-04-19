package com.dream.bears.service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;

import org.springframework.stereotype.Service;

import com.dream.bears.model.BatterRecord;
import com.dream.bears.model.PitcherRecord;
import com.google.cloud.datastore.Datastore;
import com.google.cloud.datastore.DatastoreOptions;
import com.google.cloud.datastore.Entity;
import com.google.cloud.datastore.Query;
import com.google.cloud.datastore.QueryResults;
import com.google.cloud.datastore.StructuredQuery.CompositeFilter;
import com.google.cloud.datastore.StructuredQuery.OrderBy;
import com.google.cloud.datastore.StructuredQuery.PropertyFilter;

@Service
public class StatServiceImpl implements StatService {
    Datastore datastore;
    final String batter = "batter";
    final String pitcher = "pitcher";
    
    public Datastore getDatastore() {
        if (this.datastore == null) {
            this.datastore = DatastoreOptions.getDefaultInstance().getService();
        }
        
        return this.datastore;
    }
    
    @Override
    public List<BatterRecord> getBattersStatByYear(Long year) {
        Datastore datastore = this.getDatastore();
        List<BatterRecord> list = new ArrayList<BatterRecord>();
        List<BatterRecord> result = new ArrayList<BatterRecord>();
        
        if (year == 9999L) {
            Query<Entity> query = Query.newEntityQueryBuilder()
                    .setKind(this.batter)
                    .setOrderBy(OrderBy.asc("Name"))
                    .build();
                
            QueryResults<Entity> batters = datastore.run(query);
            
            while (batters.hasNext()) {
                list.add(this.convertEntityToBatter(batters.next()));
            }
            
            // 이름 중복 제거
            HashSet<String> set = new HashSet<String>();
            for (int i = 0; i < list.size(); i++) {
                BatterRecord batter = list.get(i);
                set.add(batter.getName());
            }
            
            // 합치기
            Iterator<String> it = set.iterator();
            while (it.hasNext()) {
                String name = it.next();
                BatterRecord sum = new BatterRecord();
                
                for (int i = 0; i < list.size(); i++) {
                    BatterRecord batter = list.get(i);
                    if (name.equals(batter.getName())) {
                        sum.setName(name);
                        sum.setGames(sum.getGames() + batter.getGames());
                        sum.setPlateAppears(sum.getPlateAppears() + batter.getPlateAppears());
                        sum.setAtBats(sum.getAtBats() + batter.getAtBats());
                        sum.setHits(sum.getHits() + batter.getHits());
                        sum.setSingles(sum.getSingles() + batter.getSingles());
                        sum.setDoubles(sum.getDoubles() + batter.getDoubles());
                        sum.setTriples(sum.getTriples() + batter.getTriples());
                        sum.setHomeRuns(sum.getHomeRuns() + batter.getHomeRuns());
                        sum.setRunsScored(sum.getRunsScored() + batter.getRunsScored());
                        sum.setRunsBattedIn(sum.getRunsBattedIn() + batter.getRunsBattedIn());
                        sum.setBasesOnBalls(sum.getBasesOnBalls() + batter.getBasesOnBalls());
                        sum.setStrikeOuts(sum.getStrikeOuts() + batter.getStrikeOuts());
                        sum.setStolenBases(sum.getStolenBases() + batter.getStolenBases());
                    }
                }
                
                result.add(sum);
            }
            
            //Collections.sort(list, c);
            
            return result;
        } else {
            Query<Entity> query = Query.newEntityQueryBuilder()
                    .setKind(this.batter)
                    .setFilter(CompositeFilter.and(PropertyFilter.eq("Year", year)))
                    .setOrderBy(OrderBy.asc("Name"))
                    .build();
                
            QueryResults<Entity> batters = datastore.run(query);
            
            while (batters.hasNext()) {
                list.add(this.convertEntityToBatter(batters.next()));
            }
            
            return list;
        }
        
    }
    
    
    @Override
    public List<BatterRecord> getBatterStatsByName(String name) {
        Datastore datastore = this.getDatastore();
        List<BatterRecord> list = new ArrayList<BatterRecord>();
      
        /*Key batterKey = datastore.newKeyFactory().setKind(this.batter).newKey(year + name);
        Entity retrieved = datastore.get(batterKey);
      
        return this.convertEntityToBatter(retrieved);*/
        
        
        
        Query<Entity> query = Query.newEntityQueryBuilder()
            .setKind(this.batter)
            .setFilter(CompositeFilter.and(PropertyFilter.eq("Name", name)
                    //, PropertyFilter.ge("priority", 4)
                    ))
            .setOrderBy(OrderBy.asc("Year"))
            .build();
            
        QueryResults<Entity> stats = datastore.run(query);
        
        while(stats.hasNext()) {
            list.add(this.convertEntityToBatter(stats.next()));
        }
        
        return list;
    }
     
    
    private BatterRecord convertEntityToBatter(Entity entity) {
        BatterRecord batter = new BatterRecord();
        
        batter.setYear(entity.getLong("Year"));
        batter.setName(entity.getString("Name"));
        batter.setGames(entity.getLong("Games"));
        batter.setPlateAppears(entity.getLong("PlateAppears"));
        batter.setAtBats(entity.getLong("AtBats"));
        batter.setHits(entity.getLong("Hits"));
        batter.setSingles(entity.getLong("Singles"));
        batter.setDoubles(entity.getLong("Doubles"));
        batter.setTriples(entity.getLong("Triples"));
        batter.setHomeRuns(entity.getLong("HomeRuns"));
        batter.setRunsScored(entity.getLong("RunsScored"));
        batter.setRunsBattedIn(entity.getLong("RunsBattedIn"));
        batter.setBasesOnBalls(entity.getLong("BasesOnBalls"));
        batter.setStrikeOuts(entity.getLong("StrikeOuts"));
        batter.setStolenBases(entity.getLong("StolenBases"));
        
        return batter;
    }

    @Override
    public List<PitcherRecord> getPitchersStatByYear(Long year) {
        Datastore datastore = this.getDatastore();
        List<PitcherRecord> list = new ArrayList<PitcherRecord>();
        
        Query<Entity> query = Query.newEntityQueryBuilder()
            .setKind(this.pitcher)
            .setFilter(CompositeFilter.and(PropertyFilter.eq("Year", year)
                    //, PropertyFilter.ge("priority", 4)
                    ))
            .setOrderBy(OrderBy.asc("Name"))
            .build();
        
        QueryResults<Entity> pitchers = datastore.run(query);
        
        while(pitchers.hasNext()) {
            list.add(this.convertEntityToPitcher(pitchers.next()));
        }
        
        return list;
    }
    
    @Override
    public List<PitcherRecord> getPitcherStatsByName(String name) {
        Datastore datastore = this.getDatastore();
        List<PitcherRecord> list = new ArrayList<PitcherRecord>();
        
        Query<Entity> query = Query.newEntityQueryBuilder()
            .setKind(this.pitcher)
            .setFilter(CompositeFilter.and(PropertyFilter.eq("Name", name)
                    //, PropertyFilter.ge("priority", 4)
                    ))
            .setOrderBy(OrderBy.asc("Year"))
            .build();
            
        QueryResults<Entity> stats = datastore.run(query);
        
        while(stats.hasNext()) {
            list.add(this.convertEntityToPitcher(stats.next()));
        }
        
        return list;
    }
    
    private PitcherRecord convertEntityToPitcher(Entity entity) {
        PitcherRecord pitcher = new PitcherRecord();
        
        pitcher.setYear(entity.getLong("Year"));
        pitcher.setName(entity.getString("Name"));
        pitcher.setWins(entity.getLong("Wins"));
        pitcher.setLosses(entity.getLong("Losses"));
        pitcher.setSaves(entity.getLong("Saves"));
        pitcher.setInningsPitched(entity.getDouble("InningsPitched"));
        pitcher.setPlateAppears(entity.getLong("PlateAppears"));
        pitcher.setAtBats(entity.getLong("AtBats"));
        pitcher.setHits(entity.getLong("Hits"));
        pitcher.setHomeRuns(entity.getLong("HomeRuns"));
        pitcher.setSacrificeFly(entity.getLong("SacrificeFly"));
        pitcher.setBasesOnBalls(entity.getLong("BasesOnBalls"));
        pitcher.setStrikeOuts(entity.getLong("StrikeOuts"));
        pitcher.setRuns(entity.getLong("Runs"));
        pitcher.setEarnedRuns(entity.getLong("EarnedRuns"));
        
        return pitcher;
    }

}
