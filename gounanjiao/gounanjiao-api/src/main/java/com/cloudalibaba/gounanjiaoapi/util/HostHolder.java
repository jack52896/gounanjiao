package com.cloudalibaba.gounanjiaoapi.util;

import com.cloudalibaba.gounanjiaoapi.entity.UserEntity;
import org.springframework.stereotype.Component;

@Component
public class HostHolder {
    private ThreadLocal<UserEntity> users = new ThreadLocal<UserEntity>();
    public void setUsers(UserEntity userEntity){
        users.set(userEntity);
    }
    public UserEntity getUser(){
        return users.get();
    }
    public void clear(){
        users.remove();
    }
}
