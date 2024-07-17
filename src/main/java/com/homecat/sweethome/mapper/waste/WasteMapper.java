package com.homecat.sweethome.mapper.waste;

import java.util.List;
import java.util.Map;

import com.homecat.sweethome.vo.waste.WasteVO;



public interface WasteMapper {

	//폐기물 배출 신청 목록
	public List<WasteVO> wasteList(Map<String, Object> map);

	//폐기물 배출 신청 상세
	public WasteVO detail(String wasteSeq);

	//폐기물 배출 신청
	public int createPost(WasteVO wasteVO);

	//수정
	public int updatePost(WasteVO wasteVO);

	//삭제
	public int deletePost(WasteVO wasteVO);


	//관리자 페이지////////////////////////////////////////////////////////////////
	//입주민 폐기물 신청 내역	
	public List<WasteVO> adWasteList(Map<String, Object> map);

	//모달 상세
	public WasteVO modalDetail(WasteVO wasteVO);

	//모달 수정
	public int modalUpdate(WasteVO wasteVO);

	// 폐기물 순번 가져오기
	public String getWasteSeq();

	public List<WasteVO> homeCnt();

	public String getMemId(String wasteSeq);

	//폐기물스티커
	public WasteVO sticker(String wasteSeq);

	//처리상태 데이터 카운트
	public List<WasteVO> statusCount();


//	// 폐기물 품목 가져오기
//	public List<CommDetailVO> commDetailList();
//
//	//선택한 폐기물품목의 코드가져오기
//	public String getCommDetCode(String commDetCodeNm);


}
