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

import com.cloudalibaba.gounanjiaoapi.dao.CouponDao;
import com.cloudalibaba.gounanjiaoapi.entity.CouponEntity;
import com.cloudalibaba.gounanjiaoapi.service.CouponService;


@Service("couponService")
public class CouponServiceImpl extends ServiceImpl<CouponDao, CouponEntity> implements CouponService {
    @Autowired
    private HostHolder hostHolder;
    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        IPage<CouponEntity> page = this.page(
                new Query<CouponEntity>().getPage(params),
                new QueryWrapper<CouponEntity>()
        );

        return new PageUtils(page);
    }

    @Override
    public PageUtils queryPageByuid(Map<String, Object> params) {
        IPage<CouponEntity> page = this.page(
                new Query<CouponEntity>().getPage(params),
                new QueryWrapper<CouponEntity>().eq("uid",hostHolder.getUser().getId())
        );

        return new PageUtils(page);
    }
}