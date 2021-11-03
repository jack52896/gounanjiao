package com.cloudalibaba.gounanjiaoapi.controller;

import java.util.Arrays;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import com.cloudalibaba.gounanjiaoapi.entity.ReviewEntity;
import com.cloudalibaba.gounanjiaoapi.service.ReviewService;
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
@RequestMapping("gounanjiaoapi/review")
public class ReviewController {
    @Autowired
    private ReviewService reviewService;

    /**
     * 列表
     */
    @GetMapping("/list")
    public R list(@RequestParam Map<String, Object> params){
        PageUtils page = reviewService.queryPage(params);

        return R.ok().put("page", page);
    }


    /**
     * 信息
     */
    @GetMapping("/info/{id}")
    public R info(@PathVariable("id") Integer id){
		ReviewEntity review = reviewService.getById(id);

        return R.ok().put("review", review);
    }

    /**
     * 保存
     */
    @PostMapping("/save")
    public R save(@RequestBody ReviewEntity review){
		reviewService.save(review);

        return R.ok();
    }

    /**
     * 修改
     */
    @PostMapping("/update")
    public R update(@RequestBody ReviewEntity review){
		reviewService.updateById(review);

        return R.ok();
    }

    /**
     * 删除
     */
    @PostMapping("/delete")
    public R delete(@RequestBody Integer[] ids){
		reviewService.removeByIds(Arrays.asList(ids));

        return R.ok();
    }

}
