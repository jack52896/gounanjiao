package com.cloudalibaba.gounanjiaoapi.web.interceptor;

import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.cloudalibaba.gounanjiaoapi.dao.UserDao;
import com.cloudalibaba.gounanjiaoapi.entity.UserEntity;
import com.cloudalibaba.gounanjiaoapi.service.UserService;
import com.cloudalibaba.gounanjiaoapi.util.CookieUtil;
import com.cloudalibaba.gounanjiaoapi.util.HostHolder;
import com.google.j2objc.annotations.AutoreleasePool;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Component
public class LoginTokenInterceptor implements HandlerInterceptor {
    @Autowired
    private RedisTemplate<String, Object> redisTemplate;
    @Autowired
    private HostHolder hostHolder;
    @Autowired
    private UserDao userDao;
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        String cookie = CookieUtil.getValue(request, "token");
        if(cookie != null){
            String json  = (String) redisTemplate.opsForValue().get(cookie);
            if(json != null){
                UserEntity user = JSONObject.parseObject(json, UserEntity.class);
                UserEntity userEntity = userDao.selectOne(
                        new QueryWrapper<UserEntity>().eq("name", user.getName())
                );
                hostHolder.setUsers(userEntity);
            }
        }
        return true;
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
        String cookie = CookieUtil.getValue(request, "token");
        System.out.println(cookie);
        if(cookie != null){
            String json  = (String) redisTemplate.opsForValue().get(cookie);
            if(json != null && hostHolder.getUser() != null && modelAndView != null){
                modelAndView.addObject("loginUser", hostHolder.getUser());
            }
        }
    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
        HandlerInterceptor.super.afterCompletion(request, response, handler, ex);
    }
}
