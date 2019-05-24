package com.dream.bears.service;

import com.dream.bears.model.BatterRecord;
import com.dream.bears.model.PitcherRecord;
import com.dream.bears.model.TeamRecord;

public interface RecordService {
    void createBatterRecord(BatterRecord br);

    void createPitcherRecord(PitcherRecord pr);

    void createTeamRecord(TeamRecord tr);

    void createBatterRecordByDate(BatterRecord br);
}
