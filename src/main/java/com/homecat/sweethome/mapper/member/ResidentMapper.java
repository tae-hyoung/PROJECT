package com.homecat.sweethome.mapper.member;

import java.util.List;

import com.homecat.sweethome.vo.member.MemberVO;

public interface ResidentMapper {

	public List<MemberVO> residentProfile(String memId);
	
	/**
	 * 입주민 회원정보 수정
	 * @param memberVO
	 * @return
	 */
	public int updateResidentProfile(MemberVO memberVO);
	
	/**
	 * 닉네임 변경
	 * @param memberVO
	 * @return
	 */
	public int changeNick(MemberVO memberVO);
}
