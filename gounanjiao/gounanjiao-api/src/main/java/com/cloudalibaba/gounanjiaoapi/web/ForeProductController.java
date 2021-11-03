package com.cloudalibaba.gounanjiaoapi.web;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.cloudalibaba.gounanjiaoapi.dao.CategoryDao;
import com.cloudalibaba.gounanjiaoapi.dao.ProductDao;
import com.cloudalibaba.gounanjiaoapi.dao.ReviewDao;
import com.cloudalibaba.gounanjiaoapi.entity.CategoryEntity;
import com.cloudalibaba.gounanjiaoapi.entity.ProductEntity;
import com.cloudalibaba.gounanjiaoapi.entity.PropertyEntity;
import com.cloudalibaba.gounanjiaoapi.entity.ReviewEntity;
import com.cloudalibaba.gounanjiaoapi.entity.vo.ProductDetailVo;
import com.cloudalibaba.gounanjiaoapi.service.ProductService;
import com.cloudalibaba.gounanjiaoapi.service.PropertyService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;


@RestController
public class ForeProductController {
    @Autowired
    private ProductService productService;
    @Autowired
    private ProductDao productDao;
    @Autowired
    private CategoryDao categoryDao;
    @Autowired
    private PropertyService propertyService;
    @Autowired
    private ReviewDao reviewDao;
    @GetMapping("/foreproduct/{pid}")
    public Object id(@PathVariable("pid") int pid){
        ProductEntity productEntity = productDao.selectOne(new QueryWrapper<ProductEntity>().eq("id", pid));
        productService.setFirstProdutImage(productEntity);
        productService.setProductImages(productEntity);
        productService.setProductDetailImages(productEntity);
        List<PropertyEntity> propertyEntityList = propertyService.list(new QueryWrapper<PropertyEntity>().eq("cid", productEntity.getCid()));
        CategoryEntity categoryEntity = categoryDao.selectOne(new QueryWrapper<CategoryEntity>().eq("id", productEntity.getCid()));
        productEntity.setCategory(categoryEntity);
        List<ReviewEntity> reviewEntities = reviewDao.selectList(
                new QueryWrapper<ReviewEntity>().eq("pid", pid)
        );
        ProductDetailVo productVo = new ProductDetailVo();
        productVo.setPvs(propertyEntityList);
        productVo.setProduct(productEntity);
        productVo.setReviews(reviewEntities);
        return productVo;
    }
}
