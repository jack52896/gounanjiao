package com.cloudalibaba.gounanjiaoapi.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;

import java.io.Serializable;
import java.util.Date;
import lombok.Data;
import org.springframework.web.multipart.MultipartFile;

/**
 * 
 * 
 * @author zyj
 * @email 2901570623@qq.com
 * @date 2021-10-22 20:22:05
 */
@Data
@TableName("productimage")
public class ProductimageEntity implements Serializable {
	private static final long serialVersionUID = 1L;

	/**
	 * 产品图片id
	 */
	@TableId
	private Integer id;
	/**
	 * 产品id
	 */
	private Integer pid;
	/**
	 * 图片类型
	 */
	private String type;

	@TableField(exist = false)
	private MultipartFile file;
}
