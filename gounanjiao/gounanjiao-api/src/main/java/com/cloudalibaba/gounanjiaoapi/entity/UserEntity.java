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
@TableName("user")
public class UserEntity implements Serializable {
	private static final long serialVersionUID = 1L;

	/**
	 * 用户id
	 */
	@TableId
	private Integer id;
	/**
	 * 用户昵称
	 */
	private String name;
	/**
	 * 用户密码
	 */
	private String password;
	/**
	 * 用户散列值
	 */
	private String salt;

	private Integer status;

	private Integer activate;

	private Integer schoolId;

	@TableField(exist = false)
	private String schoolName;
}
