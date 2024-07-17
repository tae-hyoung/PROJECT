package com.homecat.sweethome.mapper.board;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.homecat.sweethome.vo.board.BoardVO;
import com.homecat.sweethome.vo.board.JJIMVO;
import com.homecat.sweethome.vo.board.ReplyVO;
import com.homecat.sweethome.vo.board.ReportVO;

public interface BoardMapper {

	public List<BoardVO> getAllList(Map<String, Object> map);

	public List<BoardVO> getList(Map<String, Object> map);

	public List<BoardVO> getListTop(int num);
	
	public List<BoardVO> getListTop2(int num);

	public void countView(String brdNo);
	
	public BoardVO getDetail(String brdNo);

	public List<ReplyVO> getReplyList(String brdNo);
	
	public List<ReplyVO> getReplyAllList(String brdNo);

	public int boardLike(HashMap<String, String> data);

	public int replyLike(HashMap<String, String> data);

	public int getBrdLike(HashMap<String, String> data);

	public int getRepLike(HashMap<String, String> data);

	public int insertReply(ReplyVO replyVO);

	public int getTotal(Map<String, Object> map);
	
	public int getAllTotal(Map<String, Object> map);

	public int insertBoard(BoardVO boardVO);

	public int update(BoardVO boardVO);

	public int delete(String brdSeq);

	public int repDel(HashMap<String, String> data);

	public int toggleBlind(Map<String, Object> data);

	public int report(Map<String, Object> data);

	public int countReport(Map<String, Object> data);

	public int adminDelete(Map<String, Object> map);

	public List<ReportVO> getReportList(Map<String, Object> data);

	public List<Map<String, Integer>> getDateChart();

	public List<Map<String, Integer>> getCateChart();

	public int getTotalByCat(Map<String, Object> map);

	public List<BoardVO> getListByCat(Map<String, Object> map);

	public int JJIM(Map<String, Object> data);

	public int CancelJJIM(Map<String, Object> data);

	public List<JJIMVO> getJJIMList(Map<String, Object> data);
	
	public Map<String, String> getNext(Map<String, Object> data);

	public Map<String, String> getPrev(Map<String, Object> data);

	public String getBrdSeq();

	public List<BoardVO> getTradeList();

	public List<JJIMVO> getJJIMListById(String memId);



}
