package com.cloudalibaba.gounanjiaoapi.controller;

import java.util.Arrays;
import java.util.Date;
import java.util.Map;

import com.cloudalibaba.gounanjiaoapi.entity.UserEntity;
import com.cloudalibaba.gounanjiaoapi.util.HostHolder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import com.cloudalibaba.gounanjiaoapi.entity.BusinesslogEntity;
import com.cloudalibaba.gounanjiaoapi.service.BusinesslogService;
import com.common.utils.PageUtils;
import com.common.utils.R;



/**
 * 
 *
 * @author zyj
 * @email 2901570623@qq.com
 * @date 2021-10-28 11:30:28
 */
@RestController
@RequestMapping("gounanjiaoapi/businesslog")
public class BusinesslogController {
    @Autowired
    private BusinesslogService businesslogService;
    @Autowired
    private HostHolder hostHolder;
    @GetMapping("/listbyuid")
    public R listbyuid(@RequestParam Map<String, Object> params){
        PageUtils page = businesslogService.queryPageByuid(params);

        return R.ok().put("page", page);
    }
    /**
     * 列表
     */
    @RequestMapping("/list")
    public R list(@RequestParam Map<String, Object> params){
        PageUtils page = businesslogService.queryPage(params);

        return R.ok().put("page", page);
    }


    /**
     * 信息
     */
    @RequestMapping("/info/{id}")
    public R info(@PathVariable("id") Integer id){
		BusinesslogEntity businesslog = businesslogService.getById(id);

        return R.ok().put("businesslog", businesslog);
    }

    /**
     * 保存
     */
    @RequestMapping("/save")
    public R save(@RequestBody BusinesslogEntity businesslog){
		businesslogService.save(businesslog);

        return R.ok();
    }
    @GetMapping("/saveByDate")
    public R date(){
        BusinesslogEntity businesslogEntity = new BusinesslogEntity();
        businesslogEntity.setUid(hostHolder.getUser().getId());
        businesslogEntity.setLogintime(new Date());
        businesslogEntity.setLogtime(new Date());
        businesslogService.save(businesslogEntity);
        return R.ok();
    }

    /**
     * 修改
     */
    @RequestMapping("/update")
    public R update(@RequestBody BusinesslogEntity businesslog){
		businesslogService.updateById(businesslog);

        return R.ok();
    }

    /**
     * 删除
     */
    @RequestMapping("/delete")
    public R delete(@RequestBody Integer[] ids){
		businesslogService.removeByIds(Arrays.asList(ids));

        return R.ok();
    }

}
