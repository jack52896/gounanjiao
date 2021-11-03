package com.cloudalibaba.gounanjiaoapi.service.impl;

import org.springframework.stereotype.Service;
import java.util.Map;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.common.utils.PageUtils;
import com.common.utils.Query;

import com.cloudalibaba.gounanjiaoapi.dao.ThirdDao;
import com.cloudalibaba.gounanjiaoapi.entity.ThirdEntity;
import com.cloudalibaba.gounanjiaoapi.service.ThirdService;


@Service("thirdService")
public class ThirdServiceImpl extends ServiceImpl<ThirdDao, ThirdEntity> implements ThirdService {

    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        IPage<ThirdEntity> page = this.page(
                new Query<ThirdEntity>().getPage(params),
                new QueryWrapper<ThirdEntity>()
        );

        return new PageUtils(page);
    }

}