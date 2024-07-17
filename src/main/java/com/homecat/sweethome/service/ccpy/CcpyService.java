package com.homecat.sweethome.service.ccpy;

import java.util.List;
import java.util.Map;

import com.homecat.sweethome.vo.ccpy.CcpyVO;

public interface CcpyService {

	public List<CcpyVO> getCcpy();

	//하자보수업체정보 가져오기
	public List<CcpyVO> getCcpyCode();

	//협력업체 리스트
	public List<CcpyVO> list(Map<String, Object> map);

}
