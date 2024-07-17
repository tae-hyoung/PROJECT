package com.homecat.sweethome.service.impl.publicFacilities;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.homecat.sweethome.mapper.publicFacilities.FacilityMapper;
import com.homecat.sweethome.service.publicFacilities.FacilityService;
import com.homecat.sweethome.vo.publicFacilities.FacilityVO;
import com.homecat.sweethome.vo.publicFacilities.ReserveVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class FacilityServiceImpl implements FacilityService {

	@Autowired
	FacilityMapper facilityMapper;

	@Override
	public List<FacilityVO> tennisMain(String facCode) {
		return this.facilityMapper.tennisMain(facCode);
	}

	@Override
	public List<ReserveVO> reserveList(ReserveVO reserveVO) {
		return this.facilityMapper.reserveList(reserveVO);
	}

	@Override
	public int reservation(ReserveVO reserveVO) {
		return this.facilityMapper.reservation(reserveVO);
	}

	@Override
	public int cancleRe(ReserveVO reserveVO) {
		return this.facilityMapper.cancleRe(reserveVO);
	}

	@Override
	public List<ReserveVO> blockRe(ReserveVO reserveVO) {
		return this.facilityMapper.blockRe(reserveVO);
	}

	@Override
	public List<ReserveVO> liveRe(ReserveVO reserveVO) {
		return this.facilityMapper.liveRe(reserveVO);
	}

	@Override
	public List<ReserveVO> adReserveList(String facCode) {
		return this.facilityMapper.adReserveList(facCode);
	}

	@Override
	public List<ReserveVO> allReList() {
		return this.facilityMapper.allReList();
	}

	@Override
	public List<ReserveVO> selectCa(String facCode) {
		return this.facilityMapper.selectCa(facCode);
	}

	@Override
	public ReserveVO reDetail(ReserveVO reserveVO) {
		return facilityMapper.reDetail(reserveVO);
	}

	@Override
	public List<ReserveVO> totalRe() {
		return facilityMapper.totalRe();
	}

	@Override
	public List<ReserveVO> dayCntList() {
		return facilityMapper.dayCntList();
	}
	
}
