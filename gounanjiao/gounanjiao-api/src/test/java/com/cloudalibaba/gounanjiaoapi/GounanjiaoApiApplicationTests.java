package com.cloudalibaba.gounanjiaoapi;

import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.cloudalibaba.gounanjiaoapi.entity.ProductEntity;
import com.cloudalibaba.gounanjiaoapi.entity.UserEntity;
import com.cloudalibaba.gounanjiaoapi.service.ProductService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.data.redis.core.RedisTemplate;

import java.util.List;

@SpringBootTest
class GounanjiaoApiApplicationTests {
    @Autowired
    private RedisTemplate<String, String> redisTemplate;
    @Autowired
    private ProductService productService;
    @Test
    void contextLoads() {
        UserEntity userEntity = JSONObject.parseObject(redisTemplate.opsForValue().get("86e3959fd50c40f884850820aee66583"), UserEntity.class);
        System.out.println(userEntity);
    }
    @Test
    void baga(){
        List<ProductEntity> productEntityList = productService.list(
                new QueryWrapper<ProductEntity>()
        );
        for (ProductEntity productEntity : productEntityList) {
            productEntity.setStatus(1);
            productEntity.setThirduid(11);
            productService.updateById(productEntity);
        }
    }

}
