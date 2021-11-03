package com.cloudalibaba.gounanjiaoapi.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.cloudalibaba.gounanjiaoapi.entity.OrderitemEntity;
import com.cloudalibaba.gounanjiaoapi.entity.ProductEntity;
import com.cloudalibaba.gounanjiaoapi.service.OrderitemService;
import com.cloudalibaba.gounanjiaoapi.service.ProductService;
import com.cloudalibaba.gounanjiaoapi.util.HostHolder;
import com.google.j2objc.annotations.AutoreleasePool;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import com.cloudalibaba.gounanjiaoapi.entity.OrderEntity;
import com.cloudalibaba.gounanjiaoapi.service.OrderService;
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
@RequestMapping("gounanjiaoapi/order")
public class OrderController {
    @Autowired
    private OrderService orderService;
    @Autowired
    private HostHolder hostHolder;
    @Autowired
    private OrderitemService orderitemService;
    @Autowired
    private ProductService productService;
    @GetMapping("/listByPid")
    public R listByPid(){
        List<ProductEntity> productEntities = productService.list(
                new QueryWrapper<ProductEntity>().eq("thirduid", hostHolder.getUser().getId())
        );
        List<Integer> pids = productEntities.stream().map(ProductEntity::getId).collect(Collectors.toList());
        List<OrderitemEntity> orderitemEntities = new ArrayList<>();
        for (Integer pid : pids) {
            List<OrderitemEntity> list = orderitemService.list(
                    new QueryWrapper<OrderitemEntity>().eq("pid", pid)
            );
            orderitemEntities.addAll(list);
        }
        List<Integer> ooids = orderitemEntities.stream().map(OrderitemEntity::getOid).collect(Collectors.toList());
        List<OrderEntity> orderEntities = null;
        if (!ooids.isEmpty()) {
            orderEntities = orderService.listByIds(ooids);
        }
        return R.ok().put("data", orderEntities);
    }
    /**
     * 列表
     */
    @GetMapping("/list")
    public R list(@RequestParam Map<String, Object> params){
        PageUtils page = orderService.queryPage(params);

        return R.ok().put("page", page);
    }


    /**
     * 信息
     */
    @GetMapping("/info/{id}")
    public R info(@PathVariable("id") Integer id){
		OrderEntity order = orderService.getById(id);

        return R.ok().put("order", order);
    }

    /**
     * 保存
     */
    @PostMapping("/save")
    public R save(@RequestBody OrderEntity order){
		orderService.save(order);

        return R.ok();
    }

    /**
     * 修改
     */
    @PostMapping("/update")
    public R update(@RequestBody OrderEntity order){
		orderService.updateById(order);

        return R.ok();
    }

    /**
     * 删除
     */
    @PostMapping("/delete")
    public R delete(@RequestBody Integer[] ids){
		orderService.removeByIds(Arrays.asList(ids));

        return R.ok();
    }

}
