package com.cloudalibaba.gounanjiaoapi.controller;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.cloudalibaba.gounanjiaoapi.entity.ProductEntity;
import com.cloudalibaba.gounanjiaoapi.service.ProductService;
import com.cloudalibaba.gounanjiaoapi.util.HostHolder;
import com.cloudalibaba.gounanjiaoapi.util.ImageUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import com.cloudalibaba.gounanjiaoapi.entity.ProductimageEntity;
import com.cloudalibaba.gounanjiaoapi.service.ProductimageService;
import com.common.utils.PageUtils;
import com.common.utils.R;
import org.springframework.web.multipart.MultipartFile;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;


/**
 * 
 *
 * @author zyj
 * @email 2901570623@qq.com
 * @date 2021-10-22 20:22:05
 */
@RestController
@RequestMapping("gounanjiaoapi/productimage")
public class ProductimageController {
    @Autowired
    private ProductimageService productimageService;
    @Autowired
    private ProductService productService;
    @Autowired
    HostHolder hostHolder;
    @GetMapping("listByuid")
    public R listByuid(){
        List<ProductEntity> productEntities = productService.list(
                new QueryWrapper<ProductEntity>().eq("thirduid", hostHolder.getUser().getId())
        );
        List<ProductimageEntity> productimageEntities = new ArrayList<>();
        for (ProductEntity productEntity : productEntities) {
            List<ProductimageEntity> list = productimageService.list(
                    new QueryWrapper<ProductimageEntity>().eq("pid", productEntity.getId())
            );
            productimageEntities.addAll(list);
        }
        return R.ok().put("data", productimageEntities);
    }
    /**
     * 列表
     */
    @GetMapping("/list")
    public R list(@RequestParam Map<String, Object> params){
        PageUtils page = productimageService.queryPage(params);

        return R.ok().put("page", page);
    }


    /**
     * 信息
     */
    @GetMapping("/info/{id}")
    public R info(@PathVariable("id") Integer id){
		ProductimageEntity productimage = productimageService.getById(id);

        return R.ok().put("productimage", productimage);
    }

    /**
     * 保存
     */
    @PostMapping("/save")
    public R save(@RequestBody ProductimageEntity productimage){
		productimageService.save(productimage);

        return R.ok();
    }

    @PostMapping("/productimagesave")
    @Transactional(rollbackFor = Exception.class)
    public R imagesave(@RequestParam("type") String type, @RequestParam("pid") int pid,
                       @RequestParam("image") MultipartFile image, HttpServletRequest request) throws InterruptedException {
        if(image == null){
            return R.error().put("message", "请选择一张图片");
        }
        String fileName2 = image.getOriginalFilename();
        String suffix = fileName2.substring(fileName2.lastIndexOf("."));
        List<String> list = new ArrayList<>();
        list.add(".jpg");
        list.add(".png");
        list.add(".jfif");
        if(!list.contains(suffix)){
            return R.error().put("message", "请选择正确的文件格式");
        }
        ProductimageEntity productimageEntity = new ProductimageEntity();
        productimageEntity.setType(type);
        productimageEntity.setPid(pid);
        productimageService.save(productimageEntity);
        String folder = "img/";
        if("type_single".equals(productimageEntity.getType())){
            folder += "productSingle";
        }else{
            folder += "productDetail";
        }
        File imageFolder = new File(request.getServletContext().getRealPath(folder));
        Thread.sleep(1000);
        File file1 = new File(imageFolder, productimageEntity.getId()+".jpg");
        String fileName = file1.getName();
        if(!file1.getParentFile().exists()) {
            file1.getParentFile().mkdirs();
        }
        try {
            image.transferTo(file1);
            BufferedImage img = ImageUtil.change2jpg(file1);
            ImageIO.write(img, "jpg", file1);
        } catch (IOException e) {
            e.printStackTrace();
        }
        if("type_single".equals(productimageEntity.getType())){
            String imageFolder_small= request.getServletContext().getRealPath("img/productSingle_small");
            String imageFolder_middle= request.getServletContext().getRealPath("img/productSingle_middle");
            File f_small = new File(imageFolder_small, fileName);
            File f_middle = new File(imageFolder_middle, fileName);
            f_small.getParentFile().mkdirs();
            f_middle.getParentFile().mkdirs();
            ImageUtil.resizeImage(file1, 56, 56, f_small);
            ImageUtil.resizeImage(file1, 217, 190, f_middle);
        }
        return R.ok();
    }

    /**
     * 修改
     */
    @PostMapping("/update")
    public R update(@RequestBody ProductimageEntity productimage){
		productimageService.updateById(productimage);

        return R.ok();
    }

    /**
     * 删除
     */
    @PostMapping("/delete")
    public R delete(@RequestBody Integer[] ids){
		productimageService.removeByIds(Arrays.asList(ids));

        return R.ok();
    }

}
