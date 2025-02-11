package com.homecat.sweethome.mapper.member;

import java.util.List;
import java.util.Map;

import com.homecat.sweethome.vo.member.MemberVO;

public interface MemberMapper {

	/* 입주민 등록 현황 */
	
	/**
	 * 회원 리스트 
	 * @param map
	 * @return
	 */
	public List<MemberVO>memberList(Map<Object, Object> map);
	
	/**
	 * 가입자 수
	 * @param keyword
	 * @return
	 */
	public int memberCount(Map<Object, Object> map);
	
	/* 입주민 등록 현황 끝 */
	
	
	/* 입주민 대기 현황 */
	
	
	/**
	 * 가입 대기자 목록 검색
	 * @param map
	 * @return
	 */
	public List<MemberVO> waitList(Map<Object, Object> map);
	
	
	/**
	 * 가입 반려자 목록
	 * @param map
	 * @return
	 */
	public List<MemberVO> rejectList(Map<Object, Object> map);
	
	
	/**
	 * 가입 대기자 수 
	 * @param keyword
	 * @return
	 */
	public int waitCount(Map<Object, Object> map);
	
	
	/**
	 * 가입 반려자 수 
	 * @param keyword
	 * @return
	 */
	public int rejectCount(Map<Object, Object> map);
	
	
	/**
	 * 가입 승인
	 * @param memId
	 * @return
	 */
	public int signOk(String memId);
	
	/**
	 * 가입 반려
	 * @param memId
	 * @return
	 */
	public int signNo(String memId);
	
	/**
	 * 삭제
	 * @param memId
	 * @return
	 */
	public int deleteMem(String memId);
	
	
	/* 입주민 대기 현황  끝 */
	
	
	/**
	 * 아이디 찾기
	 * @param map
	 * @return
	 */
	public MemberVO idFind(Map<Object, Object> map);
	
	
	/**
	 * 비밀번호 찾기
	 * @param map
	 * @return
	 */
	public MemberVO pwFind(MemberVO memberVO);
	
	/**
	 * 임시 비밀번호 발급 후
	 * @param memberVO
	 * @return
	 */
	public MemberVO pwChange(MemberVO memberVO);
	
	/**
	 * 비밀번호 변경 후 계정 사용 가능
	 * @param memberVO
	 * @return
	 */
	public int enabledAccount(MemberVO memberVO);
}
