package com.homecat.sweethome.security;

import java.util.Collection;
import java.util.stream.Collectors;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import com.homecat.sweethome.vo.danji.DanjiVO;
import com.homecat.sweethome.vo.member.MemberVO;

public class CustomUser extends User{
	
	private MemberVO memberVO;
	private DanjiVO danjiVO;
	
	public CustomUser(String username, String password, Collection<? extends GrantedAuthority> authorities) {
		super(username, password, authorities);
	}

	//return member==null?null:new CumstomUser2(member);
	public CustomUser(MemberVO memberVO) {
		super(memberVO.getMemId(),memberVO.getMemPw(),
				memberVO.getMemberAuthVOList().stream().map(auth->new SimpleGrantedAuthority(auth.getMemAuth())).collect(Collectors.toList())
				);
		this.memberVO = memberVO;
	}

	public MemberVO getMemberVO() {
		return memberVO;
	}

	public void setMemberVO(MemberVO memberVO) {
		this.memberVO = memberVO;
	}
	
	public DanjiVO getDanjiVO() {
		return danjiVO;
	}
	
	public void setDanjiVO(DanjiVO danjiVO) {
		this.danjiVO = danjiVO;
	}
	
	
}
