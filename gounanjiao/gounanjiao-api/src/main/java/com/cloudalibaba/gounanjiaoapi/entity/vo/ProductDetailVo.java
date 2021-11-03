package com.cloudalibaba.gounanjiaoapi.entity.vo;

import com.cloudalibaba.gounanjiaoapi.entity.ProductEntity;
import com.cloudalibaba.gounanjiaoapi.entity.PropertyEntity;
import com.cloudalibaba.gounanjiaoapi.entity.PropertyvalueEntity;
import com.cloudalibaba.gounanjiaoapi.entity.ReviewEntity;
import lombok.Data;

import java.io.Serializable;
import java.util.List;

@Data
public class ProductDetailVo implements Serializable {
    private static final long serialVersionUID = 1L;

    private ProductEntity product;

    private List<ReviewEntity> reviews;

    private List<PropertyEntity> pvs;

}
