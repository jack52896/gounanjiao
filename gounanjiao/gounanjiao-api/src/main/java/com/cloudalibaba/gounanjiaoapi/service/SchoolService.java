package com.cloudalibaba.gounanjiaoapi.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.common.utils.PageUtils;
import com.cloudalibaba.gounanjiaoapi.entity.SchoolEntity;

import java.util.Map;

/**
 * 
 *
 * @author zyj
 * @email 2901570623@qq.com
 * @date 2021-10-27 23:42:50
 */
public interface SchoolService extends IService<SchoolEntity> {

    PageUtils queryPage(Map<String, Object> params);
}

