package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

import vo.OrderVO;
import vo.PayVO;

public class OrderDAO {
	@Autowired
	SqlSession sqlSession;

	public OrderDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	// 유저행사신청
	public int orderevent(OrderVO user) {
		int res = sqlSession.insert("o.user_order", user);
		System.out.println("inser res = " + res);
		System.out.println("order_idx = " + user.getOrder_idx());
		return res;
	}

	// 사용자가 이미 신청한 이벤트인지 확인
	public boolean isAlreadyRegistered(int userIdx, int eventIdx) {
		Map<String, Integer> params = new HashMap<>();
		params.put("user_idx", userIdx);
		params.put("event_idx", eventIdx);
		int count = sqlSession.selectOne("o.isAlreadyRegistered", params);
		return count > 0;
	}

	// 결제
	public int savePay(PayVO pay) {
		return sqlSession.insert("o.user_pay", pay);
	}

	// 사용자가 신청한 행사 리스트
	public List<OrderVO> selectEventByorder(Map<String, Object> map) {
		return sqlSession.selectList("o.user_order_list", map);
	}

	// 사용자가 취소한 신청행사 리스트
	public List<OrderVO> selectCancelByorder(Map<String, Object> map) {
		return sqlSession.selectList("o.user_cancel_list", map);
	}

	// 이벤트신청 삭제
	public int deleteOrder(int order_idx) {
		return sqlSession.delete("o.user_order_delete", order_idx);
	}

	// 신청한 행사 유저 조회
	public List<OrderVO> orderByIdx(int event_idx) {
		return sqlSession.selectList("o.user_order_event", event_idx);
	}

	// 마이페이지에서 행사 리스트 취소
	public int cancelEvent(int user_idx, int event_idx) {
		Map<String, Integer> map = new HashMap<>();
		map.put("user_idx", user_idx);
		map.put("event_idx", event_idx);
		int res = sqlSession.update("o.cancel_event", map);
		return res;
	}

	// 유저별 신청한 행사 카운트
	public int ordercountByUser(int user_idx) {
		return sqlSession.selectOne("o.ordercount", user_idx);
	}

	// 유저별 신청취소 카운트
	public int orderCancelCountByUser(int user_idx) {
		return sqlSession.selectOne("o.orderCancelCount", user_idx);
	}
	
	//신청취소자 카운트 조회
	public int canceltotal(int event_idx) {
		return sqlSession.selectOne("o.canceltotal", event_idx);
	}

}
