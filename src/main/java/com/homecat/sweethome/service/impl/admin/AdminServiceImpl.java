package com.homecat.sweethome.service.impl.admin;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.homecat.sweethome.mapper.member.AdminMapper;
import com.homecat.sweethome.service.admin.AdminService;
import com.homecat.sweethome.vo.member.MemberVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class AdminServiceImpl implements AdminService {

	@Inject
	AdminMapper adminMapper;
	
	@Override
	public List<MemberVO> adminProfile(String memId) {
		
		return this.adminMapper.adminProfile(memId);
	}

	@Override
	public int updateAdminProfile(MemberVO memberVO) {
		return this.adminMapper.updateAdminProfile(memberVO);
	}
	
	

}
