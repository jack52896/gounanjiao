package com.cloudalibaba.gounanjiaoapi.service.impl;

import com.cloudalibaba.gounanjiaoapi.util.HostHolder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.Map;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.common.utils.PageUtils;
import com.common.utils.Query;

import com.cloudalibaba.gounanjiaoapi.dao.BusinesslogDao;
import com.cloudalibaba.gounanjiaoapi.entity.BusinesslogEntity;
import com.cloudalibaba.gounanjiaoapi.service.BusinesslogService;


@Service("businesslogService")
public class BusinesslogServiceImpl extends ServiceImpl<BusinesslogDao, BusinesslogEntity> implements BusinesslogService {
    @Autowired
    private HostHolder hostHolder;
    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        IPage<BusinesslogEntity> page = this.page(
                new Query<BusinesslogEntity>().getPage(params),
                new QueryWrapper<BusinesslogEntity>()
        );

        return new PageUtils(page);
    }

    @Override
    public PageUtils queryPageByuid(Map<String, Object> params) {
        IPage<BusinesslogEntity> page = this.page(
                new Query<BusinesslogEntity>().getPage(params),
                new QueryWrapper<BusinesslogEntity>().eq("uid", hostHolder.getUser().getId())
        );

        return new PageUtils(page);
    }
}