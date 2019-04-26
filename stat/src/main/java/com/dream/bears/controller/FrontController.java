package com.dream.bears.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dream.bears.model.TeamRecord;
import com.dream.bears.service.StatService;

@Controller
public class FrontController {
    @Autowired
    private StatService statService;
    
    /*@RequestMapping(value = "/main")
    public String main(ModelMap map, Long year) {
        if (year == null) {
            year = 2009L;
        }

        map.addAttribute("list", this.statService.getBattersStatByYear(year));
        map.addAttribute("year", year);
        
        return "/front/main";
    }*/
    
    @RequestMapping(value = "/battersStatView")
    public String battersStatView(ModelMap map, Long year, Long pa) {
        if (year == null) {
            year = 9999L;
        }
        
        if (pa == null) {
            pa = 0L;
        }
        
        map.addAttribute("list", this.statService.getBattersStatByYear(year, pa));
        map.addAttribute("year", year);
        map.addAttribute("pa", pa);
        
        return "/front/battersStatView";
    }
    
    @RequestMapping(value = "/pitchersStatView")
    public String pitchersStatView(ModelMap map, Long year, Long ip) {
        if (year == null) {
            year = 9999L;
        }
        
        if (ip == null) {
            ip = 0L;
        }

        map.addAttribute("list", this.statService.getPitchersStatByYear(year, ip));
        map.addAttribute("year", year);
        map.addAttribute("ip", ip);
        
        return "/front/pitchersStatView";
    }
    
    @RequestMapping(value = "/teamTotalStatView")
    public String teamTotalStatView(ModelMap map, Long year) {
        if (year == null) {
            year = 9999L;
        }

        map.addAttribute("list", this.statService.getTeamTotalStat());
        map.addAttribute("year", year);
         
        return "/front/teamTotalStatView";
    }
    
    @RequestMapping(value = "/teamStatsView")
    public String teamStatsView(ModelMap map, Long year) {
        if (year == null) {
            year = 9999L;
        }
        
        List<TeamRecord> list = null;
        map.addAttribute("year", year);
        
        if (year == 9999L) {
            list = this.statService.getTeamTotalStat();
            map.addAttribute("list", list);
            return "/front/teamTotalStatView";
        } else {
            list = this.statService.getTeamStatsByYear(year);
            map.addAttribute("list", list);
            return "/front/teamStatsView";
        }
    }
    
    @RequestMapping(value = "/batterStatsView")
    public String batterStatsView(ModelMap map, String name) {
        map.addAttribute("list", this.statService.getBatterStatsByName(name));
        
        return "/front/batterStatsView";
    }
    
    @RequestMapping(value = "/pitcherStatsView")
    public String pitcherStatsView(ModelMap map, String name) {
        map.addAttribute("list", this.statService.getPitcherStatsByName(name));
        
        return "/front/pitcherStatsView";
    }

}
