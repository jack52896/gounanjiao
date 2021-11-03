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
 * @date 2021-10-27 10:41:12
 */
@Data
@TableName("third")
public class ThirdEntity implements Serializable {
	private static final long serialVersionUID = 1L;

	/**
	 * 配送id
	 */
	@TableId
	private Integer id;
	/**
	 * 配送订单id
	 */
	private Integer oid;
	/**
	 * 配送状态
	 */
	private String status;
	/**
	 * 配送人员id
	 */
	private Integer uid;

}
