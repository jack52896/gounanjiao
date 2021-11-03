package com.cloudalibaba.gounanjiaoapi.web;

import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.cloudalibaba.gounanjiaoapi.comparator.*;
import com.cloudalibaba.gounanjiaoapi.dao.OrderitemDao;
import com.cloudalibaba.gounanjiaoapi.dao.ProductDao;
import com.cloudalibaba.gounanjiaoapi.entity.*;
import com.cloudalibaba.gounanjiaoapi.service.*;
import com.cloudalibaba.gounanjiaoapi.util.CookieUtil;
import com.cloudalibaba.gounanjiaoapi.util.HostHolder;
import com.cloudalibaba.gounanjiaoapi.util.OrderStatus;
import com.common.utils.R;
import org.apache.commons.lang.math.RandomUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;

@RestController
public class ForeController {
    @Autowired
    private HostHolder hostHolder;
    @Autowired
    private CategoryService categoryService;
    @Autowired
    private ProductService productService;
    @Autowired
    private ProductDao productDao;
    @Autowired
    private UserService userService;
    @Autowired
    private OrderService orderService;
    @Autowired
    private OrderitemService orderitemService;
    @Autowired
    private OrderitemDao orderitemDao;
    @Autowired
    private ThirdService thirdService;
    @Autowired
    private SchoolService schoolService;
    @Autowired
    private RedisTemplate<String, Object> redisTemplate;
    @GetMapping("/forehome")
    public Object fore(){
        List<CategoryEntity> categories = categoryService.list();
        productService.fill(categories);
        productService.fillByRow(categories);
        return categories;
    }
    @PostMapping("/foreregister")
    public R register(@RequestBody UserEntity userEntity){
        SchoolEntity schoolEntity = schoolService.getOne(
                new QueryWrapper<SchoolEntity>().eq("name", userEntity.getSchoolName())
        );
        List<UserEntity> user = userService.list(new QueryWrapper<UserEntity>().eq("name", userEntity.getName()));
        if(!user.isEmpty()){
           return R.error().put("message", "亲, 该账号名称已经存在了哦");
        }
        userEntity.setStatus(0);
        userEntity.setActivate(1);
        userEntity.setSchoolId(schoolEntity.getId());
        userService.save(userEntity);
        return R.ok();
    }
    @PostMapping("/foreregisterthird")
    public R registerbythird(@RequestBody UserEntity userEntity){
        SchoolEntity schoolEntity = schoolService.getOne(
                new QueryWrapper<SchoolEntity>().eq("name", userEntity.getSchoolName())
        );
        List<UserEntity> user = userService.list(new QueryWrapper<UserEntity>().eq("name", userEntity.getName()));
        if(!user.isEmpty()){
            return R.error().put("message", "亲, 该账号名称已经存在了哦");
        }
        userEntity.setSchoolId(schoolEntity.getId());
        userEntity.setStatus(1);
        userEntity.setActivate(0);
        userService.save(userEntity);
        return R.ok();
    }
    @PostMapping("/foreregisterbussiness")
    public R registerbussiness(@RequestBody UserEntity userEntity){
        SchoolEntity schoolEntity = schoolService.getOne(
                new QueryWrapper<SchoolEntity>().eq("name", userEntity.getSchoolName())
        );
        List<UserEntity> user = userService.list(new QueryWrapper<UserEntity>().eq("name", userEntity.getName()));
        if(!user.isEmpty()){
            return R.error().put("message", "亲, 该账号名称已经存在了哦");
        }
        userEntity.setSchoolId(schoolEntity.getId());
        userEntity.setStatus(2);
        userEntity.setActivate(0);
        userService.save(userEntity);
        return R.ok();
    }
    @PostMapping("/forelogin")
    public R login(@RequestBody UserEntity userEntity, HttpServletResponse response) throws IOException {
        R r = userService.existUser(userEntity);
        if("0".equals(r.get("code").toString())){
            Token token = (Token) r.get("Token");
            Cookie cookie = new Cookie("token", token.getToken());
            redisTemplate.opsForValue().set(token.getToken(), JSONObject.toJSONString(token.getUserEntity()));
            cookie.setMaxAge(100*100);
            cookie.setPath("/");
            response.addCookie(cookie);
        }
        UserEntity user = userService.getOne(
                new QueryWrapper<UserEntity>().eq("name", userEntity.getName())
        );
        return r;
    }
    @GetMapping("/forelogout")
    public void logout(HttpServletRequest request,HttpServletResponse response) throws IOException {
        hostHolder.clear();
        userService.logout(request, "token", response);
        response.sendRedirect("/login");
    }
    @GetMapping("/forecheckLogin")
    public R check(HttpServletRequest request){
        String cookie = CookieUtil.getValue(request, "token");
        if (cookie != null) {
            if(hostHolder.getUser() != null){
                return R.ok();
            }else{
                return R.error().put("message", "用户未登录");
            }
        }else{
            return R.error().put("message", "用户未登录");
        }
    }
    @Transactional(rollbackFor = Exception.class)
    @GetMapping("/forebuyone")
    public Object foreBuyOne(@RequestParam("pid") int pid, @RequestParam("num") int num){
        OrderitemEntity orderitemEntity = orderitemService.getOne(
                new QueryWrapper<OrderitemEntity>().eq("pid", pid).eq("uid", hostHolder.getUser().getId())
        );
        if(orderitemEntity == null){
            OrderitemEntity orderitem = new OrderitemEntity();
            orderitem.setPid(pid);
            orderitem.setNumber(num);
            orderitem.setUid(hostHolder.getUser().getId());
            orderitemDao.insert(orderitem);
            return orderitem.getId();
        }
        orderitemEntity.setNumber(orderitemEntity.getNumber()+num);
        boolean i = orderitemService.updateById(orderitemEntity);
        return orderitemEntity.getId();
    }

    @GetMapping ("/forebuy")
    public R buy(@RequestParam("oiid") String[] oiids, HttpSession session){
        float total = 0;
        List<OrderitemEntity> orderItems = new ArrayList<>();
        for (String oiid : oiids) {
            OrderitemEntity orderitemEntity = orderitemDao.selectOne(
                    new QueryWrapper<OrderitemEntity>().eq("id", oiid)
            );
            ProductEntity productEntity = productDao.selectOne(
                    new QueryWrapper<ProductEntity>().eq("id", orderitemEntity.getPid())
            );
            orderitemEntity.setProduct(productEntity);
            productService.setFirstProdutImage(orderitemEntity);
            total += orderitemEntity.getNumber()*productEntity.getPromoteprice();
            orderItems.add(orderitemEntity);
        }
        session.setAttribute("ois", orderItems);
        return R.ok().put("orderItems", orderItems).put("total", total);
    }
    @PostMapping("/forecreateOrder")
    public R createOrder(@RequestBody OrderEntity orderEntity, HttpSession session){
        if(hostHolder.getUser() == null){
            return R.error().put("message", "用户未登录");
        }
        //生成订单号
        String orderCode = new SimpleDateFormat("yyyyMMddHHmmssSSS").format(new Date()) + RandomUtils.nextInt(10000);
        orderEntity.setOrdercode(orderCode);
        orderEntity.setCreatedate(new Date());
        orderEntity.setUid(hostHolder.getUser().getId());
        //未付款前往收银台
        orderEntity.setStatus(OrderStatus.waitPay);

        List<OrderitemEntity> orderitemEntities = (List<OrderitemEntity>)session.getAttribute("ois");

        float total = orderService.add(orderEntity, orderitemEntities);

        for (OrderitemEntity orderitemEntity : orderitemEntities) {
            orderitemEntity.setOid(orderEntity.getId());
            orderitemService.updateById(orderitemEntity);
        }

        return R.ok().put("total", total).put("oid", orderEntity.getId());

    }
    @GetMapping("forepayed")
    public Object pay(@RequestParam("oid") int oid){
        OrderEntity orderEntity = orderService.getOne(
                new QueryWrapper<OrderEntity>().eq("id", oid)
        );
        orderEntity.setStatus(OrderStatus.waitDelivery);
        orderEntity.setPaydate(new Date());
        orderService.updateById(orderEntity);
        return orderEntity;
    }
    @GetMapping("forebought")
    public R bought(HttpServletResponse response) throws IOException {
        if(hostHolder.getUser() == null){
            return R.error();
        }
        System.out.println(hostHolder.getUser());
        List<OrderEntity> orderEntities = orderService.list(
                new QueryWrapper<OrderEntity>().eq("uid", hostHolder.getUser().getId())
        );
        for (OrderEntity orderEntity : orderEntities) {
            float totalNumber = 0;
            float total = 0;
            List<OrderitemEntity> orderitemEntities = orderitemService.list(
                    new QueryWrapper<OrderitemEntity>().eq("oid", orderEntity.getId())
            );
            for (OrderitemEntity orderitemEntity : orderitemEntities) {
                ProductEntity productEntity = productService.getOne(
                        new QueryWrapper<ProductEntity>().eq("id", orderitemEntity.getPid())
                );
                total += productEntity.getPromoteprice()*orderitemEntity.getNumber();
                productService.setFirstProdutImage(productEntity);
                orderitemEntity.setProduct(productEntity);
                totalNumber += orderitemEntity.getNumber();
            }
            orderEntity.setTotal(total);
            orderEntity.setTotalNumber(totalNumber);
            orderEntity.setOrderItems(orderitemEntities);

        }
        return R.ok().put("orders", orderEntities);
    }
    @GetMapping("forecart")
    public Object cart(){
        UserEntity userEntity = hostHolder.getUser();
        List<OrderitemEntity> orderitemEntities = orderitemService.list(
                new QueryWrapper<OrderitemEntity>().eq("uid", userEntity.getId())
        );
        for (OrderitemEntity orderitemEntity : orderitemEntities) {
            ProductEntity productEntity = productService.getOne(
                    new QueryWrapper<ProductEntity>().eq("id", orderitemEntity.getPid())
            );
            productService.setFirstProdutImage(productEntity);
            orderitemEntity.setProduct(productEntity);
        }
        return  orderitemEntities;
    }
    @GetMapping("foreaddCart")
    public Object sd(@RequestParam("pid") int pid, @RequestParam("num") int num){
        Object o = foreBuyOne(pid, num);
        return R.ok();
    }
    @GetMapping("forecategory/{cid}")
    public Object forecategory(@PathVariable("cid") Integer cid, String sort){
        CategoryEntity categoryEntity = categoryService.getById(cid);
        List<ProductEntity> productEntities  = productService.list(
                new QueryWrapper<ProductEntity>().eq("cid", cid)
        );
        categoryEntity.setProducts(productEntities);
        productService.fill(categoryEntity);
        if(null!=sort){
            switch(sort){
                case "review":
                    Collections.sort(categoryEntity.getProducts(),new ProductReviewComparator());
                    break;
                case "date" :
                    Collections.sort(categoryEntity.getProducts(),new ProductDateComparator());
                    break;

                case "saleCount" :
                    Collections.sort(categoryEntity.getProducts(),new ProductSaleCountComparator());
                    break;

                case "price":
                    Collections.sort(categoryEntity.getProducts(),new ProductPriceComparator());
                    break;

                case "all":
                    Collections.sort(categoryEntity.getProducts(),new ProductAllComparator());
                    break;
            }
        }
        return categoryEntity;
    }
    @GetMapping("foresearch")
    public Object search(){
        return R.ok();
    }
    @GetMapping("getOrder")
    public R get(@RequestParam("oid") int oid){
        UserEntity userEntity = hostHolder.getUser();
        ThirdEntity thirdEntity = new ThirdEntity();
        OrderEntity orderEntity = orderService.getOne(
                new QueryWrapper<OrderEntity>().eq("id", oid)
        );
        thirdEntity.setOid(orderEntity.getId());
        thirdEntity.setUid(userEntity.getId());
        //配送状态更新为等待用户确认订单
        thirdEntity.setStatus(OrderStatus.waitConfirm);
        orderEntity.setStatus(OrderStatus.waitConfirm);
        orderEntity.setThirduid(hostHolder.getUser().getId());
        orderEntity.setDeliverydate(new Date());
        orderService.updateById(orderEntity);
        thirdService.save(thirdEntity);
        return R.ok();
    }
    @GetMapping("forecheck")
    public R check(HttpServletResponse response) throws IOException {
        List<OrderEntity> orderEntities = orderService.list();
        for (OrderEntity orderEntity : orderEntities) {
            float totalNumber = 0;
            float total = 0;
            List<OrderitemEntity> orderitemEntities = orderitemService.list(
                    new QueryWrapper<OrderitemEntity>().eq("oid", orderEntity.getId())
            );
            for (OrderitemEntity orderitemEntity : orderitemEntities) {
                ProductEntity productEntity = productService.getOne(
                        new QueryWrapper<ProductEntity>().eq("id", orderitemEntity.getPid())
                );
                total += productEntity.getPromoteprice()*orderitemEntity.getNumber();
                productService.setFirstProdutImage(productEntity);
                orderitemEntity.setProduct(productEntity);
                totalNumber += orderitemEntity.getNumber();
            }
            orderEntity.setTotal(total);
            orderEntity.setTotalNumber(totalNumber);
            orderEntity.setOrderItems(orderitemEntities);

        }
        return R.ok().put("orders", orderEntities);
    }
    @GetMapping("foreconfirmPay")
    public Object confirm(@RequestParam("oid") int oid){
        OrderEntity orderEntity = orderService.getOne(
                new QueryWrapper<OrderEntity>().eq("id", oid)
        );
        float totalNumber = 0;
        float total = 0;
        List<OrderitemEntity> orderitemEntities = orderitemService.list(
                new QueryWrapper<OrderitemEntity>().eq("oid", orderEntity.getId())
        );
        for (OrderitemEntity orderitemEntity : orderitemEntities) {
            ProductEntity productEntity = productService.getOne(
                    new QueryWrapper<ProductEntity>().eq("id", orderitemEntity.getPid())
            );
            total += productEntity.getPromoteprice()*orderitemEntity.getNumber();
            productService.setFirstProdutImage(productEntity);
            orderitemEntity.setProduct(productEntity);
            totalNumber += orderitemEntity.getNumber();
        }
        orderEntity.setTotal(total);
        orderEntity.setTotalNumber(totalNumber);
        orderEntity.setOrderItems(orderitemEntities);
        return orderEntity;
    }
    @GetMapping("foreorderConfirmed")
    @Transactional(rollbackFor = Exception.class)
    public R co(@RequestParam("oid") int oid){
        OrderEntity orderEntity = orderService.getOne(
                new QueryWrapper<OrderEntity>().eq("id", oid)
        );
        orderEntity.setStatus(OrderStatus.waitReview);
        orderEntity.setConfirmdate(new Date());
        orderService.updateById(orderEntity);
        return R.ok();
    }
//    @GetMapping("forereview")
//    public Object review(@RequestParam("oid") int oid){
//        OrderEntity orderEntity = orderService.getOne(
//                new QueryWrapper<OrderEntity>().eq("id", oid)
//        );
//        orderitemService.fill(orderEntity);
//
//
//    }
}