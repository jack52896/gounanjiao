package com.cloudalibaba.gounanjiaoapi.service.impl;

import com.cloudalibaba.gounanjiaoapi.dao.ProductimageDao;
import com.cloudalibaba.gounanjiaoapi.entity.*;
import com.cloudalibaba.gounanjiaoapi.service.OrderService;
import com.cloudalibaba.gounanjiaoapi.service.OrderitemService;
import com.cloudalibaba.gounanjiaoapi.util.HostHolder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.common.utils.PageUtils;
import com.common.utils.Query;

import com.cloudalibaba.gounanjiaoapi.dao.ProductDao;
import com.cloudalibaba.gounanjiaoapi.service.ProductService;


@Service("productService")
public class ProductServiceImpl extends ServiceImpl<ProductDao, ProductEntity> implements ProductService {
    public static final String type_single = "type_single";
    public static final String type_detail = "type_detail";
    @Autowired
    ProductDao productDao;
    @Autowired
    ProductimageDao productimageDao;
    @Autowired
    private HostHolder hostHolder;
    @Autowired
    private OrderService orderService;
    @Autowired
    private OrderitemService orderitemService;
    @Override
    public PageUtils queryPageByuid(Map<String, Object> params) {
        IPage<ProductEntity> page = this.page(
                new Query<ProductEntity>().getPage(params),
                new QueryWrapper<ProductEntity>().eq("thirdUid", hostHolder.getUser().getId())
        );

        return new PageUtils(page);
    }

    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        IPage<ProductEntity> page = this.page(
                new Query<ProductEntity>().getPage(params),
                new QueryWrapper<ProductEntity>()
        );

        return new PageUtils(page);
    }

    @Override
    public void setSale(ProductEntity productEntity) {
        List<OrderitemEntity> orderitemEntities = orderitemService.list(
                new QueryWrapper<OrderitemEntity>().eq("pid", productEntity.getId())
        );
        List<Integer> oids = orderitemEntities.stream().map(OrderitemEntity::getOid).collect(Collectors.toList());
        if (!oids.isEmpty()) {
            List<OrderEntity> orderEntities = orderService.listByIds(oids);
            int saleCount = orderEntities.size();
            productEntity.setSaleCount(saleCount);
        }else{
            productEntity.setSaleCount(0);
        }
    }

    /**
     * 装配category
     * @param categoryEntityList
     */
    @Override
    public void fill(List<CategoryEntity> categoryEntityList) {
        //填充category完整信息
        categoryEntityList.forEach((item)->{
            List<ProductEntity> productEntities = productDao.selectList(
                    new QueryWrapper<ProductEntity>().eq("cid", item.getId()).eq("status",1)
            );
            setFirstProdutImages(productEntities);
            item.setProducts(productEntities);
        });
    }

    @Override
    public void fill(CategoryEntity categoryEntity) {
        List<ProductEntity> productEntities = productDao.selectList(
                new QueryWrapper<ProductEntity>().eq("cid", categoryEntity.getId())
        );
        for (ProductEntity productEntity : productEntities) {
            setSale(productEntity);
        }
        setFirstProdutImages(productEntities);
        categoryEntity.setProducts(productEntities);
    }

    @Override
    public void fillByRow(List<CategoryEntity> categories) {
        int productNumberEachRow = 8;
        for(CategoryEntity category:categories){
            List<ProductEntity> products = category.getProducts();
            List<List<ProductEntity>> productsByRow = new ArrayList<>();
            for(int i=0;i<products.size();i+=productNumberEachRow){
                int size = i + productNumberEachRow;
                size = size>products.size() ? products.size() : size;
                List<ProductEntity> productsOfEachRow = products.subList(i,size);
                productsByRow.add(productsOfEachRow);
            }
            category.setProductsByRow(productsByRow);
        }
    }
    public List<ProductimageEntity> listSingleProductImages(ProductEntity product) {
        return productimageDao.selectList(new QueryWrapper<ProductimageEntity>().eq("pid", product.getId()).eq("type", type_single));
    }
    public List<ProductimageEntity> listDetailProductImages(ProductEntity product) {
        return productimageDao.selectList(new QueryWrapper<ProductimageEntity>().eq("pid", product.getId()).eq("type", type_detail));
    }

    @Override
    public void setFirstProdutImage(ProductEntity product) {
        List<ProductimageEntity> singleImages = listSingleProductImages(product);
        if(!singleImages.isEmpty()) {
            product.setFirstProductImage(singleImages.get(0));
        } else {
            product.setFirstProductImage(new ProductimageEntity());
        }
        //这样做是考虑到产品还没有来得及设置图片，但是在订单后台管理里查看订单项的对应产品图片。

    }
    @Override
    public void setFirstProdutImages(List<ProductEntity> products) {
        for (ProductEntity product : products) {
            setFirstProdutImage(product);
        }
    }

    @Override
    public void setProductImages(ProductEntity productEntity) {
        List<ProductimageEntity> productimageEntities =
                productimageDao.selectList(new QueryWrapper<ProductimageEntity>()
                        .eq("pid", productEntity.getId())
                        .eq("type", "type_single")
                );

        productEntity.setProductSingleImages(productimageEntities);
    }

    @Override
    public void setProductDetailImages(ProductEntity productEntity) {
        List<ProductimageEntity> productimageEntities = productimageDao.selectList(
                new QueryWrapper<ProductimageEntity>().eq("pid", productEntity.getId()).eq("type", "type_detail")
        );
        productEntity.setProductDetailImages(productimageEntities);
    }

    @Override
    public void setFirstProdutImage(List<OrderitemEntity> orderitemEntities) {
        for (OrderitemEntity orderitemEntity : orderitemEntities) {
            setFirstProdutImage(orderitemEntity);
        }
    }
    @Override
    public void setFirstProdutImage(OrderitemEntity orderitemEntity){
        List<ProductimageEntity> productimageEntities = productimageDao.selectList(
                new QueryWrapper<ProductimageEntity>().eq("pid", orderitemEntity.getPid()).eq("type", "type_single")
        );
        orderitemEntity.setFirstProductImage(productimageEntities.get(0));
    }
}