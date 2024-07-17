package com.homecat.sweethome.mapper.bidnotice;

import java.util.List;

import com.homecat.sweethome.vo.bidnotice.BidNoticeVO;

public interface BidNoticeMapper {

	public List<BidNoticeVO> getList();

	public List<BidNoticeVO> getListTop(int num);

	public BidNoticeVO getDetail(String bidSeq);

	public int updatePost(BidNoticeVO bidnoticeVO);

	public int createPost(BidNoticeVO bidnoticeVO);

	public int deletePost(BidNoticeVO bidnoticeVO);

}
