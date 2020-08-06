package com.mycompany.project.dao;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.mycompany.project.model.Rover;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository
public class RoverDao extends EgovAbstractMapper{
	
	private static final Logger LOGGER = LoggerFactory.getLogger(RoverDao.class);
	
	public List<Rover> getRoverList() {
		LOGGER.info("실행");
		List<Rover> list =selectList("rover.selectAll");
		return list;
	}
	
}
