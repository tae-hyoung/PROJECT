package com.homecat.sweethome.mapper.comm;

import java.util.List;

import com.homecat.sweethome.vo.comm.CommDetailVO;

public interface CommDetailMapper {

	public List<CommDetailVO> getCommDetail();

	public String getCommDetCode();

	public CommDetailVO getCommDetCode(String commDetCode); 
	
	public List<CommDetailVO> getCommDelivery();

}
