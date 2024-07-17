package com.homecat.sweethome.service.impl.contract;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.homecat.sweethome.mapper.contract.ContractMapper;
import com.homecat.sweethome.service.contract.ContractService;
import com.homecat.sweethome.unit.AttachDao;
import com.homecat.sweethome.unit.UploadController;
import com.homecat.sweethome.vo.attach.AttachVO;
import com.homecat.sweethome.vo.contract.ContractVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ContractServiceImpl implements ContractService {
	
	@Autowired
	ContractMapper contractMapper;
	
	@Autowired
	UploadController uploadController;
	
	@Autowired
	AttachDao attachDao;

	@Override
	public List<ContractVO> contractList() {
		return this.contractMapper.contractList();
	}

	@Override
	public int createContract(ContractVO contractVO) {
		
        Date date = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHH24mmss");
		
		// 파일 업로드
		this.uploadController.uploadMulti(contractVO.getMyFiles(), contractVO.getCtSeq() +sdf.format(date));
		
		// 파일 명 불러오기
		AttachVO attach = this.attachDao.getFileName(contractVO.getCtSeq() +sdf.format(date));
		log.info("attach" + attach);
		// 파일 명 셋팅
		contractVO.setCtAttach(attach.getFileName());
		log.info("contractVO" + contractVO);
		
		return this.contractMapper.createContract(contractVO);
	}

	@Override
	public List<ContractVO> getTopList(int num) {
		return this.contractMapper.getTopList(num);
	}

}
