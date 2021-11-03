package com.cloudalibaba.gounanjiaoapi.service.impl;

import com.cloudalibaba.gounanjiaoapi.dao.ProductDao;
import com.cloudalibaba.gounanjiaoapi.entity.OrderitemEntity;
import com.cloudalibaba.gounanjiaoapi.entity.ProductEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.common.utils.PageUtils;
import com.common.utils.Query;

import com.cloudalibaba.gounanjiaoapi.dao.OrderDao;
import com.cloudalibaba.gounanjiaoapi.entity.OrderEntity;
import com.cloudalibaba.gounanjiaoapi.service.OrderService;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;


@Service("orderService")
public class OrderServiceImpl extends ServiceImpl<OrderDao, OrderEntity> implements OrderService {
    @Autowired
    private OrderDao orderDao;
    @Autowired
    private ProductDao productDao;
    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        IPage<OrderEntity> page = this.page(
                new Query<OrderEntity>().getPage(params),
                new QueryWrapper<OrderEntity>()
        );

        return new PageUtils(page);
    }

    @Override
    @CacheEvict(allEntries=true)
    @Transactional(propagation= Propagation.REQUIRED, rollbackForClassName="Exception")
    public float add(OrderEntity orderEntity, List<OrderitemEntity> orderitemEntities) {
        float total = 0 ;
        orderDao.insert(orderEntity);
        for (OrderitemEntity orderitemEntity : orderitemEntities) {
            orderitemEntity.setOid(orderEntity.getId());
            ProductEntity productEntity = productDao.selectOne(
                    new QueryWrapper<ProductEntity>().eq("id", orderitemEntity.getPid())
            );
            total += orderitemEntity.getNumber() * productEntity.getPromoteprice();
        }
        return total;
    }

    @Override
    public void fill(OrderEntity orderEntity) {
        
    }
}