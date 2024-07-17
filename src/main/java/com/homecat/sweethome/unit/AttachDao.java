package com.homecat.sweethome.unit;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.homecat.sweethome.vo.attach.AttachVO;

@Repository
public class AttachDao {

	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	public int insertAttach(AttachVO attachVO) {
		return this.sqlSessionTemplate.insert("attach.insertAttach", attachVO);
	}

	// 글로벌 코드를 조건으로하여 첫번째 첨부파일 객체를 가져옴
	public AttachVO getFileName(String globalCode) {
		return this.sqlSessionTemplate.selectOne("attach.getFileName", globalCode);
	}
	
}
