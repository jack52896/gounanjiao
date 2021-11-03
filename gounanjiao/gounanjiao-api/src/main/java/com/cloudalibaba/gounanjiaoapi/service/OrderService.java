package com.cloudalibaba.gounanjiaoapi.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.cloudalibaba.gounanjiaoapi.entity.OrderitemEntity;
import com.common.utils.PageUtils;
import com.cloudalibaba.gounanjiaoapi.entity.OrderEntity;

import java.util.List;
import java.util.Map;

/**
 * 
 *
 * @author zyj
 * @email 2901570623@qq.com
 * @date 2021-10-22 20:22:05
 */
public interface OrderService extends IService<OrderEntity> {

    PageUtils queryPage(Map<String, Object> params);

    float add(OrderEntity orderEntity, List<OrderitemEntity> orderitemEntities);

    void fill(OrderEntity orderEntity);
}

