package com.mycompany.project.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mycompany.project.dao.BlackBoxDao;
import com.mycompany.project.model.BlackBox;

@Service
public class BlackBoxService {

	private static final Logger LOGGER = LoggerFactory.getLogger(BlackBoxService.class);

	@Autowired
	private BlackBoxDao blackBoxDao;
	
	public void saveImage(BlackBox blackBox) {
		//LOGGER.info("실행");
		blackBoxDao.saveImage(blackBox);
	}
}
