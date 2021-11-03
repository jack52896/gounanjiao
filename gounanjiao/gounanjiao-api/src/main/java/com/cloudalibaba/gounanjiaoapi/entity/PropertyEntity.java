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
@TableName("property")
public class PropertyEntity implements Serializable {
	private static final long serialVersionUID = 1L;

	/**
	 * 属性id
	 */
	@TableId
	private Integer id;
	/**
	 * 对应产品id
	 */
	private Integer cid;
	/**
	 * 属性名称
	 */
	private String name;

}
