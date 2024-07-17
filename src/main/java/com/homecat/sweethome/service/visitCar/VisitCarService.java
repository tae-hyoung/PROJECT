package com.homecat.sweethome.service.visitCar;

import java.util.List;
import java.util.Map;

import com.homecat.sweethome.vo.visitCar.VisitCarVO;

public interface VisitCarService {

	public List<VisitCarVO> getVisitCarList(String memId);

	public int createPost(VisitCarVO visitCarVO);

	public int deletePost(VisitCarVO visitCarVO);

	public List<VisitCarVO> adVisitCarList(Map<String, Object> map);

}
