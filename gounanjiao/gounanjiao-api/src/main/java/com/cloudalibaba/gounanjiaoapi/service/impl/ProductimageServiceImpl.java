package com.cloudalibaba.gounanjiaoapi.service.impl;

import org.springframework.stereotype.Service;
import java.util.Map;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.common.utils.PageUtils;
import com.common.utils.Query;

import com.cloudalibaba.gounanjiaoapi.dao.ProductimageDao;
import com.cloudalibaba.gounanjiaoapi.entity.ProductimageEntity;
import com.cloudalibaba.gounanjiaoapi.service.ProductimageService;


@Service("productimageService")
public class ProductimageServiceImpl extends ServiceImpl<ProductimageDao, ProductimageEntity> implements ProductimageService {

    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        IPage<ProductimageEntity> page = this.page(
                new Query<ProductimageEntity>().getPage(params),
                new QueryWrapper<ProductimageEntity>()
        );

        return new PageUtils(page);
    }

}