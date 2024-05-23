package com.member.security;

import java.util.Collection;
import java.util.Collections;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import com.member.model.MemberBean;

/*客製化配合userDetails*/
public class MemberDetailsRule implements UserDetails {

	private static final long serialVersionUID = 1L;

	private final String username;
	private final String password;
	private final Collection<? extends GrantedAuthority> authorities;

	public MemberDetailsRule(MemberBean member) {
		this.username = member.getAccount(); //因為security本身預設欄位是username，所以用此客製化對應資料庫欄位
		this.password = member.getPassword();
		this.authorities = Collections.singleton(() -> "USER"); //添加默認權限
	}

	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		return authorities;
	}

	@Override
	public String getPassword() {
		return password;
	}

	@Override
	public String getUsername() {
		return username;
	}

	@Override
	public boolean isAccountNonExpired() {
		return true;
	}

	@Override
	public boolean isAccountNonLocked() {
		return true;
	}

	@Override
	public boolean isCredentialsNonExpired() {
		return true;
	}

	@Override
	public boolean isEnabled() {
		return true;
	}
}
