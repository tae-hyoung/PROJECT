package com.homecat.sweethome.service.impl.board;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.homecat.sweethome.mapper.board.BoardMapper;
import com.homecat.sweethome.service.board.BoardService;
import com.homecat.sweethome.unit.AttachDao;
import com.homecat.sweethome.unit.UploadController;
import com.homecat.sweethome.vo.attach.AttachVO;
import com.homecat.sweethome.vo.board.BoardVO;
import com.homecat.sweethome.vo.board.JJIMVO;
import com.homecat.sweethome.vo.board.ReplyVO;
import com.homecat.sweethome.vo.board.ReportVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class BoardServiceImpl implements BoardService {

	@Autowired
	BoardMapper boardMapper;
	
	@Autowired
	UploadController uploadController;
	
	@Autowired
	AttachDao attachDao;
	
	@Override
	public List<BoardVO> getAllList(Map<String, Object> map) {
		return this.boardMapper.getAllList(map);
	}
	
	@Override
	public List<BoardVO> getList(Map<String, Object> map) {
		return this.boardMapper.getList(map);
	}

	@Override
	public List<BoardVO> getList(int num) {
		return this.boardMapper.getListTop(num);
	}
	
	@Override
	public List<BoardVO> getList2(int num) {
		return this.boardMapper.getListTop2(num);
	}

	@Override
	public BoardVO getDetail(String brdNo) {
		this.boardMapper.countView(brdNo);
		BoardVO boardVO = this.boardMapper.getDetail(brdNo);
		boardVO.setReplyVOList(this.boardMapper.getReplyList(brdNo));
		return boardVO;
	}

	@Override
	public int countLike(HashMap<String, String> data) {
		int result = 0;
		if(data.get("repNo") == null) {
			this.boardMapper.boardLike(data);
			result = this.boardMapper.getBrdLike(data);
		}else {
			this.boardMapper.replyLike(data);
			result = this.boardMapper.getRepLike(data);
		}
		return result;
	}

	@Override
	public List<ReplyVO> insertReply(ReplyVO replyVO) {
		this.boardMapper.insertReply(replyVO);
		List<ReplyVO> replyList = this.boardMapper.getReplyList(replyVO.getBrdSeq());
		return replyList;
	}

	@Override
	public List<ReplyVO> repDel(HashMap<String, String> data) {
		this.boardMapper.repDel(data);
		List<ReplyVO> replyList = null;
		if(data.get("admin") != null) {
			replyList = this.boardMapper.getReplyAllList(data.get("brdNo"));
		}else {
			replyList = this.boardMapper.getReplyList(data.get("brdNo"));
		}
		return replyList;
	}

	@Override
	public int getTotal(Map<String, Object> map) {
		return this.boardMapper.getTotal(map);
	}
	
	@Override
	public int getAllTotal(Map<String, Object> map) {
		return this.boardMapper.getAllTotal(map);
	}

	@Override
	public int insertBoard(BoardVO boardVO) {
		
		int cnt = 0;
		
		if(boardVO.getAttach() != null) {
			String brdSeq = this.boardMapper.getBrdSeq();
	
			//파일명 설정
			Date date = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("HHmmss");
			String time = sdf.format(date);
			String filename =  brdSeq + time;
			
			//파일 업로드 처리
			cnt += this.uploadController.uploadOne(boardVO.getAttach(), filename);

			//ATTACH 테이블에 데이터 삽입
			AttachVO attach = this.attachDao.getFileName(filename);
			
			boardVO.setThumbnail(attach.getFileName());
		} else {
			log.info("업로드 파일이 음슴");
			
			boardVO.setThumbnail("");
		}
		
		cnt += this.boardMapper.insertBoard(boardVO);
		
		return cnt;
	}

	@Override
	public int update(BoardVO boardVO) {
		return this.boardMapper.update(boardVO);
	}

	@Override
	public int delete(String brdSeq) {
		return this.boardMapper.delete(brdSeq);
	}

	@Override
	public int toggleBlind(Map<String, Object> data) {
		return this.boardMapper.toggleBlind(data);
	}

	@Override
	public int report(Map<String, Object> data) {
		this.boardMapper.countReport(data);
		return this.boardMapper.report(data);
	}

	@Override
	public List<ReplyVO> replyList(Map<String, Object> map) {
		return this.boardMapper.getReplyList(map.get("brdNo").toString());
	}
	
	@Override
	public List<ReplyVO> replyAllList(Map<String, Object> map) {
		return this.boardMapper.getReplyAllList(map.get("brdNo").toString());
	}

	@Override
	public int adminDelete(Map<String, Object> map) {
		return this.boardMapper.adminDelete(map);
	}

	@Override
	public List<ReportVO> getReportList(Map<String, Object> data) {
		return this.boardMapper.getReportList(data);
	}

	@Override
	public List<Map<String, Integer>> getDateChart() {
		return this.boardMapper.getDateChart();
	}

	@Override
	public List<Map<String, Integer>> getCateChart() {
		return this.boardMapper.getCateChart();
	}

	@Override
	public int getTotalByCat(Map<String, Object> map) {
		return this.boardMapper.getTotalByCat(map);
	}

	@Override
	public List<BoardVO> getListByCat(Map<String, Object> map) {
		return this.boardMapper.getListByCat(map);
	}

	@Override
	public int JJIM(Map<String, Object> data) {
		if(data.get("JJIM").equals("Y")) {
			return this.boardMapper.JJIM(data);
		}else {
			return this.boardMapper.CancelJJIM(data);
		}
	}

	@Override
	public List<JJIMVO> getJJIMList(Map<String, Object> data) {
		return this.boardMapper.getJJIMList(data);
	}

	@Override
	public Map<String, String> getNext(Map<String, Object> data) {
		return this.boardMapper.getNext(data);
	}

	@Override
	public Map<String, String> getPrev(Map<String, Object> data) {
		return this.boardMapper.getPrev(data);
	}

	@Override
	public List<BoardVO> getTradeList() {
		return this.boardMapper.getTradeList();
	}

	@Override
	public List<JJIMVO> getJJIMListById(String memId) {
		return this.boardMapper.getJJIMListById(memId);
	}

}
