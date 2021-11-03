package com.cloudalibaba.gounanjiaoapi.controller;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.cloudalibaba.gounanjiaoapi.entity.UserEntity;
import com.cloudalibaba.gounanjiaoapi.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import com.cloudalibaba.gounanjiaoapi.entity.SchoolEntity;
import com.cloudalibaba.gounanjiaoapi.service.SchoolService;
import com.common.utils.PageUtils;
import com.common.utils.R;



/**
 * 
 *
 * @author zyj
 * @email 2901570623@qq.com
 * @date 2021-10-27 23:42:50
 */
@RestController
@RequestMapping("gounanjiaoapi/school")
public class SchoolController {
    @Autowired
    private SchoolService schoolService;
    @Autowired
    private UserService userService;

    /**
     * 列表
     */
    @GetMapping("/list")
    public R list(@RequestParam Map<String, Object> params){
        PageUtils page = schoolService.queryPage(params);

        return R.ok().put("page", page);
    }


    /**
     * 信息
     */
    @GetMapping("/info/{id}")
    public R info(@PathVariable("id") Integer id){
		SchoolEntity school = schoolService.getById(id);

        return R.ok().put("school", school);
    }

    /**
     * 保存
     */
    @PostMapping("/save")
    public R save(@RequestBody SchoolEntity school){
		schoolService.save(school);

        return R.ok();
    }

    /**
     * 修改
     */
    @PostMapping("/update")
    @Transactional(rollbackFor = Exception.class)
    public R update(@RequestBody SchoolEntity school){
        schoolService.updateById(school);
        if(school.getDeleted().equals(1)){
            List<UserEntity> userEntities = userService.list(
                    new QueryWrapper<UserEntity>().eq("school_id", school.getId())
            );
            for (UserEntity userEntity : userEntities) {
                userEntity.setActivate(1);
                userService.updateById(userEntity);
            }
        }
        if(school.getDeleted().equals(0)){
            List<UserEntity> userEntities = userService.list(
                    new QueryWrapper<UserEntity>().eq("school_id", school.getId())
            );
            for (UserEntity userEntity : userEntities) {
                userEntity.setActivate(0);
                userService.updateById(userEntity);
            }
        }
        return R.ok();
    }

    /**
     * 删除
     */
    @PostMapping("/delete")
    @Transactional(rollbackFor = Exception.class)
    public R delete(@RequestBody Integer[] ids){
		List<SchoolEntity> schoolEntities= schoolService.listByIds(Arrays.asList(ids));

        for (SchoolEntity schoolEntity : schoolEntities) {
            schoolEntity.setDeleted(0);
            schoolService.updateById(schoolEntity);
            List<UserEntity> userEntities = userService.list(
                    new QueryWrapper<UserEntity>().eq("school_id", schoolEntity.getId())
            );
            for (UserEntity userEntity : userEntities) {
                userEntity.setActivate(0);
                userService.updateById(userEntity);
            }
        }
        return R.ok();
    }

}
