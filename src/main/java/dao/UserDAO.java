package dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;


import vo.UserVO;

public class UserDAO {
   @Autowired
   SqlSession sqlSession;
   
   public UserDAO(SqlSession sqlSession) {
      this.sqlSession = sqlSession;
   }
   
   //유저 회원가입
   public int userInsert(UserVO vo) {
      int res = sqlSession.insert("u.insert_user", vo);
      return res;
   }
   
   //아이디 중복확인
   public String selectId(String id) {
      String res = sqlSession.selectOne("u.select_id", id);
      return res;
   }
   
   //유저 로그인
   public UserVO userlogin(String id) {
      return sqlSession.selectOne("u.user_login", id);
   }
   
   //자동로그인 유저정보 확인
   public UserVO selectUserById(String id) {
      return sqlSession.selectOne("u.select_user", id);
   }
   
   //아아디 찾기
   public UserVO findUserId(UserVO vo) {
      return sqlSession.selectOne("u.forgot_id", vo);
   }
   
   //비밀번호 찾기
   public UserVO findUser(UserVO vo) {
      return sqlSession.selectOne("u.forgot_pwd", vo);
   }
   
   //비밀번호 변경(업데이트)
   public int updatePassword(UserVO vo) {
      return sqlSession.update("u.update_pwd", vo);
   }
   
   //비밀번호 일치 확인
   public UserVO check(int idx) {
      UserVO vo = sqlSession.selectOne("u.compare_pwd", idx);
      return vo;
   }
   
   //수정 페이지로 이동(수정 정보 가져가기)
   public UserVO selectOne(int user_idx) {
	   UserVO vo = sqlSession.selectOne("u.selectOne", user_idx);
	   return vo;
   }
   
   //유저 정보 수정
   public int update_userInfo(UserVO vo) {
	   int res = sqlSession.update("u.update_userInfo", vo);
	   return res;
   }
   //회원 탈퇴(DB삭제)
   public int delete(int user_idx) {
		int res = sqlSession.delete("u.delete_userInfo", user_idx);
		return res;
	}
   
   
}
