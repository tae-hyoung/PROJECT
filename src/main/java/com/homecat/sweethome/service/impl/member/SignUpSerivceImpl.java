package com.homecat.sweethome.service.impl.member;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.homecat.sweethome.mapper.member.SignUpMapper;
import com.homecat.sweethome.service.member.SignUpService;
import com.homecat.sweethome.vo.danji.DanjiVO;
import com.homecat.sweethome.vo.member.MemberVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class SignUpSerivceImpl implements SignUpService {
	@Inject
	SignUpMapper signUpMapper;

	@Override
	public int chkid(String memId) {
		log.info("아이디 중복체크 서비스 작동");
		return this.signUpMapper.chkId(memId);
	}

	@Override
	public int chkNick(String nickname) {
		log.info("닉네임 중복체크 서비스 작동");
		return this.signUpMapper.chkNick(nickname);
	}

	@Override
	public int signUpMember(MemberVO memberVO) {
		log.info("삽입 데이터  : ",memberVO.toString());
		int result = this.signUpMapper.signUpMember(memberVO);
		log.info("1뜨면 성공임 => "+result);
		return result;
	}

	@Override
	public int signUpAdmin(MemberVO memberVO) {
		log.info("삽입 데이터  : ",memberVO.toString());
		int result = this.signUpMapper.signUpAdmin(memberVO);
		log.info("1뜨면 성공임 => "+result);
		return result;
	}

	@Override
	public int signUpPartner(MemberVO memberVO) {
		log.info("삽입 데이터  : ",memberVO.toString());
		int result = this.signUpMapper.signUpPartner(memberVO);
		log.info("1뜨면 성공임 => "+result);
		return result;
	}

	@Override
	public List<DanjiVO> selDanji() {
		
		return this.signUpMapper.selDanji();
	}
	
	
}
