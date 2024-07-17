package com.homecat.sweethome.service.impl.comm;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.homecat.sweethome.mapper.comm.CommDetailMapper;
import com.homecat.sweethome.service.comm.CommDetailService;
import com.homecat.sweethome.vo.comm.CommDetailVO;

@Service
public class CommDetailServiceImpl implements CommDetailService {

	@Autowired
	CommDetailMapper commDetailMapper;
	
	@Override
	public List<CommDetailVO> getCommDetail() {
		return commDetailMapper.getCommDetail();
	}

	@Override
	public List<CommDetailVO> getCommDelivery() {
		return this.commDetailMapper.getCommDelivery();
	}

}
