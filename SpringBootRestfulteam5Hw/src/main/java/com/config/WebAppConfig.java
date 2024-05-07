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
			registry.addResourceHandler("/comment/**").addResourceLocations("/WEB-INF/comment/");
			registry.addResourceHandler("/commentjs/**").addResourceLocations("/WEB-INF/commentjs/");
			registry.addResourceHandler("/Order/js/**").addResourceLocations("/WEB-INF/Order/js/");
			registry.addResourceHandler("/Order/css/**").addResourceLocations("/WEB-INF/Order/css/");
			registry.addResourceHandler("/Order/assets/demo/**").addResourceLocations("/WEB-INF/Order/assets/demo/");


	}	
}
