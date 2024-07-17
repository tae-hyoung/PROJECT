package com.homecat.sweethome.mapper.member;

import java.util.List;

import com.homecat.sweethome.vo.ccpy.CcpyVO;
import com.homecat.sweethome.vo.comm.CommDetailVO;
import com.homecat.sweethome.vo.danji.DanjiVO;
import com.homecat.sweethome.vo.member.MemberVO;

public interface SignUpMapper {
	
	/**
	 * 입주민 회원 insert
	 * @param memberVO
	 * @return
	 */
	public int signUpMember(MemberVO memberVO);
	
	/**
	 * 주택관리자 회원 insert
	 * @param memberVO
	 * @return
	 */
	public int signUpAdmin(MemberVO memberVO);
	
	/**
	 * 협력업체 회원 insert
	 * @param memberVO
	 * @return
	 */
	public int signUpPartner(MemberVO memberVO);
	
	/**
	 * 협력업체 회원 상세정보 insert
	 * @param memberVO
	 * @return
	 */
	public int signUpPartnerDetail(CcpyVO ccpyVO);
	
	/**
	 * 협력업체 코드 관련
	 * @param commDetailVO
	 * @return
	 */
	public int addComm(CommDetailVO commDetailVO);
	
	/**
	 * 아이디 중복 확인
	 * @param memId
	 * @return
	 */
	public int chkId(String memId);

	/**
	 * 닉네임 중복 확인
	 * @param nickname
	 * @return
	 */
	public int chkNick(String nickname);
	
	/**
	 * 전화번호 중복 확인
	 * @param telno
	 * @return
	 */
	public int chkTelno(String telno);
	
	
	/**
	 * 단지리스트
	 * @param map
	 * @return
	 */
	public List<DanjiVO> selDanji();
	
}
