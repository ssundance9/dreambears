package com.dream.bears.service;

import java.util.List;

import com.dream.bears.model.BatterRecord;
import com.dream.bears.model.PitcherRecord;

public interface StatService {
    List<BatterRecord> getBattersStatByYear(Long year);
    
    List<BatterRecord> getBatterStatsByName(String name);
    
    List<PitcherRecord> getPitchersStatByYear(Long year);
    
    List<PitcherRecord> getPitcherStatsByName(String name);

}
