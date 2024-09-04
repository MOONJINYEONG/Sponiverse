package dao;

import org.apache.ibatis.session.SqlSession;

public class CategoryDAO {
	
	SqlSession sqlSession;
	
	public CategoryDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	
}
