package com.cloudalibaba.gounanjiaoapi.entity;

import lombok.Data;

import java.io.Serializable;

@Data
public class Token implements Serializable {
    private static final long serialVersionUID = 1L;
    private String token;
    private UserEntity userEntity;
}
