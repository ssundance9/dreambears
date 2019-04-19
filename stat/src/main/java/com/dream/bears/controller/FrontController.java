package com.dream.bears.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dream.bears.service.StatService;

@Controller
public class FrontController {
    @Autowired
    private StatService statService;
    
    @RequestMapping(value = "/main")
    public String main(ModelMap map, Long year) {
        if (year == null) {
            year = 2009L;
        }

        map.addAttribute("list", this.statService.getBattersStatByYear(year));
        map.addAttribute("year", year);
        
        return "/front/main";
    }
    
    /*@RequestMapping(value = "/battersStatView")
    public String battersStatView(ModelMap map, Long year) {
        if (year == null) {
            year = 2009L;
        }

        map.addAttribute("list", this.statService.getBattersStatByYear(year));
        map.addAttribute("year", year);
        
        return "/front/battersStatView";
    }*/
    
    @RequestMapping(value = "/pitchersStatView")
    public String pitchersStatView(ModelMap map, Long year) {
        if (year == null) {
            year = 2009L;
        }

        map.addAttribute("list", this.statService.getPitchersStatByYear(year));
        map.addAttribute("year", year);
        
        return "/front/pitchersStatView";
    }
    
    @RequestMapping(value = "/teamStatView")
    public String teamStatView(ModelMap map, Long year) {
        if (year == null) {
            year = 2009L;
        }

        map.addAttribute("list", this.statService.getPitchersStatByYear(year));
        map.addAttribute("year", year);
        
        return "/front/teamStatView";
    }
    
    @RequestMapping(value = "/palyerStatView")
    public String palyerStatView(ModelMap map, String name) {

        map.addAttribute("list", this.statService.getBatterStatsByName(name));
        
        return "/front/palyerStatView";
    }

}
