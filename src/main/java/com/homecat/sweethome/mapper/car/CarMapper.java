package com.homecat.sweethome.mapper.car;

import java.util.List;
import java.util.Map;

import com.homecat.sweethome.vo.car.CarVO;
import com.homecat.sweethome.vo.waste.WasteVO;

public interface CarMapper {

	public List<CarVO> getCarList(String memId);

	public int createPost(CarVO carVO);

	public int deletePost(CarVO carVO);
	
	
	//////////////////////////////////////관리자////////////////////////////////////////////////
	
	//차량 조회
	public List<WasteVO> adCarList(Map<String, Object> map);
	
	//업데이트
	public int updatePost(CarVO carVO);

	public List<CarVO> homeCnt();

	public String getMemId(String carNo);

	public List<CarVO> statistics();


//	public CarVO getCarDetail(String carNo);

}
