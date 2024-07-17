package com.homecat.sweethome.service.master;

import java.util.List;
import java.util.Map;

import com.homecat.sweethome.vo.member.MemberVO;

public interface AdminListService {

	/**
	 * 관리자 리스트
	 * 
	 * @param map
	 * @return
	 */
	public List<MemberVO> adminList(Map<String, Object> map);

	/**
	 * 관리자 수
	 * 
	 * @param keyword
	 * @return
	 */
	public int adminCount(String keyword);

	/**
	 * 대기자 리스트
	 * 
	 * @param map
	 * @return
	 */
	public List<MemberVO> waitAdminList(Map<String, Object> map);

	/**
	 * 대기자 수
	 * 
	 * @param keyword
	 * @return
	 */
	public int waitAdminCount(String keyword);

	/**
	 * 가입 승인
	 * 
	 * @param memId
	 * @return
	 */
	public int signOk(String memId);

	/**
	 * 가입 반려
	 * 
	 * @param memId
	 * @return
	 */
	public int signNo(String memId);

}
