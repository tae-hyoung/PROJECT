package com.homecat.sweethome.service.impl.delivery;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.homecat.sweethome.mapper.alarm.AlarmMapper;
import com.homecat.sweethome.mapper.delivery.DeliveryMapper;
import com.homecat.sweethome.service.delivery.DeliveryService;
import com.homecat.sweethome.unit.AttachDao;
import com.homecat.sweethome.unit.UploadController;
import com.homecat.sweethome.vo.attach.AttachVO;
import com.homecat.sweethome.vo.delivery.DeliveryVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class DeliveryServiceImpl implements DeliveryService {

	@Autowired
	DeliveryMapper deliveryMapper;
	
	@Autowired
	UploadController uploadController;
	
	@Autowired
	AlarmMapper alarmMapper;
	
	@Autowired
	AttachDao attachDao;
	
	@Override
	public List<DeliveryVO> list(Map<String, Object> map) {
		return this.deliveryMapper.list(map);
	}

	@Override
	public DeliveryVO detail(DeliveryVO deliveryVO) {
		return this.deliveryMapper.detail(deliveryVO);
	}

	@Override
	public int delUpdate(DeliveryVO deliveryVO) {
		return this.deliveryMapper.delUpdate(deliveryVO);
	}

	@Override
	public int create(DeliveryVO deliveryVO) {
		int result  = this.deliveryMapper.create(deliveryVO);
		
		MultipartFile uploadFile = deliveryVO.getUploadFile();
		
		result +=uploadController.uploadOne(uploadFile, deliveryVO.getPckSeq());
		
		AttachVO attachVO = this.attachDao.getFileName(deliveryVO.getPckSeq());
		log.info("attachVO : {}", attachVO);
		
		result += this.deliveryMapper.updateFileName(attachVO);
		
		return result;
	}

	@Override
	public int update(DeliveryVO deliveryVO) {
		return this.deliveryMapper.update(deliveryVO);
	}
	
	////////////////관리자 /////////////////
	@Override
	public List<DeliveryVO> partList(Map<String, Object> map) {
		return this.deliveryMapper.partList(map);
	}

	@Override
	public DeliveryVO deliveryDetail(DeliveryVO deliveryVO) {
		return this.deliveryMapper.deliveryDetail(deliveryVO);
	}

	@Override
	public int back(DeliveryVO deliveryVO) {
		//// 알림 인서트 시작 ////
		String memId = this.deliveryMapper.getMemId(deliveryVO.getPckSeq());
		
		Map<String, String> alarmData = new HashMap<String, String>();
		alarmData.put("memId", memId);
		alarmData.put("globalCode", deliveryVO.getPckSeq());
		alarmData.put("category", "택배 반려");
		
		int cnt = this.alarmMapper.insert(alarmData);
		log.info("alarmInsert->cnt: " + cnt);
		//// 알림 인서트 끝 ////
		
		return this.deliveryMapper.back(deliveryVO);
	}

	@Override
	public int pickUp(DeliveryVO deliveryVO) {
		//// 알림 인서트 시작 ////
		String memId = this.deliveryMapper.getMemId(deliveryVO.getPckSeq());
		
		Map<String, String> alarmData = new HashMap<String, String>();
		alarmData.put("memId", memId);
		alarmData.put("globalCode", deliveryVO.getPckSeq());
		alarmData.put("category", "택배 수거");
		
		int cnt = this.alarmMapper.insert(alarmData);
		log.info("alarmInsert->cnt: " + cnt);
		//// 알림 인서트 끝 ////
		
		return this.deliveryMapper.pickUp(deliveryVO);
	}

	@Override
	public List<DeliveryVO> ccpyFilter(String ccpyCode) {
		return this.deliveryMapper.ccpyFilter(ccpyCode);
	}

	@Override
	public List<DeliveryVO> monthList() {
		return this.deliveryMapper.monthList();
	}

	@Override
	public List<DeliveryVO> dayList() {
		return this.deliveryMapper.dayList();
	}

	@Override
	public List<DeliveryVO> homeCnt() {
		return deliveryMapper.homeCnt();
	}



}
