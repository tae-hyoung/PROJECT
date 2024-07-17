package com.homecat.sweethome.service.impl.member;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.homecat.sweethome.mapper.member.LogInMapper;
import com.homecat.sweethome.service.member.LogInService;
import com.homecat.sweethome.vo.member.MemberVO;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class LogInServiceImpl implements LogInService {

	@Inject
	LogInMapper logInMapper;

	@Override
	public MemberVO logInMember(String memId) {
		log.info("{} 입주민 로그인", memId);
		return logInMapper.logInMember(memId);
	}

}
