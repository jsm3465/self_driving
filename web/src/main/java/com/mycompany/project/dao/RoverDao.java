package com.mycompany.project.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

	public void resisterRover(Rover rover) {
		LOGGER.info("실행");
		insert("rover.insert", rover);
	}

	public Rover getRover(String rname) {
		LOGGER.info("실행");
		Rover rover = selectOne("rover.selectByRname", rname);
		return rover;
	}

	public void deleteRover(String rname) {
		LOGGER.info("실행");
		delete("rover.deleteByRname", rname);
	}

	public void returnControl(Rover rover) {
		LOGGER.info("실행");
		String rname = rover.getRname();
		update("rover.updateByRname", rname);
		
	}

	public void updateRuser(String rname, String ruser) {
		LOGGER.info("실행");
		Map<String, String> data = new HashMap<>();
		data.put("rname", rname);
		data.put("ruser", ruser);
		update("rover.updateRuser", data);
		
	}
	
}
