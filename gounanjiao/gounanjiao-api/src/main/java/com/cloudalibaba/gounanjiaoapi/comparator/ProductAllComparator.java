
package com.cloudalibaba.gounanjiaoapi.comparator;

import java.util.Comparator;

import com.cloudalibaba.gounanjiaoapi.entity.ProductEntity;



public class ProductAllComparator implements Comparator<ProductEntity>{

	@Override
	public int compare(ProductEntity p1, ProductEntity p2) {
		return p2.getReviewCount()*p2.getSaleCount()-p1.getReviewCount()*p1.getSaleCount();
	}

}
