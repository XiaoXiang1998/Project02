package com.member.security;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.member.model.MemberBean;
import com.member.model.MemberService;
import com.sean.model.CarItemService;
import com.sean.model.Notifications;
import com.sean.model.NotificationsService;

import jakarta.servlet.http.HttpSession;

/*設定人員驗證*/
@Service
public class MemberDetailsService implements UserDetailsService {

	@Autowired
	private HttpSession session;

	@Autowired
	private MemberService mService;

	@Autowired
	private NotificationsService nService;

	@Autowired
	private CarItemService cService;

	//身分驗證時同時處理所需要的session
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		Optional<MemberBean> memberBean = mService.findByAccount(username);
		MemberBean member = memberBean.get();
		if (member == null) {
			throw new UsernameNotFoundException("Can't find member: " + username);
		}
		session.setAttribute("member", member);
		List<Notifications> notifications = nService.findByRecipientIdOrderBySendTimeDesc(member);
		Integer count = nService.noReadCounts(member);
		session.setAttribute("count", count);
		session.setAttribute("notifications", notifications);
		// 購物車數量
		Integer carItemCount = cService.carItemCount(member);
		session.setAttribute("carItemCount", carItemCount);
		return new MemberDetailsRule(member);// 回傳客制化建立會員
	}
}
