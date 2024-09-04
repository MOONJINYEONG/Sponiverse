package dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

import vo.PasswordResetTokenVO;

public class PasswordResetTokenDAO {

   @Autowired
   SqlSession sqlSession;
   
   public PasswordResetTokenDAO(SqlSession sqlSession) {
      this.sqlSession = sqlSession;
   }
   
   //토큰 db 저장
    public void insertToken(PasswordResetTokenVO token) {
       sqlSession.insert("r.insertToken", token);
    }

   //토큰을 통해 유저 정보 검색
    public PasswordResetTokenVO findByToken(String token) {
       return sqlSession.selectOne("r.findByToken", token);
    }

    //토큰 삭제  
    public void deleteByToken(String token) {
       sqlSession.delete("r.deleteByToken", token);
    }
      
}
