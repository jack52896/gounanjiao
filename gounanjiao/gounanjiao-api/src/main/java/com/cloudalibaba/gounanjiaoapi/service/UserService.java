package com.cloudalibaba.gounanjiaoapi.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.common.utils.PageUtils;
import com.cloudalibaba.gounanjiaoapi.entity.UserEntity;
import com.common.utils.R;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

/**
 * 
 *
 * @author zyj
 * @email 2901570623@qq.com
 * @date 2021-10-22 20:22:05
 */
public interface UserService extends IService<UserEntity> {

    void logout(HttpServletRequest request, String value, HttpServletResponse response);

    PageUtils queryPage(Map<String, Object> params);

    R existUser(UserEntity userEntity);
}

