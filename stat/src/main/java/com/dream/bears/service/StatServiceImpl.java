package com.dream.bears.service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dream.bears.dao.StatDao;
import com.dream.bears.model.BatterRecord;
import com.dream.bears.model.PitcherRecord;
import com.dream.bears.model.TeamRecord;
import com.google.api.client.util.Lists;
import com.google.cloud.datastore.Datastore;
import com.google.cloud.datastore.DatastoreOptions;
import com.google.cloud.datastore.Entity;
import com.google.cloud.datastore.Query;
import com.google.cloud.datastore.QueryResults;
import com.google.cloud.datastore.StructuredQuery.CompositeFilter;
import com.google.cloud.datastore.StructuredQuery.OrderBy;
import com.google.cloud.datastore.StructuredQuery.PropertyFilter;
import com.google.common.base.Predicate;
import com.google.common.collect.Iterables;
import com.google.common.collect.Ordering;
import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

@Service
public class StatServiceImpl implements StatService {
    Datastore datastore;
    final String batter = "batter";
    final String pitcher = "pitcher";
    final String team = "team";
    final String DB_NAME = "myinstance";
    final String DB_USER = "root";
    final String DB_PASS = "j147258369!";
    final String CLOUD_SQL_CONNECTION_NAME = "dreambears:asia-northeast2:myinstance";

    @Autowired
    private StatDao statDao;

    public Datastore getDatastore() {
        if (this.datastore == null) {
            this.datastore = DatastoreOptions.getDefaultInstance().getService();
        }

        return this.datastore;
    }

    @Override
    public List<BatterRecord> getBattersStatByYear(Long year, Long pa) {
        Datastore datastore = this.getDatastore();
        List<BatterRecord> list = new ArrayList<BatterRecord>();
        List<BatterRecord> temp = new ArrayList<BatterRecord>();
        List<BatterRecord> result = new ArrayList<BatterRecord>();

        if (year == 9999L) { // 통산 기록
            Query<Entity> query= Query.newEntityQueryBuilder()
                .setKind(this.batter)
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

                temp.add(sum);
            }

            if (pa == 200L) {
                result = Lists.newArrayList(Iterables.filter(temp, new Predicate<BatterRecord>() {
                    @Override

                    public boolean apply(BatterRecord rec) {
                        if (rec.getPlateAppears() >= 200L) {
                            return true;
                        } else {
                            return false;
                        }
                    }
                }));
            } else {
                result = temp;
            }

            // 정렬
            Ordering<BatterRecord> byName = new Ordering<BatterRecord>() {
                @Override
                public int compare(BatterRecord left, BatterRecord right) {
                    return left.getName().compareTo(right.getName());
                }
            };
            Collections.sort(result, byName);
        } else { // 단일 시즌 기록
            Query<Entity> query = Query.newEntityQueryBuilder()
                    .setKind(this.batter)
                    .setFilter(CompositeFilter.and(PropertyFilter.eq("Year", year)))
                    .setOrderBy(OrderBy.asc("Name"))
                    .build();

            QueryResults<Entity> batters = datastore.run(query);

            while (batters.hasNext()) {
                result.add(this.convertEntityToBatter(batters.next()));
            }
        }

        // 합계
        result = this.addTotalBatterRecord(result);

        return result;
    }

    @Override
    public List<BatterRecord> getBatterStatsByName(String name) {
        Datastore datastore = this.getDatastore();
        List<BatterRecord> list = new ArrayList<BatterRecord>();
        List<BatterRecord> result = new ArrayList<BatterRecord>();

        /*Key batterKey = datastore.newKeyFactory().setKind(this.batter).newKey(year + name);
        Entity retrieved = datastore.get(batterKey);
        return this.convertEntityToBatter(retrieved);*/

        if (!name.equals("TOTAL")) {
            Query<Entity> query = Query.newEntityQueryBuilder()
                .setKind(this.batter)
                .setFilter(CompositeFilter.and(PropertyFilter.eq("Name", name)
                        //, PropertyFilter.ge("priority", 4)
                        ))
                .setOrderBy(OrderBy.desc("Year"))
                .build();

            QueryResults<Entity> stats = datastore.run(query);

            while(stats.hasNext()) {
                result.add(this.convertEntityToBatter(stats.next()));
            }
        } else {
            Query<Entity> query= Query.newEntityQueryBuilder()
                .setKind(this.batter)
                .build();

            QueryResults<Entity> batters = datastore.run(query);

            while (batters.hasNext()) {
                list.add(this.convertEntityToBatter(batters.next()));
            }

            // 연도 중복 제거
            HashSet<Long> set = new HashSet<Long>();
            for (int i = 0; i < list.size(); i++) {
                BatterRecord batter = list.get(i);
                set.add(batter.getYear());
            }

            // 합치기
            Iterator<Long> it = set.iterator();
            while (it.hasNext()) {
                long year = it.next();
                BatterRecord sum = new BatterRecord();

                for (int i = 0; i < list.size(); i++) {
                    BatterRecord batter = list.get(i);
                    if (year == batter.getYear()) {
                        sum.setYear(year);
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
        }

        // 합계
        result = this.addTotalBatterRecord(result);

        return result;
    }

    private List<BatterRecord> addTotalBatterRecord(List<BatterRecord> list) {
        BatterRecord total = new BatterRecord();
        total.setName("TOTAL");

        for (BatterRecord rec : list) {
            total.setPlateAppears(total.getPlateAppears() + rec.getPlateAppears());
            total.setGames(total.getGames() + rec.getGames());
            total.setAtBats(total.getAtBats() + rec.getAtBats());
            total.setHits(total.getHits() + rec.getHits());
            total.setSingles(total.getSingles() + rec.getSingles());
            total.setDoubles(total.getDoubles() + rec.getDoubles());
            total.setTriples(total.getTriples() + rec.getTriples());
            total.setHomeRuns(total.getHomeRuns() + rec.getHomeRuns());
            total.setRunsScored(total.getRunsScored() + rec.getRunsScored());
            total.setRunsBattedIn(total.getRunsBattedIn() + rec.getRunsBattedIn());
            total.setBasesOnBalls(total.getBasesOnBalls() + rec.getBasesOnBalls());
            total.setStrikeOuts(total.getStrikeOuts() + rec.getStrikeOuts());
            total.setStolenBases(total.getStolenBases() + rec.getStolenBases());
        }

        list.add(total);

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
    public List<PitcherRecord> getPitchersStatByYear(Long year, Long ip) {
        Datastore datastore = this.getDatastore();
        List<PitcherRecord> list = new ArrayList<PitcherRecord>();
        List<PitcherRecord> temp = new ArrayList<PitcherRecord>();
        List<PitcherRecord> result = new ArrayList<PitcherRecord>();

        if (year == 9999L) { // 통산 기록
            Query<Entity> query = Query.newEntityQueryBuilder()
                    .setKind(this.pitcher)
                    .build();

            QueryResults<Entity> pitchers = datastore.run(query);

            while (pitchers.hasNext()) {
                list.add(this.convertEntityToPitcher(pitchers.next()));
            }

            // 이름 중복 제거
            HashSet<String> set = new HashSet<String>();
            for (int i = 0; i < list.size(); i++) {
                PitcherRecord pitcher = list.get(i);
                set.add(pitcher.getName());
            }

            // 합치기
            Iterator<String> it = set.iterator();
            while (it.hasNext()) {
                String name = it.next();
                PitcherRecord sum = new PitcherRecord();

                for (int i = 0; i < list.size(); i++) {
                    PitcherRecord pitcher = list.get(i);
                    if (name.equals(pitcher.getName())) {
                        sum.setName(name);
                        sum.setWins(sum.getWins() + pitcher.getWins());
                        sum.setLosses(sum.getLosses() + pitcher.getLosses());
                        sum.setSaves(sum.getSaves() + pitcher.getSaves());
                        sum.setInningsPitched(sum.getInningsPitched() + pitcher.getInningsPitched());
                        sum.setPlateAppears(sum.getPlateAppears() + pitcher.getPlateAppears());
                        sum.setAtBats(sum.getAtBats() + pitcher.getAtBats());
                        sum.setHits(sum.getHits() + pitcher.getHits());
                        sum.setHomeRuns(sum.getHomeRuns() + pitcher.getHomeRuns());
                        sum.setSacrificeFly(sum.getSacrificeFly() + pitcher.getSacrificeFly());
                        sum.setBasesOnBalls(sum.getBasesOnBalls() + pitcher.getBasesOnBalls());
                        sum.setStrikeOuts(sum.getStrikeOuts() + pitcher.getStrikeOuts());
                        sum.setRuns(sum.getRuns() + pitcher.getRuns());
                        sum.setEarnedRuns(sum.getEarnedRuns() + pitcher.getEarnedRuns());
                    }
                }

                temp.add(sum);
            }

            if (ip == 40L) {
                result = Lists.newArrayList(Iterables.filter(temp, new Predicate<PitcherRecord>() {
                    @Override

                    public boolean apply(PitcherRecord rec) {
                        if (rec.getInningsPitched() >= 40L) {
                            return true;
                        } else {
                            return false;
                        }
                    }
                }));
            } else {
                result = temp;
            }

            // 정렬
            Ordering<PitcherRecord> byName = new Ordering<PitcherRecord>() {
                @Override
                public int compare(PitcherRecord left, PitcherRecord right) {
                    return left.getName().compareTo(right.getName());
                }
            };
            Collections.sort(result, byName);
        } else { // 단일 시즌 기록
            Query<Entity> query = Query.newEntityQueryBuilder()
                .setKind(this.pitcher)
                .setFilter(CompositeFilter.and(PropertyFilter.eq("Year", year)))
                .setOrderBy(OrderBy.asc("Name"))
                .build();

            QueryResults<Entity> pitchers = datastore.run(query);

            while(pitchers.hasNext()) {
                result.add(this.convertEntityToPitcher(pitchers.next()));
            }
        }

        // 합계
        result = this.addTotalPitcherRecord(result);

        return result;
    }

    @Override
    public List<PitcherRecord> getPitcherStatsByName(String name) {
        Datastore datastore = this.getDatastore();
        List<PitcherRecord> list = new ArrayList<PitcherRecord>();
        List<PitcherRecord> result = new ArrayList<PitcherRecord>();

        if (!name.equals("TOTAL")) {
            Query<Entity> query = Query.newEntityQueryBuilder()
                .setKind(this.pitcher)
                .setFilter(CompositeFilter.and(PropertyFilter.eq("Name", name)
                        //, PropertyFilter.ge("priority", 4)
                        ))
                .setOrderBy(OrderBy.desc("Year"))
                .build();

            QueryResults<Entity> stats = datastore.run(query);

            while(stats.hasNext()) {
                result.add(this.convertEntityToPitcher(stats.next()));
            }
        } else {
            Query<Entity> query = Query.newEntityQueryBuilder()
                .setKind(this.pitcher)
                .build();

            QueryResults<Entity> pitchers = datastore.run(query);

            while (pitchers.hasNext()) {
                list.add(this.convertEntityToPitcher(pitchers.next()));
            }

            // 연도 중복 제거
            HashSet<Long> set = new HashSet<Long>();
            for (int i = 0; i < list.size(); i++) {
                PitcherRecord pitcher = list.get(i);
                set.add(pitcher.getYear());
            }

            // 합치기
            Iterator<Long> it = set.iterator();
            while (it.hasNext()) {
                long year = it.next();
                PitcherRecord sum = new PitcherRecord();

                for (int i = 0; i < list.size(); i++) {
                    PitcherRecord pitcher = list.get(i);
                    if (year == pitcher.getYear()) {
                        sum.setYear(year);
                        sum.setWins(sum.getWins() + pitcher.getWins());
                        sum.setLosses(sum.getLosses() + pitcher.getLosses());
                        sum.setSaves(sum.getSaves() + pitcher.getSaves());
                        sum.setInningsPitched(sum.getInningsPitched() + pitcher.getInningsPitched());
                        sum.setPlateAppears(sum.getPlateAppears() + pitcher.getPlateAppears());
                        sum.setAtBats(sum.getAtBats() + pitcher.getAtBats());
                        sum.setHits(sum.getHits() + pitcher.getHits());
                        sum.setHomeRuns(sum.getHomeRuns() + pitcher.getHomeRuns());
                        sum.setSacrificeFly(sum.getSacrificeFly() + pitcher.getSacrificeFly());
                        sum.setBasesOnBalls(sum.getBasesOnBalls() + pitcher.getBasesOnBalls());
                        sum.setStrikeOuts(sum.getStrikeOuts() + pitcher.getStrikeOuts());
                        sum.setRuns(sum.getRuns() + pitcher.getRuns());
                        sum.setEarnedRuns(sum.getEarnedRuns() + pitcher.getEarnedRuns());
                    }
                }

                result.add(sum);
            }
        }

        // 합계
        result = this.addTotalPitcherRecord(result);

        return result;
    }

    private List<PitcherRecord> addTotalPitcherRecord(List<PitcherRecord> list) {
        PitcherRecord total = new PitcherRecord();
        total.setName("TOTAL");

        for (PitcherRecord rec : list) {
            total.setWins(total.getWins() + rec.getWins());
            total.setLosses(total.getLosses() + rec.getLosses());
            total.setSaves(total.getSaves() + rec.getSaves());
            total.setInningsPitched(total.getInningsPitched() + rec.getInningsPitched());
            total.setPlateAppears(total.getPlateAppears() + rec.getPlateAppears());
            total.setAtBats(total.getAtBats() + rec.getAtBats());
            total.setHits(total.getHits() + rec.getHits());
            total.setHomeRuns(total.getHomeRuns() + rec.getHomeRuns());
            total.setSacrificeFly(total.getSacrificeFly() + rec.getSacrificeFly());
            total.setBasesOnBalls(total.getBasesOnBalls() + rec.getBasesOnBalls());
            total.setStrikeOuts(total.getStrikeOuts() + rec.getStrikeOuts());
            total.setRuns(total.getRuns() + rec.getRuns());
            total.setEarnedRuns(total.getEarnedRuns() + rec.getEarnedRuns());
        }

        list.add(total);

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

    @Override
    public List<TeamRecord> getTeamStatsByYear(Long year) {
        Datastore datastore = this.getDatastore();
        List<TeamRecord> list = new ArrayList<TeamRecord>();
        List<TeamRecord> result = new ArrayList<TeamRecord>();

        if (year == 9999L) { // 통산 기록
            Query<Entity> query = Query.newEntityQueryBuilder()
                    .setKind(this.team)
                    .build();

            QueryResults<Entity> stats = datastore.run(query);

            while (stats.hasNext()) {
                list.add(this.convertEntityToTeam(stats.next()));
            }

            // 연도 중복 제거
            HashSet<Long> set = new HashSet<Long>();
            for (int i = 0; i < list.size(); i++) {
                TeamRecord team = list.get(i);
                set.add(team.getYear());
            }

            // 합치기
            Iterator<Long> it = set.iterator();
            while (it.hasNext()) {
                long yr = it.next();
                TeamRecord sum = new TeamRecord();

                for (int i = 0; i < list.size(); i++) {
                    TeamRecord team = list.get(i);
                    if (yr == team.getYear()) {
                        sum.setYear(yr);
                        if (team.getResult().contains("승")) {
                            sum.setWins(sum.getWins() + 1);
                        }
                        if (team.getResult().contains("무")) {
                            sum.setDraws(sum.getDraws() + 1);
                        }
                        if (team.getResult().contains("패")) {
                            sum.setLosses(sum.getLosses() + 1);
                        }
                    }
                }

                result.add(sum);
            }
        } else {
            Query<Entity> query = Query.newEntityQueryBuilder()
                .setKind(this.team)
                .setFilter(CompositeFilter.and(PropertyFilter.eq("Year", year)))
                .setOrderBy(OrderBy.asc("Month"), OrderBy.asc("Date"))
                .build();

            QueryResults<Entity> team = datastore.run(query);

            while(team.hasNext()) {
                result.add(this.convertEntityToTeam(team.next()));
            }
        }

        return result;
    }

    private TeamRecord convertEntityToTeam(Entity entity) {
        TeamRecord team = new TeamRecord();

        team.setYear(entity.getLong("Year"));
        team.setMonth(entity.getLong("Month"));
        team.setDate(entity.getLong("Date"));
        team.setBallPark(entity.getString("BallPark"));
        team.setType(entity.getString("Type"));
        team.setHomeAway(entity.getString("HomeAway"));
        team.setResult(entity.getString("Result"));
        team.setOpponent(entity.getString("Opponent"));

        return team;
    }

    @Override
    public List<TeamRecord> getTeamTotalStat() {
        Datastore datastore = this.getDatastore();
        List<TeamRecord> list = new ArrayList<TeamRecord>();
        List<TeamRecord> result = new ArrayList<TeamRecord>();

        Query<Entity> query = Query.newEntityQueryBuilder()
                .setKind(this.team)
                .build();

        QueryResults<Entity> stats = datastore.run(query);

        while (stats.hasNext()) {
            list.add(this.convertEntityToTeam(stats.next()));
        }

        // 연도 중복 제거
        HashSet<Long> set = new HashSet<Long>();
        for (int i = 0; i < list.size(); i++) {
            TeamRecord team = list.get(i);
            set.add(team.getYear());
        }

        // 합치기
        Iterator<Long> it = set.iterator();
        while (it.hasNext()) {
            long yr = it.next();
            TeamRecord sum = new TeamRecord();

            for (int i = 0; i < list.size(); i++) {
                TeamRecord team = list.get(i);
                if (yr == team.getYear()) {
                    sum.setYear(yr);
                    if (team.getResult().contains("승")) {
                        sum.setWins(sum.getWins() + 1);
                    }
                    if (team.getResult().contains("무")) {
                        sum.setDraws(sum.getDraws() + 1);
                    }
                    if (team.getResult().contains("패")) {
                        sum.setLosses(sum.getLosses() + 1);
                    }

                    sum.setTotalGames(sum.getWins() + sum.getDraws() + sum.getLosses());
                }
            }

            result.add(sum);
        }

       // 합계
        result = this.addTotalTeamRecord(result);

        return result;
    }

    private List<TeamRecord> addTotalTeamRecord(List<TeamRecord> list) {
        TeamRecord total = new TeamRecord();
        total.setYear(9999L);

        for (TeamRecord rec : list) {
            total.setWins(total.getWins() + rec.getWins());
            total.setLosses(total.getLosses() + rec.getLosses());
            total.setDraws(total.getDraws() + rec.getDraws());
            total.setTotalGames(total.getWins() + total.getDraws() + total.getLosses());

        }

        list.add(total);

        return list;
    }

    public void test() {
     // The configuration object specifies behaviors for the connection pool.
        HikariConfig config = new HikariConfig();

        // Configure which instance and what database user to connect with.
        config.setJdbcUrl(String.format("jdbc:postgresql:///%s", DB_NAME));
        config.setUsername(DB_USER); // e.g. "root", "postgres"
        config.setPassword(DB_PASS); // e.g. "my-password"

        // For Java users, the Cloud SQL JDBC Socket Factory can provide authenticated connections.
        // See https://github.com/GoogleCloudPlatform/cloud-sql-jdbc-socket-factory for details.
        config.addDataSourceProperty("socketFactory", "com.google.cloud.sql.postgres.SocketFactory");
        config.addDataSourceProperty("cloudSqlInstance", CLOUD_SQL_CONNECTION_NAME);

        // ... Specify additional connection properties here.

        // ...

        // Initialize the connection pool using the configuration object.
        DataSource pool = new HikariDataSource(config);
    }

    @Override
    public List<BatterRecord> getHittingStatByYear(Long year) {

        return this.statDao.selectHittingStatByYear(year);
    }

    @Override
    public List<BatterRecord> getHittingStatByGame(BatterRecord br) {
        return this.statDao.selectHittingStatByGame(br);
    }


}
