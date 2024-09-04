package vo;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

public class QaVO {
	private int qa_idx, event_idx, user_idx;
	private String user_name, user_email, qa_content, qa_is_private;
	private LocalDateTime qa_created_at;
	private boolean canViewPrivate;
	private List<CommentVO> comments; // 댓글 필드 추가

	public boolean isPrivate() {
		return "Y".equals(qa_is_private);
	}

	public boolean getCanViewPrivate() {
		return canViewPrivate;
	}

	public void setCanViewPrivate(boolean canViewPrivate) {
		this.canViewPrivate = canViewPrivate;
	}

	public int getQa_idx() {
		return qa_idx;
	}

	public void setQa_idx(int qa_idx) {
		this.qa_idx = qa_idx;
	}

	public int getUser_idx() {
		return user_idx;
	}

	public void setUser_idx(int user_idx) {
		this.user_idx = user_idx;
	}

	public int getEvent_idx() {
		return event_idx;
	}

	public void setEvent_idx(int event_idx) {
		this.event_idx = event_idx;
	}

	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

	public String getUser_email() {
		return user_email;
	}

	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}

	public String getQa_content() {
		return qa_content;
	}

	public void setQa_content(String qa_content) {
		this.qa_content = qa_content;
	}

	public String getQa_is_private() {
		return qa_is_private;
	}

	public void setQa_is_private(String qa_is_private) {
		this.qa_is_private = qa_is_private;
	}

	public LocalDateTime getQa_created_at() {
		return qa_created_at;
	}

	public void setQa_created_at(LocalDateTime qa_created_at) {
		this.qa_created_at = qa_created_at;
	}

	// 날짜 데이터형식 변경
	public String getFormattedQaDate() {
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy.MM.dd");
		return qa_created_at.format(formatter);
	}

	public List<CommentVO> getComments() {
		return comments;
	}

	public void setComments(List<CommentVO> comments) {
		this.comments = comments;
	}

}
