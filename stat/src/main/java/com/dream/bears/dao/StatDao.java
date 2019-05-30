package com.dream.bears.dao;

import java.util.List;

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

    public List<PitcherRecord> selectPitchingStatBySeason(Long season) {
        return this.sqlSessionTemplate.selectList("StatDao.selectPitchingStatBySeason", season);
    }

    public List<BatterRecord> selectHittingStatByGame(BatterRecord br) {
        return this.sqlSessionTemplate.selectList("StatDao.selectHittingStatByGame", br);
    }

    public List<TeamRecord> selectTeamStatsBySeason(long season) {
        return this.sqlSessionTemplate.selectList("StatDao.selectTeamStatsBySeason", season);
    }
}
