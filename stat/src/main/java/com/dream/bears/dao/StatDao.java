package com.dream.bears.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dream.bears.model.BatterRecord;
import com.dream.bears.model.PitcherRecord;
import com.dream.bears.model.TeamRecord;

@Repository
public class StatDao {
    @Autowired private SqlSessionTemplate sqlSessionTemplate;

    public List<BatterRecord> selectHittingStatBySeason(Long season) {
        return this.sqlSessionTemplate.selectList("StatDao.selectHittingStatBySeason", season);
    }

    public List<BatterRecord> selectHittingStatByGame(BatterRecord br) {
        return this.sqlSessionTemplate.selectList("StatDao.selectHittingStatByGame", br);
    }

    public List<TeamRecord> selectTeamStatsBySeason(long season) {
        return this.sqlSessionTemplate.selectList("StatDao.selectTeamStatsBySeason", season);
    }

    public List<String> selectBatterNamesBySeason(Long season) {
        return this.sqlSessionTemplate.selectList("StatDao.selectBatterNamesBySeason", season);
    }

    public List<BatterRecord> selectHittingStatByPersonGame(String name, Long season) {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("name", name);
        map.put("season", season);
        return this.sqlSessionTemplate.selectList("StatDao.selectHittingStatByPersonGame", map);
    }

    public List<PitcherRecord> selectPitchingStatBySeason(Long season) {
        return this.sqlSessionTemplate.selectList("StatDao.selectPitchingStatBySeason", season);
    }

    public List<PitcherRecord> selectPitchingStatByGame(PitcherRecord pr) {
        return this.sqlSessionTemplate.selectList("StatDao.selectPitchingStatByGame", pr);
    }

    public List<BatterRecord> selectHittingStatByPerson(BatterRecord br) {
        return this.sqlSessionTemplate.selectList("StatDao.selectHittingStatByPerson", br);
    }

    public List<BatterRecord> selectPitchingStatByPerson(PitcherRecord pr) {
        return this.sqlSessionTemplate.selectList("StatDao.selectPitchingStatByPerson", pr);
    }
}
