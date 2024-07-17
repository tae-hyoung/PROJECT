package com.homecat.sweethome.mapper.visitCar;

import java.util.List;
import java.util.Map;

import com.homecat.sweethome.vo.visitCar.VisitCarVO;

public interface VisitCarMapper {

	public List<VisitCarVO> getVisitCarList(String memId);

	public int creatPost(VisitCarVO visitCarVO);

	public int deletePost(VisitCarVO visitCarVO);

	public List<VisitCarVO> adVisitCarList(Map<String, Object> map);

}
