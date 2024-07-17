package com.homecat.sweethome.mapper.complain;

import java.util.List;
import java.util.Map;

import com.homecat.sweethome.vo.complain.ComplainVO;

public interface ComplainMapper {

	public int create(ComplainVO complainVO);

	public List<ComplainVO> getList(Map<String, Object> map);

	public int getTotal(Map<String, Object> map);
	
	public List<ComplainVO> getAllList(Map<String, Object> map);
	
	public int getAllTotal(Map<String, Object> map);

	public int replyAjax(Map<String, Object> data);
	
	public int delete(Map<String, Object> data);

	public List<ComplainVO> homeCnt();

	public String getMemId(String string);

}
