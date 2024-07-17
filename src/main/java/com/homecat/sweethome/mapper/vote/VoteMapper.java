package com.homecat.sweethome.mapper.vote;

import java.util.List;
import java.util.Map;


import com.homecat.sweethome.vo.vote.VoteDetailVO;
import com.homecat.sweethome.vo.vote.VoteResultVO;
import com.homecat.sweethome.vo.vote.VoteVO;

public interface VoteMapper {
	
	//전체 목록
	public int getTotal(Map<String, Object> map);
	
	//목록 가져오기
	public List<VoteVO> getList(Map<String, Object> map);
	
	//투표 질문 생성(관리자)
	public int createPost(VoteVO voteVO);
	
	//투표 마감
	public int closeVote(String voteCode);
	
	//투표 번호 가져오기
	public String getVoteCode(VoteVO voteVO);
	
	//투표 정보가져오기
	public VoteVO getVoteByCode(String voteCode);
	
	//투표 상세정보 가져오기
	public List<VoteDetailVO> getDetailsByCode(String voteCode);
	
	//투표 상세 등록
	public int insertDetail(VoteDetailVO voteDetailVO);
	
	//VOTE_DETAIL 테이블의 데이터 삭제(수정을 위해기존 데이터 삭제)
	public int voteDetailDelete(VoteVO voteVO);
	
	//투표 수정
	public int updatePost(VoteVO voteVO);
	
	//투표삭제
	public int voteDelete(VoteVO voteVO);
	
	//투표결과
	public int insertResult(VoteResultVO voteResultVO);
	
	//투표 결과 조회
	public List<VoteResultVO> searchResult(String voteCode);
	
	//투표자 목록 가져오기
	public List<String> getReplyerList(String voteCode);
	
	//참가자 수 구하기
	public int participantCnt(String voteCode);
	
	//제출 목록 중복 방지
	public List<String> getSubmitVoteUser(String memId);
	
	//VD_CODE 생성
	public String makeVdCode(Map<String, Object> params);

	public List<VoteVO> homeCnt();

	//찌꺼기 제거(마지막 복합키 데이터를 파라미터로 던짐)
	public int voteDetailArrange(VoteDetailVO lastVoteDetailVO);
	
}
