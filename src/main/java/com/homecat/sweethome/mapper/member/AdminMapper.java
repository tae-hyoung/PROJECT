package com.homecat.sweethome.mapper.member;

import java.util.List;
import java.util.Map;

import com.homecat.sweethome.vo.danji.DanjiVO;
import com.homecat.sweethome.vo.member.MemberVO;

public interface AdminMapper {
	
	/**
	 * 관리자 리스트
	 * @param map
	 * @return
	 */
	public List<MemberVO> adminList(Map<String, Object> map);
	
	/**
	 * 관리자 수
	 * @param keyword
	 * @return
	 */
	public int adminCount(String keyword);
	

	/**
	 * 대기자 리스트
	 * @param map
	 * @return
	 */
	public List<MemberVO> waitAdminList(Map<String ,Object> map);
	
	/**
	 * 단지 연결!
	 * @param roomCode
	 * @return
	 */
	public List<DanjiVO> adminDanji(Map<String, Object> map);
	
	/**
	 * 대기자 수
	 * @param keyword
	 * @return
	 */
	public int waitAdminCount(String keyword);
	
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
	 * 관리자 본인 정보 수정
	 * @param memberVO
	 * @return
	 */
	public int updateAdminProfile(MemberVO memberVO);
	
	/**
	 * 관리자 본인정보 조회
	 * @param member
	 * @return
	 */
	public List<MemberVO> adminProfile(String memId);
}

