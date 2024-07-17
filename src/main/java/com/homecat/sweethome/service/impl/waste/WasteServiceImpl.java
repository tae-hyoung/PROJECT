package com.homecat.sweethome.service.impl.waste;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.homecat.sweethome.mapper.alarm.AlarmMapper;
import com.homecat.sweethome.mapper.comm.CommDetailMapper;
import com.homecat.sweethome.mapper.waste.WasteMapper;
import com.homecat.sweethome.service.waste.WasteService;
import com.homecat.sweethome.unit.AttachDao;
import com.homecat.sweethome.unit.UploadController;
import com.homecat.sweethome.vo.comm.CommDetailVO;
import com.homecat.sweethome.vo.waste.WasteVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class WasteServiceImpl implements WasteService {

	@Autowired
	WasteMapper wasteMapper;
	
	@Autowired
	CommDetailMapper CommDetailMapper;
	
	@Autowired
	UploadController uploadController;

	@Autowired
	AttachDao attachDao;
	
	@Autowired
	String uploadFolder;
	
	@Autowired
	AlarmMapper alarmMapper;
	
	// 폐기물 신청 목록
	@Override
	public List<WasteVO> wasteList(Map<String, Object> map) {
		return this.wasteMapper.wasteList(map);
	}

	// 폐기물 신청 상세
	@Override
	public WasteVO detail(String wasteSeq) {
		return this.wasteMapper.detail(wasteSeq);
	}

	// 폐기물 배출 신청
	@Override
	public int createPost(WasteVO wasteVO) {
		log.info("createPost : " + wasteVO);
		
		// 폐기물 순번 가져오기
		String wasteSeq = this.wasteMapper.getWasteSeq();
		wasteVO.setWasteSeq(wasteSeq);
		
		// 수수료 계산
		CommDetailVO commDetail = CommDetailMapper.getCommDetCode(wasteVO.getCommDetCodeNm());
        if (commDetail != null) {
            int commDetCodeDscr;
            try {
                commDetCodeDscr = Integer.parseInt(commDetail.getCommDetCodeDscr());
            } catch (NumberFormatException e) {
                return 0; // 오류 처리
            }
            int fee = commDetCodeDscr * wasteVO.getQty();
            wasteVO.setFee(fee);
        } else {
            return 0; // 오류 처리
        }
		
		int cnt = 1;
		
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("HHmmss");
		String time = sdf.format(date);
		
		String filename = wasteSeq + time;
		if (wasteVO.getUploadFiles() != null) {
			cnt += this.uploadController.uploadMulti(wasteVO.getUploadFiles(), filename);
		} else {
			log.info("업로드된 파일이 없어영");
		}
		
		//파일업로드
//		AttachVO attachVO = this.attachDao.getFileName(wasteSeq + time);
//		String filePath = attachVO.getFileName();

		// ATTACH 테이블에 데이터 삽입
		wasteVO.setAttach(filename); // attach 필드에 filePath 설정

		//waste테이블에 등록
		int result = this.wasteMapper.createPost(wasteVO);
		
		return result;
	}

	// 폐기물 신청 수정
	@Override
	public int updatePost(WasteVO wasteVO) {
		/*
		wasteVO : WasteVO(rnum=0, wasteSeq=20240618002, memId=null, regDt=null, wasteItem=null, qty=0, fee=0
		, etc=ㅇㅇㅇ2, recycleYn=n, estDt=2024-06-21, wasteStatus=null, cancelYn=null, cancelTm=null, attach=null, statusComment=null
		, uploadFiles=[org.springframework.web.multipart.support.StandardMultipartHttpServletRequest$StandardMultipartFile@24ea45d, 
		org.springframework.web.multipart.support.StandardMultipartHttpServletRequest$StandardMultipartFile@197844f8, 
		org.springframework.web.multipart.support.StandardMultipartHttpServletRequest$StandardMultipartFile@177e24e9], 
		filePath=null, attachList=null, commDetailVO=null, memberVO=null, commDetCodeNm=, commDetCodeDscr=null, attachVO=null)
		 */
		log.info("updatePost->wasteVO>>>>" + wasteVO);
		int cnt = 0;

		if (wasteVO.getUploadFiles() != null) {
			Date date = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("HHmmss");
			String time = sdf.format(date);
			//ATTACH.GLOBAL_CODE컬럼을 위함
			String filename = wasteVO.getWasteSeq() + time;
			cnt += this.uploadController.uploadMulti(wasteVO.getUploadFiles(), filename);
	
			wasteVO.setAttach(filename); 
		} else {
			log.info("업로드된 파일이 없어영");
		}

		int result = this.wasteMapper.updatePost(wasteVO);

		return result;
	}

	// 폐기물 신청 삭제
	@Override
	public int deletePost(WasteVO wasteVO) {
		return this.wasteMapper.deletePost(wasteVO);
	}

	//관리자 페이지////////////////////////////////////////////////////////////////
	//입주민 폐기물 신청 내역
	@Override
	public List<WasteVO> adWasteList(Map<String, Object> map) {
		return this.wasteMapper.adWasteList(map);
	}

	//모달 상세
	@Override
	public WasteVO modalDetail(WasteVO wasteVO) {
		return this.wasteMapper.modalDetail(wasteVO);
	}

	//모달수정
	@Override
	public int modalUpdate(WasteVO wasteVO) {
		//// 알림 인서트 시작 ////
		String memId = this.wasteMapper.getMemId(wasteVO.getWasteSeq());
		
		Map<String, String> alarmData = new HashMap<String, String>();
		alarmData.put("memId", memId);
		alarmData.put("globalCode", wasteVO.getWasteSeq());
		alarmData.put("category", "폐기물");
		
		int cnt = this.alarmMapper.insert(alarmData);
		log.info("alarmInsert->cnt: " + cnt);
		//// 알림 인서트 끝 ////
		return this.wasteMapper.modalUpdate(wasteVO);
	}

	@Override
	public List<WasteVO> homeCnt() {
		return wasteMapper.homeCnt();
	}

	//폐기물스티커
	@Override
	public WasteVO sticker(String wasteSeq) {
		return this.wasteMapper.sticker(wasteSeq);
	}

	//처리상태 데이터 카운트
	@Override
	public List<WasteVO> statusCount() {
		return this.wasteMapper.statusCount();
	}







}
