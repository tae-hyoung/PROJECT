package com.homecat.sweethome.service.impl.car;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.homecat.sweethome.mapper.alarm.AlarmMapper;
import com.homecat.sweethome.mapper.car.CarMapper;
import com.homecat.sweethome.vo.car.CarVO;
import com.homecat.sweethome.vo.waste.WasteVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class CarServiceImpl implements com.homecat.sweethome.service.car.CarService {

	@Autowired
	CarMapper carMapper;
	
	@Autowired
	AlarmMapper alarmMapper;
	
	//차량리스트
	@Override
	public List<CarVO> getCarList(String memId) {
		return this.carMapper.getCarList(memId);
	}
	
	//차량등록
	@Override
	public int createPost(CarVO carVO) {
		return this.carMapper.createPost(carVO);
	}

	@Override
	public int deletePost(CarVO carVO) {
		return this.carMapper.deletePost(carVO);
	}

	//////////////////////////////////////////관리자///////////////////////////////////////////////////
	
	//차량신청 리스트
	@Override
	public List<WasteVO> adCarList(Map<String, Object> map) {
		return this.carMapper.adCarList(map);
	}
	
	//차량상태 업데이트
	@Override
	public int updatePost(CarVO carVO) {

		//// 알림 인서트 시작 ////
		String memId = this.carMapper.getMemId(carVO.getCarNo());
		
		Map<String, String> alarmData = new HashMap<String, String>();
		alarmData.put("memId", memId);
		alarmData.put("globalCode", carVO.getCarNo());
		alarmData.put("category", "차량");
		
		int cnt = this.alarmMapper.insert(alarmData);
		log.info("alarmInsert->cnt: " + cnt);
		//// 알림 인서트 끝 ////
		
		return this.carMapper.updatePost(carVO);
	}

	@Override
	public List<CarVO> homeCnt() {
		return carMapper.homeCnt();
	}

	@Override
	public List<CarVO> statistics() {
		return carMapper.statistics();
	}


//	@Override
//	public CarVO getCarDetail(String carNo) {
//		return this.carMapper.getCarDetail(carNo);
//	}

}
