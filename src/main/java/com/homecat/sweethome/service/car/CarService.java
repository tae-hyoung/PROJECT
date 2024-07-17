package com.homecat.sweethome.service.car;

import java.util.List;
import java.util.Map;

import com.homecat.sweethome.vo.car.CarVO;
import com.homecat.sweethome.vo.waste.WasteVO;

public interface CarService {

	public List<CarVO> getCarList(String memId);

	public int createPost(CarVO carVO);

	public int deletePost(CarVO carVO);
	
	////////////////////////////////관리자 ///////////////////////////////////
	
	//차량신청 리스트
	public List<WasteVO> adCarList(Map<String, Object> map);
	
	
	//등록상태 업데이트
	public int updatePost(CarVO carVO);

	public List<CarVO> homeCnt();

	public List<CarVO> statistics();


//	public CarVO getCarDetail(String carNo);

}
