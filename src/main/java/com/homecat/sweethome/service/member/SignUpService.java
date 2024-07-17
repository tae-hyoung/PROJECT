package com.homecat.sweethome.service.member;

import java.util.List;

import com.homecat.sweethome.vo.danji.DanjiVO;
import com.homecat.sweethome.vo.member.MemberVO;

public interface SignUpService {
	
	public int signUpMember(MemberVO memberVO);
	
	public int signUpAdmin(MemberVO memberVO);
	
	public int signUpPartner(MemberVO memberVO);
	
	public int chkid(String memId);
	
	public int chkNick(String nickname);
	
	public List<DanjiVO> selDanji();
}
