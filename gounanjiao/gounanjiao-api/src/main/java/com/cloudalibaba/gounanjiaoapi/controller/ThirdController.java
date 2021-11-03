package com.cloudalibaba.gounanjiaoapi.controller;

import java.util.Arrays;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import com.cloudalibaba.gounanjiaoapi.entity.ThirdEntity;
import com.cloudalibaba.gounanjiaoapi.service.ThirdService;
import com.common.utils.PageUtils;
import com.common.utils.R;



/**
 * 
 *
 * @author zyj
 * @email 2901570623@qq.com
 * @date 2021-10-27 10:41:12
 */
@RestController
@RequestMapping("gounanjiaoapi/third")
public class ThirdController {
    @Autowired
    private ThirdService thirdService;

    /**
     * 列表
     */
    @GetMapping("/list")
    public R list(@RequestParam Map<String, Object> params){
        PageUtils page = thirdService.queryPage(params);

        return R.ok().put("page", page);
    }


    /**
     * 信息
     */
    @GetMapping("/info/{id}")
    public R info(@PathVariable("id") Integer id){
		ThirdEntity third = thirdService.getById(id);

        return R.ok().put("third", third);
    }

    /**
     * 保存
     */
    @PostMapping("/save")
    public R save(@RequestBody ThirdEntity third){
		thirdService.save(third);

        return R.ok();
    }

    /**
     * 修改
     */
    @PostMapping("/update")
    public R update(@RequestBody ThirdEntity third){
		thirdService.updateById(third);

        return R.ok();
    }

    /**
     * 删除
     */
    @PostMapping("/delete")
    public R delete(@RequestBody Integer[] ids){
		thirdService.removeByIds(Arrays.asList(ids));

        return R.ok();
    }

}
