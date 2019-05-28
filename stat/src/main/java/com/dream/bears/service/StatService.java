package com.dream.bears.service;

import java.util.List;

import com.dream.bears.model.BatterRecord;
import com.dream.bears.model.PitcherRecord;
import com.dream.bears.model.TeamRecord;

public interface StatService {
    List<BatterRecord> getBattersStatByYear(Long year, Long pa);

    List<BatterRecord> getBatterStatsByName(String name);

    List<PitcherRecord> getPitchersStatByYear(Long year, Long ip);

    List<PitcherRecord> getPitcherStatsByName(String name);

    List<TeamRecord> getTeamStatsByYear(Long year);

    List<TeamRecord> getTeamTotalStat();

    List<BatterRecord> getHittingStatByYear(Long year);

}
