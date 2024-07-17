package com.homecat.sweethome.service.impl.danji;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.homecat.sweethome.mapper.danji.DanjiMapper;
import com.homecat.sweethome.service.danji.DanjiService;
import com.homecat.sweethome.unit.AttachDao;
import com.homecat.sweethome.unit.UploadController;
import com.homecat.sweethome.vo.attach.AttachVO;
import com.homecat.sweethome.vo.danji.DanjiVO;

@Service
public class DanjiServiceImpl implements DanjiService {
	
	@Autowired
	DanjiMapper danjiMapper;
	
	@Autowired
	UploadController uploadController;
	
	@Autowired
	AttachDao attachDao;
	
	//단지 리스트
	@Override
	public List<DanjiVO> getList() {
		return this.danjiMapper.getList();
	}
	
	//단지 상세보기
	@Override
	public DanjiVO getDetail(String danjiCode) {
		return this.danjiMapper.getDetail(danjiCode);
	}

	@Override
	public int createDanji(DanjiVO danjiVO) {
		
        Date date = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHH24mmss");
		
		// 파일 업로드
		this.uploadController.uploadOne(danjiVO.getDanjiLayoutFile(), danjiVO.getDanjiCode()+"_layout"+sdf.format(date));
		this.uploadController.uploadOne(danjiVO.getDanjiPictureFile(), danjiVO.getDanjiCode()+"_picture"+sdf.format(date));
		
		// 파일 명 불러오기
		AttachVO danjiLayout = this.attachDao.getFileName(danjiVO.getDanjiCode() + "_layout"+sdf.format(date));
		AttachVO danjiPicture = this.attachDao.getFileName(danjiVO.getDanjiCode() + "_picture"+sdf.format(date));
		
		// 파일 명 셋팅
		danjiVO.setDanjiLayout(danjiLayout.getFileName());
		danjiVO.setDanjiPicture(danjiPicture.getFileName());
		
		return this.danjiMapper.createDanji(danjiVO);
	}

	@Override
	public String getDanjiCode() {
		return this.danjiMapper.getDanjiCode();
	}

	@Override
	public int updatePost(DanjiVO danjiVO) {
		
		
        Date date = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHH24mmss");
		
		// 파일 업로드
		this.uploadController.uploadOne(danjiVO.getDanjiLayoutFile(), danjiVO.getDanjiCode()+"_layout"+sdf.format(date));
		this.uploadController.uploadOne(danjiVO.getDanjiPictureFile(), danjiVO.getDanjiCode()+"_picture"+sdf.format(date));
		
		// 파일 명 불러오기
		AttachVO danjiLayout = this.attachDao.getFileName(danjiVO.getDanjiCode() + "_layout"+sdf.format(date));
		AttachVO danjiPicture = this.attachDao.getFileName(danjiVO.getDanjiCode() + "_picture"+sdf.format(date));
		
		// 파일 명 셋팅
		danjiVO.setDanjiLayout(danjiLayout.getFileName());
		danjiVO.setDanjiPicture(danjiPicture.getFileName());
		
		
		return this.danjiMapper.updatePost(danjiVO);
	}
	
	//삭제
	@Override
	public int deletePost(DanjiVO danjiVO) {
		return this.danjiMapper.deletePost(danjiVO);
	}
	
	//단지VO 값 가져오기
	@Override
	public List<DanjiVO> getDanji() {
		return this.danjiMapper.getDanji();
	}

	@Override
	public DanjiVO getDanji2(Map<String, Object> data) {
		return this.danjiMapper.getDanji2(data);
	}

}
