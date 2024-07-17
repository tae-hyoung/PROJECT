package com.homecat.sweethome.service.member;

import java.util.List;

import com.homecat.sweethome.vo.member.MemberVO;

public interface ResidentService {
	
	public List<MemberVO> residentProfile(String memId);
	
	public int updateResidentProfile(MemberVO memberVO);
	
	public int changeNick(MemberVO memberVO);
}
