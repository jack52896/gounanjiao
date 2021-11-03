package com.cloudalibaba.gounanjiaoapi.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.common.utils.PageUtils;
import com.cloudalibaba.gounanjiaoapi.entity.PropertyvalueEntity;

import java.util.Map;

/**
 * 
 *
 * @author zyj
 * @email 2901570623@qq.com
 * @date 2021-10-22 20:22:05
 */
public interface PropertyvalueService extends IService<PropertyvalueEntity> {

    PageUtils queryPage(Map<String, Object> params);
}

