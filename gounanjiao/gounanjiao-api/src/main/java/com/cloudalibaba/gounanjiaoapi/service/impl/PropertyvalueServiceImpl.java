package com.cloudalibaba.gounanjiaoapi.service.impl;

import org.springframework.stereotype.Service;
import java.util.Map;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.common.utils.PageUtils;
import com.common.utils.Query;

import com.cloudalibaba.gounanjiaoapi.dao.PropertyvalueDao;
import com.cloudalibaba.gounanjiaoapi.entity.PropertyvalueEntity;
import com.cloudalibaba.gounanjiaoapi.service.PropertyvalueService;


@Service("propertyvalueService")
public class PropertyvalueServiceImpl extends ServiceImpl<PropertyvalueDao, PropertyvalueEntity> implements PropertyvalueService {

    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        IPage<PropertyvalueEntity> page = this.page(
                new Query<PropertyvalueEntity>().getPage(params),
                new QueryWrapper<PropertyvalueEntity>()
        );

        return new PageUtils(page);
    }

}