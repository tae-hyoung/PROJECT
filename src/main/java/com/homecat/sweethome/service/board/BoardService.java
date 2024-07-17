package com.homecat.sweethome.service.board;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.homecat.sweethome.vo.board.BoardVO;
import com.homecat.sweethome.vo.board.JJIMVO;
import com.homecat.sweethome.vo.board.ReplyVO;
import com.homecat.sweethome.vo.board.ReportVO;

public interface BoardService {

	public List<BoardVO> getAllList(Map<String, Object> map);

	public List<BoardVO> getList(Map<String, Object> map);

	public List<BoardVO> getList(int num);
	
	public List<BoardVO> getList2(int num);

	public BoardVO getDetail(String brdNo);

	public int countLike(HashMap<String, String> data);

	public List<ReplyVO> insertReply(ReplyVO replyVO);

	public int getTotal(Map<String, Object> map);

	public int getAllTotal(Map<String, Object> map);

	public int insertBoard(BoardVO boardVO);

	public int update(BoardVO boardVO);

	public int delete(String brdSeq);

	public List<ReplyVO> repDel(HashMap<String, String> data);

	public int toggleBlind(Map<String, Object> data);

	public int report(Map<String, Object> data);
	
	public List<ReplyVO> replyList(Map<String, Object> map);

	public List<ReplyVO> replyAllList(Map<String, Object> map);

	public int adminDelete(Map<String, Object> map);

	public List<ReportVO> getReportList(Map<String, Object> data);

	public List<Map<String, Integer>> getDateChart();

	public List<Map<String, Integer>> getCateChart();

	public int getTotalByCat(Map<String, Object> map);

	public List<BoardVO> getListByCat(Map<String, Object> map);

	public int JJIM(Map<String, Object> data);

	public List<JJIMVO> getJJIMList(Map<String, Object> data);

	public Map<String, String> getNext(Map<String, Object> data);

	public Map<String, String> getPrev(Map<String, Object> data);

	public List<BoardVO> getTradeList();

	public List<JJIMVO> getJJIMListById(String memId);

}
