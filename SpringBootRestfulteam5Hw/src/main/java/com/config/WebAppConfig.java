package com.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
@Configuration
public class WebAppConfig implements WebMvcConfigurer {

	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		  registry.addResourceHandler("/goodImages/**").addResourceLocations("/WEB-INF/goodImages/");
			registry.addResourceHandler("/commentPicture/**").addResourceLocations("/WEB-INF/commentPicture/");
			registry.addResourceHandler("/commentcss/**").addResourceLocations("/WEB-INF/commentcss/");
	 
	}	
}
