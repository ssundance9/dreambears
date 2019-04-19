package com.dream.bears.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dream.bears.service.RecordService;

@Controller
public class FrontController {
    @Autowired
    private RecordService recordService;
    
    
    
    @RequestMapping(value = "/main")
    public String createMemberView(ModelMap map, Long year) {
        if (year == null) {
            year = 2009L;
        }

        map.addAttribute("list", this.recordService.getBattersRecordByYear(year));
        
        return "/front/main";
    }

}
