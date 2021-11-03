package com.cloudalibaba.gounanjiaoapi.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;

import java.io.Serializable;
import java.util.Date;
import lombok.Data;

/**
 * 
 * 
 * @author zyj
 * @email 2901570623@qq.com
 * @date 2021-10-22 20:22:05
 */
@Data
@TableName("orderitem")
public class OrderitemEntity implements Serializable {
	private static final long serialVersionUID = 1L;

	/**
	 * 订单项id
	 */
	@TableId
	private Integer id;
	/**
	 * 产品id
	 */
	private Integer pid;
	/**
	 * 订单id
	 */
	private Integer oid;
	/**
	 * 用户id
	 */
	private Integer uid;
	/**
	 * 该订单产品数量
	 */
	private Integer number;

	@TableField(exist = false)
	private ProductimageEntity firstProductImage;

	@TableField(exist = false)
	private ProductEntity product;
}
