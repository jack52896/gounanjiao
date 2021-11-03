package com.cloudalibaba.gounanjiaoapi.controller;

import java.util.Arrays;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import com.cloudalibaba.gounanjiaoapi.entity.PropertyEntity;
import com.cloudalibaba.gounanjiaoapi.service.PropertyService;
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
@RequestMapping("gounanjiaoapi/property")
public class PropertyController {
    @Autowired
    private PropertyService propertyService;

    /**
     * 列表
     */
    @GetMapping("/list")
    public R list(@RequestParam Map<String, Object> params){
        PageUtils page = propertyService.queryPage(params);

        return R.ok().put("page", page);
    }


    /**
     * 信息
     */
    @GetMapping("/info/{id}")
    public R info(@PathVariable("id") Integer id){
		PropertyEntity property = propertyService.getById(id);

        return R.ok().put("property", property);
    }

    /**
     * 保存
     */
    @PostMapping("/save")
    public R save(@RequestBody PropertyEntity property){
		propertyService.save(property);

        return R.ok();
    }

    /**
     * 修改
     */
    @PostMapping("/update")
    public R update(@RequestBody PropertyEntity property){
		propertyService.updateById(property);

        return R.ok();
    }

    /**
     * 删除
     */
    @PostMapping("/delete")
    public R delete(@RequestBody Integer[] ids){
		propertyService.removeByIds(Arrays.asList(ids));

        return R.ok();
    }

}
