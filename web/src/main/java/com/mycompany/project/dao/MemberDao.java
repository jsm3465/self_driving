package com.mycompany.project.dao;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.mycompany.project.model.Member;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

@Repository
public class MemberDao extends EgovAbstractMapper{
	private static final Logger LOGGER =
			LoggerFactory.getLogger(MemberDao.class);
	
	public int signup(Member member) {
		LOGGER.info("실행");
		int rows = insert("member.signup", member);
		return rows;
	}

	public Member selectByMid(String mid) {
		Member member = selectOne("member.selectByMid", mid);
		return member;
	}

	public void updateStateByMid(Member member) {
		update("member.updateStateByMid", member);
	}

	public String selectByMnameAndMemail(Member member) {
		String mid = selectOne("member.selectByMnameAndMemail", member);
		return mid;
	}

	public String selectByMidAndMnameAndMemail(Member member) {
		String password = selectOne("member.selectByMidAndMnameAndMemail", member);
		return password;
	}

	public Member selectByMemail(String memail) {
		LOGGER.info("실행");
		Member member = selectOne("member.selectByMemail", memail);
		
		return member;
	}

	public void updateMember(Member member) {
		int rows = update("updateByMid", member);
		
	}

	public void updatePassword(Member member) {
		int rows = update("updatePasswordByMid", member);
		
	}

	public void deleteMemberByMid(String mid) {
		int rows = delete("deleteByMid", mid);
		
	}

}
