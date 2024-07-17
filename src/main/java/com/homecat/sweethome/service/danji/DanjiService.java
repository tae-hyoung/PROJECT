package com.homecat.sweethome.service.danji;

import java.util.List;
import java.util.Map;

import com.homecat.sweethome.vo.danji.DanjiVO;

public interface DanjiService {

	public List<DanjiVO> getList();

	public DanjiVO getDetail(String danjiCode);

	public int createDanji(DanjiVO danjiVO);

	public String getDanjiCode();

	public int updatePost(DanjiVO danjiVO);

	public int deletePost(DanjiVO danjiVO);

	public List<DanjiVO> getDanji();

	public DanjiVO getDanji2(Map<String, Object> data);


}
