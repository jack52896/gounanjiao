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
@TableName("propertyvalue")
public class PropertyvalueEntity implements Serializable {
	private static final long serialVersionUID = 1L;

	/**
	 * 属性值id
	 */
	@TableId
	private Integer id;
	/**
	 * 产品id
	 */
	private Integer pid;
	/**
	 * 属性id
	 */
	private Integer ptid;
	/**
	 * 属性内容
	 */
	private String value;

}
