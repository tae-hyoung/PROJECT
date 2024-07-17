package com.homecat.sweethome.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.homecat.sweethome.interceptor.CurrentUriInterceptor;

@Configuration
public class WebConfig implements WebMvcConfigurer {

	@Autowired
	private CurrentUriInterceptor currentUriInterceptor;
	
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		registry.addInterceptor(currentUriInterceptor).addPathPatterns("/**");
	}
}
