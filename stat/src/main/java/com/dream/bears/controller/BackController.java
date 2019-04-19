package com.dream.bears.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dream.bears.model.BatterRecord;
import com.dream.bears.model.PitcherRecord;
import com.dream.bears.service.RecordService;

@RequestMapping("back")
@Controller
public class BackController {
    @Autowired
    private RecordService recordService;
    
    @RequestMapping(value = "/createRecordView")
    public String createRecordView(ModelMap map) {
    	return "/back/createRecordView";
    }
    
    @RequestMapping(value = "/createBatterRecord")
    public String createBatterRecord(ModelMap map, Long year, String recordStr) {
        String[] recordArray1 = recordStr.split(",");
        
        for (int i = 0; i < recordArray1.length; i++) {
            String rec = recordArray1[i];
            String[] recordArray2 = rec.split(" ");
            
            BatterRecord br = new BatterRecord();
            br.setYear(year);
            br.setName(recordArray2[0].trim());
            br.setGames(Long.parseLong(recordArray2[1]));
            br.setPlateAppears(Long.parseLong(recordArray2[2]));
            br.setAtBats(Long.parseLong(recordArray2[3]));
            br.setHits(Long.parseLong(recordArray2[4]));
            br.setSingles(Long.parseLong(recordArray2[5]));
            br.setDoubles(Long.parseLong(recordArray2[6]));
            br.setTriples(Long.parseLong(recordArray2[7]));
            br.setHomeRuns(Long.parseLong(recordArray2[8]));
            br.setRunsScored(Long.parseLong(recordArray2[9]));
            br.setRunsBattedIn(Long.parseLong(recordArray2[10]));
            br.setBasesOnBalls(Long.parseLong(recordArray2[11]));
            br.setStrikeOuts(Long.parseLong(recordArray2[12]));
            br.setStolenBases(Long.parseLong(recordArray2[13]));

            this.recordService.createBatterRecord(br);
        }
        
        return "redirect:/back/createRecordView.do";
    }
    
    @RequestMapping(value = "/createPitcherRecord")
    public String createPitcherRecord(ModelMap map, Long year, String recordStr) {
        String[] recordArray1 = recordStr.split(",");
        
        for (int i = 0; i < recordArray1.length; i++) {
            String rec = recordArray1[i];
            String[] recordArray2 = rec.split(" ");
            
            PitcherRecord pr = new PitcherRecord();
            pr.setYear(year);
            pr.setName(recordArray2[0].trim());
            pr.setWins(Long.parseLong(recordArray2[1]));
            pr.setLosses(Long.parseLong(recordArray2[2]));
            pr.setSaves(Long.parseLong(recordArray2[3]));
            pr.setInningsPitched(Double.parseDouble(recordArray2[4]));
            pr.setPlateAppears(Long.parseLong(recordArray2[5]));
            pr.setAtBats(Long.parseLong(recordArray2[6]));
            pr.setHits(Long.parseLong(recordArray2[7]));
            pr.setHomeRuns(Long.parseLong(recordArray2[8]));
            pr.setSacrificeFly(Long.parseLong(recordArray2[9]));
            pr.setBasesOnBalls(Long.parseLong(recordArray2[10]));
            pr.setStrikeOuts(Long.parseLong(recordArray2[11]));
            pr.setRuns(Long.parseLong(recordArray2[12]));
            pr.setEarnedRuns(Long.parseLong(recordArray2[13]));

            this.recordService.createPitcherRecord(pr);
        }
        
        return "redirect:/back/createRecordView.do";
    }
}
