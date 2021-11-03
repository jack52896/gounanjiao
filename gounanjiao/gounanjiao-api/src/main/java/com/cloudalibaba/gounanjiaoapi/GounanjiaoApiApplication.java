package com.cloudalibaba.gounanjiaoapi;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.MultipartConfigFactory;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.context.annotation.Bean;
import org.springframework.util.unit.DataSize;
import springfox.documentation.swagger2.annotations.EnableSwagger2;

import javax.servlet.MultipartConfigElement;

@SpringBootApplication
@EnableDiscoveryClient
@EnableSwagger2
public class GounanjiaoApiApplication {

    public static void main(String[] args) {
        SpringApplication.run(GounanjiaoApiApplication.class, args);
    }


    @Bean
    public MultipartConfigElement multipartConfigElement() {
        MultipartConfigFactory factory = new MultipartConfigFactory();
        // 设置单个附件大小上限值(默认为1M)
        //选择字符串作为参数的话，单位可以用MB、KB;
        factory.setMaxFileSize(DataSize.ofBytes(1048576L));
        // 设置所有附件的总大小上限值
        factory.setMaxRequestSize(DataSize.ofBytes(1073741824L));
        return factory.createMultipartConfig();
    }
}
