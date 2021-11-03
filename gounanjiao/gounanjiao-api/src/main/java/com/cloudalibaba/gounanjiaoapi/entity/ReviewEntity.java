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
@TableName("review")
public class ReviewEntity implements Serializable {
	private static final long serialVersionUID = 1L;

	/**
	 * 评论id
	 */
	@TableId
	private Integer id;
	/**
	 * 评论内容
	 */
	private String content;
	/**
	 * 用户id
	 */
	private Integer uid;
	/**
	 * 产品id
	 */
	private Integer pid;
	/**
	 * 创建时间
	 */
	private Date createdate;

}
