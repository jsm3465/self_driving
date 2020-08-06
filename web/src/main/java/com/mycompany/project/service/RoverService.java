package com.mycompany.project.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mycompany.project.controller.RoverController;
import com.mycompany.project.dao.RoverDao;
import com.mycompany.project.model.Rover;

@Service
public class RoverService {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(RoverService.class);

	@Autowired
	private RoverDao roverDao;

	public List<Rover> getRoverList() {
		LOGGER.info("실행");
		List<Rover> list = roverDao.getRoverList();
		return list;
	}
	
	
}
