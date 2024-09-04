package dao;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.io.FileUtils;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.multipart.MultipartFile;

import vo.CommentVO;
import vo.EventVO;
import vo.NoticeVO;
import vo.QaVO;

public class EventDAO {

	@Autowired
	SqlSession sqlSession;

	public EventDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	// 행사 생성하기
	public int eventInsert(EventVO vo) {
		return sqlSession.insert("e.event_insert", vo);
	}

	// SummerNote 이미지 파일 저장하기
	public Map<String, Object> SummerNoteImageFile(MultipartFile file) {
		Map<String, Object> resultMap = new HashMap();
		String fileRoot = "C:\\summernoteImg\\";
		String originalFileName = file.getOriginalFilename();
		String extension = originalFileName.substring(originalFileName.lastIndexOf("."));

		String saveFileName = System.currentTimeMillis() + extension;

		File targetFile = new File(fileRoot + saveFileName);

		try {
			InputStream fileStream = file.getInputStream();
			FileUtils.copyInputStreamToFile(fileStream, targetFile);
			resultMap.put("url", "/summernoteImg/" + saveFileName);
			resultMap.put("responseCode", "success");
		} catch (IOException e) {
			FileUtils.deleteQuietly(targetFile);
			resultMap.put("responseCode", "error");
			e.printStackTrace();
		}
		return resultMap;
	}

	// 사용자별 이벤트 조회 페이징포함
	public List<EventVO> selectEventPageByUser(Map<String, Object> map) {
		return sqlSession.selectList("e.usereventspage", map);
	}

	// 사용자별 이벤트 게시글 수 가져오기
	public int eventcountByUser(int user_idx) {
		return sqlSession.selectOne("e.eventcount", user_idx);
	}

	// 사용자별 이벤트삭제 게시글 수 가져오기
	public int eventDeletecountByUser(int user_idx) {
		return sqlSession.selectOne("e.eventCancelCount", user_idx);
	}

	// 사용자별 이벤트 조회
	public List<EventVO> selectEventByUser(int user_idx) {
		return sqlSession.selectList("e.userevents", user_idx);
	}

	// 사용자별 이벤트취소 조회
	public List<EventVO> selectEventDeletePageByUser(Map<String, Object> map) {
		return sqlSession.selectList("e.usereventspagecancel", map);
	}

	// 전체 이벤트 조회
	public List<EventVO> allevents(Map<String, Object> map) {
		return sqlSession.selectList("e.allevents", map);
	}

	// 전체 이벤트 게시글 수 가져오기
	public int eventcount(Map<String, Object> map) {
		return sqlSession.selectOne("e.event_count", map);
	}

	// 이벤트 디테일 정보 idx별로 가져오기
	public EventVO eventByIdx(int event_idx) {
		return sqlSession.selectOne("e.getevent_idx", event_idx);
	}

	// 이벤트에 신청된 티켓 수 조회
	public int applieCount(int event_idx) {
		return sqlSession.selectOne("e.apply_event", event_idx);
	}

	// 이벤트 수정 업데이트
	public int updateEvent(EventVO vo) {
		return sqlSession.update("e.update_event", vo);
	}

	// 조회수 증가
	public int update_viewcount(int event_idx) {
		return sqlSession.update("e.event_update_viewcount", event_idx);
	}

	// 다가오는 행사 리스트
	public List<EventVO> fastevent() {
		return sqlSession.selectList("e.fast_event");
	}

	// 호스트 센터에서 행사 취소
	public int deleteEvent(int event_idx) {
		return sqlSession.update("e.delete_event", event_idx);
	}

	// 공지사항 저장
	public int savenotice(NoticeVO vo) {
		return sqlSession.insert("e.save_notice", vo);
	}

	// 공지사항 조회
	public NoticeVO noticeByIdx(int event_idx) {
		return sqlSession.selectOne("e.select_notice", event_idx);
	}

	// 공지사항 수정
	public int updatenotice(NoticeVO vo) {
		return sqlSession.update("e.update_notice", vo);
	}

	// 공지사항 삭제
	public int deletenotice(int notice_idx) {
		return sqlSession.delete("e.delete_notice", notice_idx);
	}

	// 문의하기
	public int insertQa(QaVO vo) {
		return sqlSession.insert("e.inser_qa", vo);
	}

	// 문의하기 이벤트별 조회
	public List<QaVO> qalist(int event_idx) {
		return sqlSession.selectList("e.qa_list", event_idx);
	}

	// 댓글달려고하는 문의하기id
	public QaVO getQaByIdx(int qa_idx) {
		return sqlSession.selectOne("e.qa_one_idx", qa_idx);
	}

	// 댓글 작성
	public int insertComment(CommentVO vo) {
		return sqlSession.insert("e.insert_comment", vo);
	}

	// 댓글 조회
	public List<CommentVO> getCommentsByQaIdx(int qa_idx) {
		return sqlSession.selectList("e.select_comment_qaidx", qa_idx);
	}

	// 댓글삭제를 위한 댓글idx가져오기
	public CommentVO getCommentByIdx(int comment_idx) {
		return sqlSession.selectOne("e.select_del_comm", comment_idx);
	}

	// 댓글삭제
	public int deleteComment(int comment_idx) {
		return sqlSession.delete("e.delete_comment", comment_idx);
	}

}
