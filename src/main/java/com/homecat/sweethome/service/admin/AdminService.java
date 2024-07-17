package com.homecat.sweethome.service.admin;

import java.util.List;

import com.homecat.sweethome.vo.member.MemberVO;

public interface AdminService {
	
	/**
	 * 관리자 정보 조회
	 * @param member
	 * @return
	 */
	public List<MemberVO> adminProfile(String memId);
	
	
	/**
	 * 관리자 본인 정보 수정
	 * @param memberVO
	 * @return
	 */
	public int updateAdminProfile(MemberVO memberVO);
}
