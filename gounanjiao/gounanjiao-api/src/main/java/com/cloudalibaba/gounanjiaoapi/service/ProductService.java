package com.cloudalibaba.gounanjiaoapi.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.cloudalibaba.gounanjiaoapi.entity.CategoryEntity;
import com.cloudalibaba.gounanjiaoapi.entity.OrderitemEntity;
import com.common.utils.PageUtils;
import com.cloudalibaba.gounanjiaoapi.entity.ProductEntity;

import java.util.List;
import java.util.Map;

/**
 * 
 *
 * @author zyj
 * @email 2901570623@qq.com
 * @date 2021-10-22 20:22:05
 */
public interface ProductService extends IService<ProductEntity> {

    PageUtils queryPage(Map<String, Object> params);

    PageUtils queryPageByuid(Map<String, Object> params);

    void setSale(ProductEntity productEntity);

    void fill(List<CategoryEntity> categoryEntityList);

    void fill(CategoryEntity categoryEntity);

    void fillByRow(List<CategoryEntity> categories);

    void setFirstProdutImages(List<ProductEntity> products);

    void setFirstProdutImage(ProductEntity product);

    void setProductImages(ProductEntity productEntity);

    void setProductDetailImages(ProductEntity productEntity);

    void setFirstProdutImage(List<OrderitemEntity> orderitemEntities);

    void setFirstProdutImage(OrderitemEntity orderitemEntity);
}

