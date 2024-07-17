package com.homecat.sweethome.service.impl.ccpy;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.homecat.sweethome.mapper.ccpy.CcpyMapper;
import com.homecat.sweethome.service.ccpy.CcpyService;
import com.homecat.sweethome.vo.ccpy.CcpyVO;

@Service
public class CcpyServiceImpl implements CcpyService {

	@Autowired
	CcpyMapper ccpyMapper;
	
	@Override
	public List<CcpyVO> getCcpy() {
		return this.ccpyMapper.getCcpy();
	}

	//하자보수업체정보 가져오기
	@Override
	public List<CcpyVO> getCcpyCode() {
		return this.ccpyMapper.getCcpyCode();
	}

	//협력업체 리스트
	@Override
	public List<CcpyVO> list(Map<String, Object> map) {
		return this.ccpyMapper.list(map);
	}

}
