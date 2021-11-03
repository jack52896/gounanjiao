package com.cloudalibaba.gounanjiaoapi.service.impl;

import com.cloudalibaba.gounanjiaoapi.entity.Token;
import com.cloudalibaba.gounanjiaoapi.util.CookieUtil;
import com.cloudalibaba.gounanjiaoapi.util.HostHolder;
import com.common.utils.R;
import com.google.common.hash.HashingOutputStream;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.data.redis.core.RedisOperations;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.SessionCallback;
import org.springframework.stereotype.Service;
import java.util.Map;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.common.utils.PageUtils;
import com.common.utils.Query;

import com.cloudalibaba.gounanjiaoapi.dao.UserDao;
import com.cloudalibaba.gounanjiaoapi.entity.UserEntity;
import com.cloudalibaba.gounanjiaoapi.service.UserService;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@Service("userService")
public class UserServiceImpl extends ServiceImpl<UserDao, UserEntity> implements UserService {
    @Autowired
    private UserDao userDao;
    @Autowired
    private HostHolder hostHolder;
    @Autowired
    RedisTemplate<String, Object> redisTemplate;
    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        IPage<UserEntity> page = this.page(
                new Query<UserEntity>().getPage(params),
                new QueryWrapper<UserEntity>()
        );

        return new PageUtils(page);
    }

    @Override
    public R existUser(UserEntity userEntity) {
        UserEntity user = userDao.selectOne(new QueryWrapper<UserEntity>().eq("name", userEntity.getName()));
        if(user == null){
            return R.error().put("message", "亲, 是不是没有账号, 去注册一个吧 "+ "<a href = '/register'>去注册</a>");
        }
        if(user.getName().equals(userEntity.getName())){
            if(user.getPassword().equals(userEntity.getPassword())){
                if (user.getActivate().equals(1)) {
                    Token token = new Token();
                    token.setToken(CookieUtil.generateUUID());
                    token.setUserEntity(userEntity);
                    return R.ok().put("Token", token).put("id", user.getStatus());
                }else if(user.getActivate().equals(0)){
                    return R.error().put("message", "账号还没有激活哦, 请联系学校管理员激活账号");
                }else{
                    return R.error().put("message", "您的商家入驻申请已被拒绝!, 请联系学校管理员");
                }
            }
            return R.error().put("message", "亲, 账号密码错误哦");
        }
        return R.error();
    }

    @Override
    public void logout(HttpServletRequest request, String value, HttpServletResponse response) {
        hostHolder.clear();
        Cookie[] cookies = request.getCookies();
        for (Cookie cookie : cookies) {
            if(cookie.getName().equalsIgnoreCase(value)){
                cookie.setPath("/");
                cookie.setMaxAge(0);
                response.addCookie(cookie);
                redisTemplate.execute(new SessionCallback() {
                    @Override
                    public Object execute(RedisOperations operations) throws DataAccessException {
                        operations.multi();
                        operations.delete(cookie.getValue());
                        return operations.exec();
                    }
                });
            }
        }
    }
}