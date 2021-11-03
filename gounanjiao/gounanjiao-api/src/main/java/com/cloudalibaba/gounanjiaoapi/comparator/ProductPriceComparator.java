

package com.cloudalibaba.gounanjiaoapi.comparator;


import java.util.Comparator;

import com.cloudalibaba.gounanjiaoapi.entity.ProductEntity;

public class ProductPriceComparator implements Comparator<ProductEntity> {

	@Override
	public int compare(ProductEntity p1, ProductEntity p2) {
		return (int) (p1.getPromoteprice()-p2.getPromoteprice());
	}

}

/**
* 模仿天猫整站 springboot 教程 为 how2j.cn 版权所有
* 本教程仅用于学习使用，切勿用于非法用途，由此引起一切后果与本站无关
* 供购买者学习，请勿私自传播，否则自行承担相关法律责任
*/	
