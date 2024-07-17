package com.homecat.sweethome.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.homecat.sweethome.mapper.member.LogInMapper;
import com.homecat.sweethome.vo.member.MemberVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class CustomUserDetailsService implements UserDetailsService {

	@Autowired
	private LogInMapper logInMapper;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		log.info("CustomUserDetailsService2->username : " + username);
		
		//select
		MemberVO memberVO = this.logInMapper.logInMember(username);
		log.info("CustomUserDetailsService->memberVO : " + memberVO);
		
		//User(스프링꺼)
		//CustomUser2(우리꺼)
		return memberVO==null?null:new CustomUser(memberVO);
	}

}
