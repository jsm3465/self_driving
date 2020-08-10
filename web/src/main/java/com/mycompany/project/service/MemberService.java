package com.mycompany.project.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mycompany.project.dao.MemberDao;
import com.mycompany.project.model.Member;

@Service
public class MemberService {
	private static final Logger LOGGER = LoggerFactory.getLogger(MemberService.class);
	
	@Autowired
	private MemberDao memberDao;
	
	public void signup(Member member) {
		LOGGER.info("실행");
		memberDao.signup(member);
	}
	
	public static final int LOGIN_FAIL_MID = 0;
	public static final int LOGIN_FAIL_MPASSWORD = 1;
	public static final int LOGIN_SUCCESS = 2;
	public int signin(Member member) {
		LOGGER.info("실행");
		Member dbMember = memberDao.selectByMid(member.getMid());
		
		if(dbMember == null) {
			return LOGIN_FAIL_MID;
		} else {
			if(dbMember.getMpassword().equals(member.getMpassword())) {
				return LOGIN_SUCCESS;
			} else {
				return LOGIN_FAIL_MPASSWORD;
			}
		}
	}
	
	public void updateStateByMid(Member member) {
		memberDao.updateStateByMid(member);
	}

	public String findId(Member member) {
		String mid = memberDao.selectByMnameAndMemail(member);
		return mid;
	}

	public String findPassword(Member member) {
		String password = memberDao.selectByMidAndMnameAndMemail(member);
		return password;
	}

	public Member selectByMemail(String memail) {
		LOGGER.info("실행");
		Member member = memberDao.selectByMemail(memail);
		return member;
	}

	public Member selectByMid(String mid) {
		Member member = memberDao.selectByMid(mid);
		return member;
	}

}
