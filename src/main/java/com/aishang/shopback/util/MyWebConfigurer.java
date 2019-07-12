package com.aishang.shopback.util;

import com.alibaba.fastjson.support.config.FastJsonConfig;
import com.alibaba.fastjson.support.spring.FastJsonHttpMessageConverter;
import org.springframework.boot.SpringBootConfiguration;
import org.springframework.http.MediaType;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

@SpringBootConfiguration
public class MyWebConfigurer implements WebMvcConfigurer {
    @Resource
    private MyIntercepors myIntercepors;

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(myIntercepors).addPathPatterns("/**").excludePathPatterns("/user/login", "/user/dologin", "/js/*", "/css/*", "/images/**");

    }
     /**
     * 利用fastjson替换掉jackson，且解决中文乱码问题
     * @param converters
     */

}
