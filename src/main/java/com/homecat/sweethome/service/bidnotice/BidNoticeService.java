package com.homecat.sweethome.service.bidnotice;

import java.util.List;

import com.homecat.sweethome.vo.bidnotice.BidNoticeVO;

public interface BidNoticeService {

	public List<BidNoticeVO> getList();

	public List<BidNoticeVO> getList(int num);

	public BidNoticeVO getDetail(String bidSeq);

	public int updatePost(BidNoticeVO bidnoticeVO);

	public int createPost(BidNoticeVO bidnoticeVO);

	public int deletePost(BidNoticeVO bidnoticeVO);
}
