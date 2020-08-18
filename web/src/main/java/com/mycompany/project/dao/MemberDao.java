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
	   LOGGER.info("실행");
      Member member = selectOne("member.selectByMid", mid);
      return member;
   }

   public void updateStateByMid(Member member) {
	   LOGGER.info("실행");
      update("member.updateStateByMid", member);
   }

   public String selectByMnameAndMemail(Member member) {
	   LOGGER.info("실행");
      String mid = selectOne("member.selectByMnameAndMemail", member);
      return mid;
   }

   public String selectByMidAndMnameAndMemail(Member member) {
	   LOGGER.info("실행");
      String password = selectOne("member.selectByMidAndMnameAndMtel", member);
      return password;
   }

   public Member selectByMemail(String memail) {
      LOGGER.info("실행");
      Member member = selectOne("member.selectByMemail", memail);
      
      return member;
   }

}