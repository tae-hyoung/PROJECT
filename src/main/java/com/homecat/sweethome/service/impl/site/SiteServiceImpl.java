package com.homecat.sweethome.service.impl.site;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.homecat.sweethome.mapper.site.SiteMapper;
import com.homecat.sweethome.service.site.SiteService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class SiteServiceImpl implements SiteService {

	@Autowired
	SiteMapper siteMapper;
	
	@Override
	public int getVisitTotal() {
		int result = this.siteMapper.visit();
		log.info("result: " + result);
		return this.siteMapper.getVisitTotal();
	}

	@Override
	public int getVisitToday() {
		return this.siteMapper.getVisitToday();
	}

}
