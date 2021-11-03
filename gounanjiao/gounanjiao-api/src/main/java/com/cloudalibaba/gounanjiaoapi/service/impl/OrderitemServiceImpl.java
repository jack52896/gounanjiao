package com.cloudalibaba.gounanjiaoapi.service.impl;

import com.cloudalibaba.gounanjiaoapi.dao.ProductDao;
import com.cloudalibaba.gounanjiaoapi.entity.OrderEntity;
import com.cloudalibaba.gounanjiaoapi.entity.ProductEntity;
import com.cloudalibaba.gounanjiaoapi.service.ProductService;
import com.cloudalibaba.gounanjiaoapi.service.ProductimageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.common.utils.PageUtils;
import com.common.utils.Query;

import com.cloudalibaba.gounanjiaoapi.dao.OrderitemDao;
import com.cloudalibaba.gounanjiaoapi.entity.OrderitemEntity;
import com.cloudalibaba.gounanjiaoapi.service.OrderitemService;


@Service("orderitemService")
public class OrderitemServiceImpl extends ServiceImpl<OrderitemDao, OrderitemEntity> implements OrderitemService {
    @Autowired
    private OrderitemDao orderitemDao;
    @Autowired
    private ProductDao productDao;
    @Autowired
    private ProductService productService;
    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        IPage<OrderitemEntity> page = this.page(
                new Query<OrderitemEntity>().getPage(params),
                new QueryWrapper<OrderitemEntity>()
        );

        return new PageUtils(page);
    }

    @Override
    public void fill(OrderEntity orderEntity) {
        List<OrderitemEntity> list = orderitemDao.selectList(
                new QueryWrapper<OrderitemEntity>().eq("oid", orderEntity.getId())
        );
        float total = 0;
        int totalNumber = 0;
        for (OrderitemEntity oi :list) {
            ProductEntity productEntity = productDao.selectOne(
                    new QueryWrapper<ProductEntity>().eq("id", oi.getPid())
            );
            total+=oi.getNumber()*productEntity.getPromoteprice();
            totalNumber+=oi.getNumber();
            productService.setFirstProdutImage(oi);
        }
        orderEntity.setTotal(total);
        orderEntity.setOrderItems(list);
        orderEntity.setTotalNumber(totalNumber);
    }
}