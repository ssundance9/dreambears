package com.dream.bears.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.dream.bears.model.BatterRecord;

@Repository
public class RecordDao {
    @Autowired private SqlSessionTemplate sqlSessionTemplate;

    public void insertBatterRecord(BatterRecord br) {
        this.sqlSessionTemplate.insert("RecordDao.insertBatterRecord", br);
    }

    public void deleteBatterRecord(BatterRecord br) {
        this.sqlSessionTemplate.delete("RecordDao.deleteBatterRecord", br);

    }

}
