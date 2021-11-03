package com.cloudalibaba.gounanjiaoapi.service.impl;

import org.springframework.stereotype.Service;
import java.util.Map;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.common.utils.PageUtils;
import com.common.utils.Query;

import com.cloudalibaba.gounanjiaoapi.dao.ReviewDao;
import com.cloudalibaba.gounanjiaoapi.entity.ReviewEntity;
import com.cloudalibaba.gounanjiaoapi.service.ReviewService;


@Service("reviewService")
public class ReviewServiceImpl extends ServiceImpl<ReviewDao, ReviewEntity> implements ReviewService {

    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        IPage<ReviewEntity> page = this.page(
                new Query<ReviewEntity>().getPage(params),
                new QueryWrapper<ReviewEntity>()
        );

        return new PageUtils(page);
    }

}