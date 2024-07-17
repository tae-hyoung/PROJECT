package com.homecat.sweethome.service.impl.bidnotice;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.homecat.sweethome.mapper.bidnotice.BidNoticeMapper;
import com.homecat.sweethome.service.bidnotice.BidNoticeService;
import com.homecat.sweethome.unit.AttachDao;
import com.homecat.sweethome.unit.UploadController;
import com.homecat.sweethome.vo.attach.AttachVO;
import com.homecat.sweethome.vo.bidnotice.BidNoticeVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class BidNoticeServiceImpl implements BidNoticeService {
	
	
	@Autowired
	BidNoticeMapper bidnoticeMapper;
	
	@Autowired
	UploadController uploadController;
	
	@Autowired
	AttachDao attachDao;

	@Override
	public List<BidNoticeVO> getList() {
		return this.bidnoticeMapper.getList();
	}

	@Override
	public List<BidNoticeVO> getList(int num) {
		return this.bidnoticeMapper.getListTop(num);
	}
	
	@Override
	public BidNoticeVO getDetail(String bidSeq) {
		return this.bidnoticeMapper.getDetail(bidSeq);
	}

	@Override
	public int updatePost(BidNoticeVO bidnoticeVO) {
		return this.bidnoticeMapper.updatePost(bidnoticeVO);
	}

	@Override
	public int createPost(BidNoticeVO bidnoticeVO) {
		
        Date date = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHH24mmss");
		
		// 파일 업로드
		this.uploadController.uploadMulti(bidnoticeVO.getMyFiles(), bidnoticeVO.getBidSeq() +sdf.format(date));
		
		// 파일 명 불러오기
		AttachVO attach = this.attachDao.getFileName(bidnoticeVO.getBidSeq() +sdf.format(date));
		log.info("attach" + attach);
		// 파일 명 셋팅
		bidnoticeVO.setBidAttach(attach.getFileName());
		log.info("bidnoticeVO" + bidnoticeVO);
		
		return this.bidnoticeMapper.createPost(bidnoticeVO);
	}

	@Override
	public int deletePost(BidNoticeVO bidnoticeVO) {
		return this.bidnoticeMapper.deletePost(bidnoticeVO);
	}

}
