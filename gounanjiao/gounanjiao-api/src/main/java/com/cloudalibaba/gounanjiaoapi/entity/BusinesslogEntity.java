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
 * @date 2021-10-28 11:30:28
 */
@Data
@TableName("businesslog")
public class BusinesslogEntity implements Serializable {
	private static final long serialVersionUID = 1L;

	/**
	 * 日志id
	 */
	@TableId
	private Integer id;
	/**
	 * 登陆时间
	 */
	private Date logintime;
	/**
	 * 操作
	 */
	private String method;
	/**
	 * 登出时间
	 */
	private Date logout;
	/**
	 * 日志创建时间
	 */
	private Date logtime;
	/**
	 * 商家id
	 */
	private Integer uid;

}
