package com.homecat.sweethome.service.impl.master;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.homecat.sweethome.mapper.member.AdminMapper;
import com.homecat.sweethome.service.master.AdminListService;
import com.homecat.sweethome.vo.member.MemberVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class AdminListServiceImpl implements AdminListService {

	@Inject
	AdminMapper adminMapper;

	@Override
	public List<MemberVO> waitAdminList(Map<String, Object> map) {

		return this.adminMapper.waitAdminList(map);
	}

	@Override
	public int waitAdminCount(String keyword) {

		int cnt = this.adminMapper.waitAdminCount(keyword);

		return cnt;
	}

	@Override
	public int signOk(String memId) {
		log.info("가입을 승인함");
		log.debug("아이디값 : ", memId);

		int rst = this.adminMapper.signOk(memId);

		return rst;
	}

	@Override
	public int signNo(String memId) {
		log.info("가입을 반려함.");
		log.debug("아이디값 : ", memId);

		int rst = this.adminMapper.signNo(memId);

		return rst;
	}

	@Override
	public List<MemberVO> adminList(Map<String, Object> map) {

		return this.adminMapper.adminList(map);
	}

	@Override
	public int adminCount(String keyword) {

		int cnt = this.adminMapper.adminCount(keyword);

		return cnt;
	}

}
