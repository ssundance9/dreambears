package com.dream.bears.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dream.bears.model.BatterRecord;

@Repository
public class StatDao {
    @Autowired private SqlSessionTemplate sqlSessionTemplate;

    public List<BatterRecord> selectHittingStatByYear(Long year) {

        return this.sqlSessionTemplate.selectList("StatDao.selectHittingStatByYear", year);
    }
}
