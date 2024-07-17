package com.homecat.sweethome.service.impl.member;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;


import com.homecat.sweethome.mapper.member.MemberMapper;
import com.homecat.sweethome.service.member.MemberService;
import com.homecat.sweethome.vo.member.MemberVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class MemberServiceImpl implements MemberService  {
	
	@Inject
	MemberMapper memberMapper;

	@Override
	public int signOk(String memId) {
		log.info("가입을 승인함");
		log.debug("아이디값 : ",memId);
		
		int rst = this.memberMapper.signOk(memId);
		
		log.info("승인하면 1 뜰거임 -> " + rst);
		return rst;
	}

	@Override
	public int signNo(String memId) {
		log.info("가입을 반려함.");
		log.debug("아이디값 : ",memId);
		
		int rst = this.memberMapper.signNo(memId);
		
		log.info("반려하면 1 뜰거임 -> " + rst);
		return rst;
	}

	@Override
	public int waitCount(Map<Object, Object> map) {
		
		int cnt = this.memberMapper.waitCount(map);
		
		return cnt;
	}

	@Override
	public List<MemberVO> waitList(Map<Object, Object> map) {
		
		return this.memberMapper.waitList(map);
	}

	@Override
	public MemberVO pwChange(MemberVO memberVO) {
		return this.memberMapper.pwChange(memberVO);
	}

	@Override
	public int enabledAccount(MemberVO memberVO) {
		
		return this.memberMapper.enabledAccount(memberVO);
	}

	/* 회원 목록 관련 */
	@Override
	public List<MemberVO> memberList(Map<Object, Object> map) {
		return this.memberMapper.memberList(map);
	}

	@Override
	public int memberCount(Map<Object, Object> map) {
		return this.memberMapper.memberCount(map);
	}

	@Override
	public List<MemberVO> rejectList(Map<Object, Object> map) {
		// TODO Auto-generated method stub
		return this.memberMapper.rejectList(map);
	}

	@Override
	public int rejectCount(Map<Object, Object> map) {
		// TODO Auto-generated method stub
		return this.memberMapper.rejectCount(map);
	}

	@Override
	public int deleteMem(String memId) {
		// TODO Auto-generated method stub
		return this.memberMapper.deleteMem(memId);
	}
	
	@Override
	public MemberVO idFind(Map<Object, Object> map) {
		
		log.info("아이디 찾기 -> {}", map);
		
		return this.memberMapper.idFind(map);
	}
	
	
}
