package com.cloudalibaba.gounanjiaoapi.web;

import org.springframework.stereotype.Controller;
import org.springframework.util.ResourceUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.FileNotFoundException;

@Controller
public class ViewController {
    //前台跳转
    @GetMapping("index")
    public String index(HttpSession session, HttpServletRequest request){
        try {
            System.out.println(ResourceUtils.getFile("classpath:").getPath());
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }
        return "fore/home";
    }
}
