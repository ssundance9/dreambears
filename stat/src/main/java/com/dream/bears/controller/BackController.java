package com.dream.bears.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dream.bears.model.BatterRecord;
import com.dream.bears.model.PitcherRecord;
import com.dream.bears.model.TeamRecord;
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

    @RequestMapping(value = "/createTeamRecord")
    public String createTeamRecord(ModelMap map, String recordStr) {
        String[] recordArray1 = recordStr.split(",");

        for (int i = 0; i < recordArray1.length; i++) {
            String rec = recordArray1[i];
            String[] recordArray2 = rec.split(" ");

            TeamRecord tr = new TeamRecord();
            tr.setYear(Long.parseLong(recordArray2[0].split("\\.")[0].trim()));
            tr.setMonth(Long.parseLong(recordArray2[0].split("\\.")[1]));
            tr.setDate(Long.parseLong(recordArray2[0].split("\\.")[2]));
            tr.setBallPark(recordArray2[1]);
            tr.setType(recordArray2[2]);
            tr.setHomeAway(recordArray2[3]);
            tr.setResult(recordArray2[4]);
            tr.setOpponent(recordArray2[5]);

            this.recordService.createTeamRecord(tr);
        }

        return "redirect:/back/createRecordView.do";
    }

    @RequestMapping(value = "/createBatterRecordByDate")
    public String createBatterRecordByDate(ModelMap map, Long year, Long month, Long date, Long gameSeq, Long season, String recordStr) {
        String[] recordArray1 = recordStr.split("\\n");

        for (int i = 0; i < recordArray1.length; i++) {
            String rec = recordArray1[i];

            //System.out.println(rec + "!!!!!!!");

            String[] recordArray2 = rec.split("\\t");

            BatterRecord br = new BatterRecord();
            br.setYear(year);
            br.setMonth(month);
            br.setDate(date);
            br.setGameSeq(gameSeq);
            br.setSeason(season);
            br.setName(recordArray2[0].trim());

            br.setBattingOrder(Long.parseLong(recordArray2[1]));

            br.setPlateAppears(Long.parseLong(recordArray2[2]));

            //System.out.println(recordArray2[2] + "!!!!!!!!!!!");

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

            //System.out.println(recordArray2[12] + "!!!!!!!!!!!");
            //System.out.println(recordArray2[12].trim() + "@@@@@@@@@@@@");

            br.setStolenBases(Long.parseLong(recordArray2[13].trim()));

            this.recordService.createBatterRecordByDate(br);
        }

        return "redirect:/back/createRecordView.do";
    }

    @RequestMapping(value = "/createPitcherRecordByDate")
    public String createPitcherRecordByDate(ModelMap map, Long year, Long month, Long date, Long gameSeq, Long season, String recordStr) {
        String[] recordArray1 = recordStr.split("\\n");

        for (int i = 0; i < recordArray1.length; i++) {
            String rec = recordArray1[i];
            String[] recordArray2 = rec.split("\\t");

            PitcherRecord pr = new PitcherRecord();
            pr.setYear(year);
            pr.setMonth(month);
            pr.setDate(date);
            pr.setGameSeq(gameSeq);
            pr.setSeason(season);
            pr.setName(recordArray2[0].trim());
            pr.setGameStarted(Long.parseLong(recordArray2[1]));
            pr.setWins(Long.parseLong(recordArray2[2]));
            pr.setLosses(Long.parseLong(recordArray2[3]));
            pr.setSaves(Long.parseLong(recordArray2[4]));
            pr.setInningsPitched(Double.parseDouble(recordArray2[5]));
            pr.setPlateAppears(Long.parseLong(recordArray2[6]));
            pr.setAtBats(Long.parseLong(recordArray2[7]));
            pr.setHits(Long.parseLong(recordArray2[8]));
            pr.setHomeRuns(Long.parseLong(recordArray2[9]));
            pr.setSacrificeFly(Long.parseLong(recordArray2[10]));
            pr.setBasesOnBalls(Long.parseLong(recordArray2[11]));
            pr.setStrikeOuts(Long.parseLong(recordArray2[12]));
            pr.setRuns(Long.parseLong(recordArray2[13]));
            pr.setEarnedRuns(Long.parseLong(recordArray2[14].trim()));

            this.recordService.createPitcherRecordByDate(pr);
        }

        return "redirect:/back/createRecordView.do";
    }

    @RequestMapping(value = "/createTeamRecordByDate")
    public String createTeamRecordByDate(ModelMap map, Long season, String recordStr) {
        String[] recordArray1 = recordStr.split("\\n");

        for (int i = 0; i < recordArray1.length; i++) {
            String rec = recordArray1[i];



            String[] recordArray2 = rec.split("\\t");

            TeamRecord tr = new TeamRecord();
            tr.setSeason(season);
            String date = recordArray2[0].trim();

            System.out.println(date + "!!!!!!!");

            tr.setYear(Long.parseLong(date.split("-")[0].trim()));
            tr.setMonth(Long.parseLong(date.split("-")[1]));
            tr.setDate(Long.parseLong(date.split("-")[2]));

            tr.setGameSeq(Long.parseLong(recordArray2[1]));

            tr.setBallPark(recordArray2[2]);
            tr.setType(recordArray2[3]);
            tr.setHomeAway(recordArray2[4]);
            tr.setOpponent(recordArray2[5]);
            tr.setResult(recordArray2[6].trim());


            this.recordService.createTeamRecordByDate(tr);
        }

        return "redirect:/back/createRecordView.do";
    }
}
