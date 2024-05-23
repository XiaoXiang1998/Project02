package com.member.security;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserService;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.oauth2.core.user.DefaultOAuth2User;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.member.model.MemberBean;
import com.member.model.MemberService;
import com.sean.model.CarItemService;
import com.sean.model.Notifications;
import com.sean.model.NotificationsService;

import jakarta.servlet.http.HttpSession;

@Service
public class MemberOAuth2UserService implements OAuth2UserService<OAuth2UserRequest, OAuth2User> {
	

    @Autowired
    private HttpSession session;

    @Autowired
    private MemberService mService;

    @Autowired
    private NotificationsService nService;

    @Autowired
    private CarItemService cService;

    private final DefaultOAuth2UserService delegate = new DefaultOAuth2UserService();

    @Override
    public OAuth2User loadUser(OAuth2UserRequest userRequest) throws OAuth2AuthenticationException {
        OAuth2User oAuth2User = delegate.loadUser(userRequest);

        // 从 OAuth2User 中获取用户信息
        Map<String, Object> attributes = oAuth2User.getAttributes();
        String email = (String) attributes.get("email");
        String name = (String) attributes.get("name");
        String thirdPartyId = (String) attributes.get("sub"); // 假设 Google 使用 "sub" 属性
        String thirdPartyProvider = "Google";

        // 从 email 中获取用户名（假设用户名是 email 的前缀部分）
        String[] splitAccount = email.split("@");
        String account = splitAccount[0];

        Optional<MemberBean> memberOpt = mService.findByAccount(account);
        MemberBean member;

        if (memberOpt.isPresent()) {
            member = memberOpt.get();
            if (!mService.checkLogin(account, thirdPartyId)) {
                throw new OAuth2AuthenticationException("Invalid login credentials");
            }
        } else {
            LocalDate now = LocalDate.now();
            member = new MemberBean(account, thirdPartyId, email, name, thirdPartyProvider, now);
            mService.insert(member);
            session.setAttribute("member", member);
        }

        // 设置会话信息
        session.setAttribute("member", member);
        List<Notifications> notifications = nService.findByRecipientIdOrderBySendTimeDesc(member);
        Integer count = nService.noReadCounts(member);
        session.setAttribute("count", count);
        session.setAttribute("notifications", notifications);
        Integer carItemCount = cService.carItemCount(member);
        session.setAttribute("carItemCount", carItemCount);

        // 返回包含用户信息和权限的 OAuth2User 对象
        return new DefaultOAuth2User(
            List.of(new SimpleGrantedAuthority("ROLE_USER")),
            attributes,
            "name" // 假设 name 是主要的用户名属性
        );
    }
}
