package com;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.password.NoOpPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

import com.member.security.MemberLogoutHandler;
import com.member.security.MemberOAuth2UserService;

@Configuration
@EnableWebSecurity
public class SecurityConfig {
	
	@Autowired
	private MemberOAuth2UserService memberOAuth2UserService;

	@Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity httpSecurity) throws Exception {
        httpSecurity
            .authorizeHttpRequests(requests -> requests
        		.requestMatchers("/membercenter").authenticated() 
                .anyRequest().permitAll()  // 其他所有请求都不需要身份验证
            )
            //一般登入
            .formLogin(form -> form
                    .loginPage("/ezbuy.com")  // 自定義登入畫面
                    .loginProcessingUrl("/login")  // 對應登入頁面form表單的action
                    .permitAll()  // 允许所有用户访问登录页面
            )
            //設置地三方登入
            .oauth2Login(oauth2Login ->oauth2Login
            			.loginPage("/ezbuy.com")
            			//對應GOOGLE重導向位置
            			.authorizationEndpoint(authorizationEndpoint -> authorizationEndpoint
                            .baseUri("/oauth2/authorization")  // 自定義授權端點
                        )
                        .redirectionEndpoint(redirectionEndpoint -> redirectionEndpoint
                            .baseUri("/login/oauth2/code/google")  // 對應google重導向對應端點
                        )
                        .userInfoEndpoint(userInfoEndpoint -> userInfoEndpoint
                        	.userService(memberOAuth2UserService)
                        )
            )
            //配置登出用事項
            .logout(logout -> logout
                    .permitAll()
                    //做登出的邏輯，目前是刪除所以得session
                    .addLogoutHandler(new MemberLogoutHandler()) // 將自定義的 LogoutHandler 添加到登出配置中
                    //做完自定義邏輯後導向
                    .logoutSuccessUrl("/EZBuyIndex")
            )
            .csrf(csrf -> csrf.disable());  // 禁用 CSRF 保护
        
        return httpSecurity.build();
    }
	
	//為了處理security好像一定要有一種加密方式，用者個但實質上無加密
	@Bean
	public PasswordEncoder passwordEncoder() {
		return NoOpPasswordEncoder.getInstance();
	}
	
	
//	//處理URL中說出現"//"
//	@Bean
//	public WebSecurityCustomizer webSecurityCustomizer() {
//	    StrictHttpFirewall firewall = new StrictHttpFirewall();
//	    firewall.setAllowBackSlash(true);
//	    return (web) -> web.httpFirewall(firewall);
//	}
}
