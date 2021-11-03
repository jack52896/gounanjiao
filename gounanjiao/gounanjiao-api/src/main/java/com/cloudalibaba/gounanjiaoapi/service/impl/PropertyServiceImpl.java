package com.cloudalibaba.gounanjiaoapi.service.impl;

import org.springframework.stereotype.Service;
import java.util.Map;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.common.utils.PageUtils;
import com.common.utils.Query;

import com.cloudalibaba.gounanjiaoapi.dao.PropertyDao;
import com.cloudalibaba.gounanjiaoapi.entity.PropertyEntity;
import com.cloudalibaba.gounanjiaoapi.service.PropertyService;


@Service("propertyService")
public class PropertyServiceImpl extends ServiceImpl<PropertyDao, PropertyEntity> implements PropertyService {

    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        IPage<PropertyEntity> page = this.page(
                new Query<PropertyEntity>().getPage(params),
                new QueryWrapper<PropertyEntity>()
        );

        return new PageUtils(page);
    }

}