package com.cloudalibaba.gounanjiaoapi.entity;

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
@TableName("coupon")
public class CouponEntity implements Serializable {
	private static final long serialVersionUID = 1L;

	/**
	 * 优惠卷id
	 */
	@TableId
	private Integer id;
	/**
	 * 优惠卷名称
	 */
	private String name;
	/**
	 * 减免金额
	 */
	private Float promotemoney;
	/**
	 * 获得时间
	 */
	private Date getDate;
	/**
	 * 失效时间
	 */
	private Date expireDate;

}
