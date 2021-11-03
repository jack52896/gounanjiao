package com.cloudalibaba.gounanjiaoapi.controller;

import java.util.Arrays;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import com.cloudalibaba.gounanjiaoapi.entity.ProductEntity;
import com.cloudalibaba.gounanjiaoapi.service.ProductService;
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
@RequestMapping("gounanjiaoapi/product")
public class ProductController {
    @Autowired
    private ProductService productService;
    @GetMapping("/listByUid")
    public R listByUid(@RequestParam Map<String, Object> params){
        PageUtils page = productService.queryPageByuid(params);

        return R.ok().put("page", page);
    }
    @PostMapping("/editproductstatustoxiajia")
    public R editxiajia(@RequestParam("pid") Integer pid){
        ProductEntity productEntity = productService.getById(pid);
        productEntity.setStatus(0);
        productService.updateById(productEntity);
        return R.ok();
    }
    @PostMapping("/editproductstatus")
    public R edit(@RequestParam("pid") Integer pid){
        ProductEntity productEntity = productService.getById(pid);
        productEntity.setStatus(3);
        productService.updateById(productEntity);
        return R.ok();
    }
    /**
     * 列表
     */
    @GetMapping("/list")
    public R list(@RequestParam Map<String, Object> params){
        PageUtils page = productService.queryPage(params);

        return R.ok().put("page", page);
    }


    /**
     * 信息
     */
    @GetMapping("/info/{id}")
    public R info(@PathVariable("id") Integer id){
		ProductEntity product = productService.getById(id);

        return R.ok().put("product", product);
    }

    /**
     * 保存
     */
    @PostMapping("/save")
    public R save(@RequestBody ProductEntity product){
		productService.save(product);

        return R.ok();
    }

    /**
     * 修改
     */
    @PostMapping("/update")
    public R update(@RequestBody ProductEntity product){
		productService.updateById(product);

        return R.ok();
    }

    /**
     * 删除
     */
    @PostMapping("/delete")
    public R delete(@RequestBody Integer[] ids){
		productService.removeByIds(Arrays.asList(ids));

        return R.ok();
    }

}
