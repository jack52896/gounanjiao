package com.cloudalibaba.gounanjiaoapi.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import lombok.Data;

/**
 * 
 * 
 * @author zyj
 * @email 2901570623@qq.com
 * @date 2021-10-22 20:22:05
 */
@Data
@TableName("product")
public class ProductEntity implements Serializable {
	private static final long serialVersionUID = 1L;

	/**
	 * 产品id
	 */
	@TableId
	private Integer id;
	/**
	 * 产品名称
	 */
	private String name;
	/**
	 * 产品副标题
	 */
	private String subtitle;
	/**
	 * 原价格
	 */
	private Float originalprice;
	/**
	 * 促销价格
	 */
	private Float promoteprice;
	/**
	 * 库存
	 */
	private Integer stock;
	/**
	 * 分类id
	 */
	private Integer cid;
	/**
	 * 创建时间
	 */
	private Date createdate;

	@TableField(exist = false)
	private CategoryEntity category;

	@TableField(exist = false)
	private ProductimageEntity firstProductImage;

	@TableField(exist = false)
	private List<ProductimageEntity> productSingleImages;

	@TableField(exist = false)
	private List<ProductimageEntity> productDetailImages;

	@TableField(exist = false)
	private int reviewCount;

	@TableField(exist = false)
	private int saleCount;

	private Integer thirduid;

	private Integer status;
}
