package com.cloudalibaba.gounanjiaoapi.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.common.utils.PageUtils;
import com.cloudalibaba.gounanjiaoapi.entity.BusinesslogEntity;

import java.util.Map;

/**
 * 
 *
 * @author zyj
 * @email 2901570623@qq.com
 * @date 2021-10-28 11:30:28
 */
public interface BusinesslogService extends IService<BusinesslogEntity> {

    PageUtils queryPage(Map<String, Object> params);

    PageUtils queryPageByuid(Map<String, Object> parms);
}

