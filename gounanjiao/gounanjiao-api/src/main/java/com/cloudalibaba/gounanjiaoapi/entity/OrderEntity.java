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
@TableName("orders")
public class OrderEntity implements Serializable {
	private static final long serialVersionUID = 1L;

	/**
	 * 订单id
	 */
	@TableId
	private Integer id;
	/**
	 * 订单项id
	 */
	private String ordercode;
	/**
	 * 地址
	 */
	private String address;
	/**
	 * 
	 */
	private String post;
	/**
	 * 
	 */
	private String receiver;
	/**
	 * 手机号码
	 */
	private String mobile;
	/**
	 * 用户信息
	 */
	private String usermessage;
	/**
	 * 创建时间
	 */
	private Date createdate;
	/**
	 * 支付时间
	 */
	private Date paydate;
	/**
	 * 订单发货时间
	 */
	private Date deliverydate;
	/**
	 * 订单收到时间
	 */
	private Date confirmdate;
	/**
	 * 用户id
	 */
	private Integer uid;
	/**
	 * 订单状态
	 */
	private String status;

	@TableField(exist = false)
	private List<OrderitemEntity> orderItems;

	@TableField(exist = false)
	private float totalNumber;

	@TableField(exist = false)
	private float total;

	private Integer thirduid;
}
