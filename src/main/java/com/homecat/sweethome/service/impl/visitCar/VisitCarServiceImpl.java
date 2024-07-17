package com.homecat.sweethome.service.impl.visitCar;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.homecat.sweethome.mapper.visitCar.VisitCarMapper;
import com.homecat.sweethome.vo.visitCar.VisitCarVO;

@Service
public class VisitCarServiceImpl implements com.homecat.sweethome.service.visitCar.VisitCarService{
	
	@Autowired
	VisitCarMapper visitcarMapper;
	
	//방문차량 리스트
	@Override
	public List<VisitCarVO> getVisitCarList(String memId) {
		
		return this.visitcarMapper.getVisitCarList(memId);
	}
	
	//방문차량 예약 신청
	@Override
	public int createPost(VisitCarVO visitCarVO) {
		return this.visitcarMapper.creatPost(visitCarVO);
	}
	
	//방문차량 신청 삭제
	@Override
	public int deletePost(VisitCarVO visitCarVO) {
		return this.visitcarMapper.deletePost(visitCarVO);
	}
	
	////////////////////////////////////////////////////관리자 페이지///////////////////////////////////////////////////////////////
	
	//방문차량 리스트(관리자)
	@Override
	public List<VisitCarVO> adVisitCarList(Map<String, Object> map) {
		return this.visitcarMapper.adVisitCarList(map);
	}

}
