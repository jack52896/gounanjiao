package com.cloudalibaba.gounanjiaoapi.web.interceptor;

import com.cloudalibaba.gounanjiaoapi.annotation.LoginRequire;
import com.cloudalibaba.gounanjiaoapi.util.HostHolder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.lang.reflect.Method;

@Component
public class LoginRequireInterceptor implements HandlerInterceptor {
    @Autowired
    private HostHolder hostHolder;
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        if(handler instanceof HandlerMethod){
            HandlerMethod handlerMethod = (HandlerMethod) handler;
            Method method = handlerMethod.getMethod();
            LoginRequire loginRequire = method.getAnnotation(LoginRequire.class);
            if(loginRequire != null && hostHolder.getUser() == null){
                response.sendRedirect("/login");
                return false;
            }
            if(loginRequire != null && hostHolder.getUser().getStatus().equals(0)){
                response.sendRedirect("/404");
                return false;
            }
        }
        return true;
    }
}
