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
@TableName("category")
public class CategoryEntity implements Serializable {
	private static final long serialVersionUID = 1L;

	/**
	 * 分类id
	 */
	@TableId
	private Integer id;
	/**
	 * 分类名称
	 */
	private String name;

	@TableField(exist = false)
	private List<ProductEntity> products;

	@TableField(exist = false)
	private List<List<ProductEntity>> productsByRow;

}
