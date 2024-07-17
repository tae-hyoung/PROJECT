package com.homecat.sweethome.service.impl.vote;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.homecat.sweethome.mapper.vote.VoteMapper;
import com.homecat.sweethome.service.vote.VoteService;
import com.homecat.sweethome.unit.AttachDao;
import com.homecat.sweethome.unit.UploadController;
import com.homecat.sweethome.vo.attach.AttachVO;
import com.homecat.sweethome.vo.vote.VoteDetailVO;
import com.homecat.sweethome.vo.vote.VoteResultVO;
import com.homecat.sweethome.vo.vote.VoteVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class VoteServiceImpl implements VoteService {
	
	@Autowired
	VoteMapper voteMapper;
	
	@Autowired
	UploadController uploadController;

	@Autowired
	AttachDao attachDao;
	
	@Autowired
	String uploadFolder;
	
	@Override
	public int getTotal(Map<String, Object> map) {
		return this.voteMapper.getTotal(map);
	}

	@Override
	public List<VoteVO> getList(Map<String, Object> map) {
		return this.voteMapper.getList(map);
	}
	
	@Override
	public int createPost(VoteVO voteVO) {
		
		//1) VOTE 테이블에 INSERT
		int result = this.voteMapper.createPost(voteVO);
		
		String voteCode = this.voteMapper.getVoteCode(voteVO);
		voteVO.setVoteCode(voteCode);
		
		//2) VOTE_DETAIL 테이블에 INSERT
		List<VoteDetailVO> voteDetVOList = voteVO.getVoteDetails();
		for(VoteDetailVO voteDetailVO : voteDetVOList) {
			voteDetailVO.setVoteCode(voteVO.getVoteCode());
			
			
			// VD_CODE 생성
			Map<String, Object> params = new HashMap<>();
			params.put("voteCode", voteCode);
			String vdCode = this.voteMapper.makeVdCode(params);
			voteDetailVO.setVdCode(vdCode);
			
			
			//파일명 설정
			Date date = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("HHmmss");
			String time = sdf.format(date);
			String filename =  vdCode + time;
			
			//파일 업로드 처리
			int cnt = 1;
			if(voteDetailVO.getUploadFiles() != null) {
				cnt += this.uploadController.uploadMulti(voteDetailVO.getUploadFiles(), filename);
			} else {
				log.info("업로드 파일이 음슴");
			}
			
			AttachVO attach = this.attachDao.getFileName(filename);
			
			//ATTACH 테이블에 데이터 삽입
			voteDetailVO.setAttach(attach.getFileName());
			
			result = this.voteMapper.insertDetail(voteDetailVO);
			
		}
		return result;
	}

	@Override
	public int closeVote(String voteCode) {
		return this.voteMapper.closeVote(voteCode);
	}

	@Override
	public VoteVO getVoteByCode(String voteCode) {
		return this.voteMapper.getVoteByCode(voteCode);
	}

	@Override
	public List<VoteDetailVO> getDetailsByCode(String voteCode) {
		return this.voteMapper.getDetailsByCode(voteCode);
	}

	@Override
	public int voteDetailDelete(VoteVO voteVO) {
		return this.voteMapper.voteDetailDelete(voteVO);
	}
	
	@Override
	public int insertDetail(VoteDetailVO voteDetailVO) {
	    String voteCode = voteDetailVO.getVoteCode(); 
	    
	    // 파일 업로드 처리
	    int cnt = 1;
	    
	    MultipartFile[] uploadFiles = voteDetailVO.getUploadFiles();
	    
	    if (uploadFiles[0].getOriginalFilename().length() > 0) {
	    	 // VD_CODE 생성
		    Map<String, Object> params = new HashMap<>();
		    params.put("voteCode", voteCode);
		    String vdCode = this.voteMapper.makeVdCode(params);
		    voteDetailVO.setVdCode(vdCode);
	    	
	    	// 파일명 설정
		    Date date = new Date();
		    SimpleDateFormat sdf = new SimpleDateFormat("HHmmss");
		    String time = sdf.format(date);
		    String filename = vdCode + time;
		    
	        cnt += this.uploadController.uploadMulti(voteDetailVO.getUploadFiles(), filename);
	        
	        AttachVO attach = this.attachDao.getFileName(filename);
		    
		    // ATTACH 테이블에 데이터 삽입
		    voteDetailVO.setAttach(attach.getFileName());
	    } else {
	        log.info("업로드 파일이 음슴");
	    }
	    
	    // 결과 반환(merge into)
	    return this.voteMapper.insertDetail(voteDetailVO);
	}


	@Override
	public int updatePost(VoteVO voteVO) {
		return this.voteMapper.updatePost(voteVO);
	}

	@Override
	public int voteDelete(VoteVO voteVO) {
		return this.voteMapper.voteDelete(voteVO);
	}

	@Override
	public int insertResult(VoteResultVO voteResultVO) {
		return this.voteMapper.insertResult(voteResultVO);
	}

	@Override
	public List<VoteResultVO> searchResult(String voteCode) {
		return this.voteMapper.searchResult(voteCode);
	}

	@Override
	public List<String> getReplyerList(String voteCode) {
		return this.voteMapper.getReplyerList(voteCode);
	}

	@Override
	public int participantCnt(String voteCode) {
		return this.voteMapper.participantCnt(voteCode);
	}

	@Override
	public List<String> getSubmitVoteUser(String memId) {
		return this.voteMapper.getSubmitVoteUser(memId);
	}

	@Override
	public List<VoteVO> homeCnt() {
		return voteMapper.homeCnt();
	}

	//찌꺼기 제거(마지막 복합키 데이터를 파라미터로 던짐)
	@Override
	public int voteDetailArrange(VoteDetailVO lastVoteDetailVO) {
		return voteMapper.voteDetailArrange(lastVoteDetailVO);
	}

}
