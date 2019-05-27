package com.dream.bears.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class StatDao {
    @Autowired private SqlSessionTemplate sqlSessionTemplate;
    
    public int selectTest() {
        return this.sqlSessionTemplate.selectOne("StatDao.selectTest");
    }
}
