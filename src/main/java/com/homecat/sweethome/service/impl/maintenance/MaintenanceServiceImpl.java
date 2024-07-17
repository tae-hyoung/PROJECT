package com.homecat.sweethome.service.impl.maintenance;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.map.HashedMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.homecat.sweethome.mapper.alarm.AlarmMapper;
import com.homecat.sweethome.mapper.maintenance.MaintenanceMapper;
import com.homecat.sweethome.service.ccpy.CcpyService;
import com.homecat.sweethome.service.maintenance.MaintenanceService;
import com.homecat.sweethome.unit.AttachDao;
import com.homecat.sweethome.unit.UploadController;
import com.homecat.sweethome.vo.attach.AttachVO;
import com.homecat.sweethome.vo.ccpy.CcpyVO;
import com.homecat.sweethome.vo.maintenance.MaintenanceVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class MaintenanceServiceImpl implements MaintenanceService{

	@Autowired
	MaintenanceMapper maintenanceMapper;
	
	@Autowired
	UploadController uploadController;

	@Autowired
	AttachDao attachDao;
	
	@Autowired
	String uploadFolder;
	
	@Autowired
	CcpyService ccpyService;

	@Autowired
	AlarmMapper alarmMapper;

	
	//목록 뷰	
//	public List<MaintenanceVO> list(Map<String, Object> map){
//		return this.maintenanceMapper.list(map);
//	}
	public List<MaintenanceVO> list(MaintenanceVO maintenanceVO){
		return this.maintenanceMapper.list(maintenanceVO);
	}

	//상세 뷰
	@Override
	public MaintenanceVO detail(String mtSeq) {
		MaintenanceVO maintenanceVO = this.maintenanceMapper.detail(mtSeq);
		// ccpyCode를 이용해 해당 협력업체 정보를 가져옴
		
		
		List<CcpyVO> ccpyList = ccpyService.getCcpyCode(); 
		log.info("ccpyList>>>>>" + ccpyList);
		
		maintenanceVO.setCcpyList(ccpyList);
		
		return maintenanceVO;
	}

	//하자보수 신청
	@Override
	public int createPost(MaintenanceVO maintenanceVO) {
		
		// 하자보수 순번 가져오기
		String mtSeq = this.maintenanceMapper.getMtSeq();
		maintenanceVO.setMtSeq(mtSeq);
		
		int cnt = 1;
		
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("HHmmss");
		String time = sdf.format(date);
		
		String filename = mtSeq + time;
		if (maintenanceVO.getUploadFiles() != null) {
			cnt += this.uploadController.uploadMulti(maintenanceVO.getUploadFiles(), filename);
		} else {
			log.info("업로드된 파일이 없어영");
		}
		
		maintenanceVO.setAttach(filename);
		
		int result = this.maintenanceMapper.createPost(maintenanceVO);
		
		return result;
	}

	//회원정보 가져오기
	@Override
	public MaintenanceVO getMemberInfo(String memId) {
		return this.maintenanceMapper.getMemberInfo(memId);
	}

	@Override
	public String getMtSeq() {
		return this.maintenanceMapper.getMtSeq();
	}

	//수정수정
	@Override
	public int updatePost(MaintenanceVO maintenanceVO) {
		
		log.info("updatePost->maintenanceVO>>>>" + maintenanceVO);
		int cnt = 0;

		if (maintenanceVO.getUploadFiles() != null) {
			Date date = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("HHmmss");
			String time = sdf.format(date);
			//ATTACH.GLOBAL_CODE컬럼을 위함
			String filename = maintenanceVO.getMtSeq() + time;
			cnt += this.uploadController.uploadMulti(maintenanceVO.getUploadFiles(), filename);
	
			maintenanceVO.setAttach(filename); 
		} else {
			log.info("업로드된 파일이 없어영");
		}

		int result = this.maintenanceMapper.updatePost(maintenanceVO);
		
		return result;
	}

	//삭제
	@Override
	public int deletePost(Map<String, Object> map) {
		
		return this.maintenanceMapper.deletePost(map);
	}

	/////////////////관리자 페이지///////////////////////////////////////////////////////////////////
	//입주민 하자보수 신청 내역
	@Override
	public List<MaintenanceVO> adList(MaintenanceVO maintenanceVO) {
		return this.maintenanceMapper.adList(maintenanceVO);
	}

	//모달 상세
	@Override
	public MaintenanceVO modalDetail(MaintenanceVO maintenanceVO) {
		
		maintenanceVO = maintenanceMapper.modalDetail(maintenanceVO);
//		System.out.println("maintenanceVO >>>>" + maintenanceVO);
		//첨부파일목록
		List<AttachVO> attachList = null;
		System.out.println("maintenanceVO.getAttach(1) >>>>>>>>>> " + maintenanceVO.getAttach());
		if (null != maintenanceVO && maintenanceVO.getAttach() != null) {
	
		System.out.println("maintenanceVO.getAttach(2) >>>>>>>>>> " + maintenanceVO.getAttach());
		attachList = maintenanceMapper.selectAttachList(maintenanceVO.getAttach());
		System.out.println("attachList >>>>>>>>>> " + attachList);
		maintenanceVO.setAttachList(attachList);
		}
		
		// ccpyCode를 이용해 해당 협력업체 정보를 가져옴
		List<CcpyVO> ccpyList = ccpyService.getCcpyCode(); 
		log.info("ccpyList>>>>>" + ccpyList);
		
		maintenanceVO.setCcpyList(ccpyList);
		
		return maintenanceVO;
	}

	//모달 수정1
	@Override
	public int modalUpdate(MaintenanceVO maintenanceVO) {
		//// 알림 인서트 시작 ////
//		String mtSeq = this.maintenanceMapper.getMtSeq();
//		maintenanceVO.setMtSeq(mtSeq);
//		
//		String memId = this.maintenanceMapper.getMemId(maintenanceVO.getMtSeq());
//		
//		Map<String, String> alarmData = new HashMap<String, String>();
//		alarmData.put("memId", memId);
//		alarmData.put("globalCode", maintenanceVO.getMtSeq());
//		alarmData.put("category", "하자보수 상태 변경");
//		
//		int cnt = this.alarmMapper.insert(alarmData);
//		log.info("alarmInsert->cnt: " + cnt);
		//// 알림 인서트 끝 ////
		return this.maintenanceMapper.modalUpdate(maintenanceVO);
	}

	//모달 수정2
	@Override
	public int modalUpdate2(MaintenanceVO maintenanceVO) {
		
		//// 알림 인서트 시작 ////
		String memId = this.maintenanceMapper.getMemId(maintenanceVO.getMtSeq());
		
		Map<String, String> alarmData = new HashMap<String, String>();
		alarmData.put("memId", memId);
		alarmData.put("globalCode", maintenanceVO.getMtSeq());
		alarmData.put("category", "하자보수 업체 지정");
		
		int cnt = this.alarmMapper.insert(alarmData);
		log.info("alarmInsert->cnt: " + cnt);
		//// 알림 인서트 끝 ////
		return this.maintenanceMapper.modalUpdate2(maintenanceVO);
	}

	@Override
	public List<MaintenanceVO> homeCnt() {
		return maintenanceMapper.homeCnt();
	}

	//처리상태 데이터 카운트
	@Override
	public List<MaintenanceVO> statusCount() {
		return maintenanceMapper.statusCount();
	}

}
