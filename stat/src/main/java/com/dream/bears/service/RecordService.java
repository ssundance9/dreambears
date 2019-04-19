package com.dream.bears.service;

import com.dream.bears.model.BatterRecord;
import com.dream.bears.model.PitcherRecord;

public interface RecordService {
    void createBatterRecord(BatterRecord br);

    void createPitcherRecord(PitcherRecord pr);
}
