package com.homecat.sweethome.mapper.moveout;

import java.util.List;
import java.util.Map;

import com.homecat.sweethome.vo.moveout.MoveoutVO;

public interface MoveoutMapper {
	
	public MoveoutVO getInfo(String memId);

	public int insert(MoveoutVO moveoutVO);
	
	public int update(MoveoutVO moveoutVO);

	public List<MoveoutVO> getList(String danjiCode);
	
	public int delete(Map<String, Object> data);

	public int moveoutOK(Map<String, Object> data);

	public String getPayYN(Map<String, Object> data);

	public int paySuccess(Map<String, Object> data);

	public String getMemId(String mvoSeq);


}
