package com.homecat.sweethome.service.impl.member;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.homecat.sweethome.mapper.member.ResidentMapper;
import com.homecat.sweethome.service.member.ResidentService;
import com.homecat.sweethome.vo.member.MemberVO;

@Service
public class ResidentServiceImpl implements ResidentService {

	@Inject
	ResidentMapper residentMapper;
	
	@Override
	public List<MemberVO> residentProfile(String memId) {
		
		return this.residentMapper.residentProfile(memId);
	}

	@Override
	public int updateResidentProfile(MemberVO memberVO) {
		
		return this.residentMapper.updateResidentProfile(memberVO);
	}

	@Override
	public int changeNick(MemberVO memberVO) {
		
		return this.residentMapper.changeNick(memberVO);
	}
	
	

}
