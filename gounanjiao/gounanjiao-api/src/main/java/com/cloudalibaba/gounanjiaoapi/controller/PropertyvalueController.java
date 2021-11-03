package com.cloudalibaba.gounanjiaoapi.controller;

import java.util.Arrays;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import com.cloudalibaba.gounanjiaoapi.entity.PropertyvalueEntity;
import com.cloudalibaba.gounanjiaoapi.service.PropertyvalueService;
import com.common.utils.PageUtils;
import com.common.utils.R;



/**
 * 
 *
 * @author zyj
 * @email 2901570623@qq.com
 * @date 2021-10-22 20:22:05
 */
@RestController
@RequestMapping("gounanjiaoapi/propertyvalue")
public class PropertyvalueController {
    @Autowired
    private PropertyvalueService propertyvalueService;

    /**
     * 列表
     */
    @GetMapping("/list")
    public R list(@RequestParam Map<String, Object> params){
        PageUtils page = propertyvalueService.queryPage(params);

        return R.ok().put("page", page);
    }


    /**
     * 信息
     */
    @GetMapping("/info/{id}")
    public R info(@PathVariable("id") Integer id){
		PropertyvalueEntity propertyvalue = propertyvalueService.getById(id);

        return R.ok().put("propertyvalue", propertyvalue);
    }

    /**
     * 保存
     */
    @PostMapping("/save")
    public R save(@RequestBody PropertyvalueEntity propertyvalue){
		propertyvalueService.save(propertyvalue);

        return R.ok();
    }

    /**
     * 修改
     */
    @PostMapping("/update")
    public R update(@RequestBody PropertyvalueEntity propertyvalue){
		propertyvalueService.updateById(propertyvalue);

        return R.ok();
    }

    /**
     * 删除
     */
    @PostMapping("/delete")
    public R delete(@RequestBody Integer[] ids){
		propertyvalueService.removeByIds(Arrays.asList(ids));

        return R.ok();
    }

}
