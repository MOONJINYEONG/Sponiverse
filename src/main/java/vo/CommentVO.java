package vo;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class CommentVO {

	private int comment_idx, qa_idx, user_idx;
	private String comment_content;
	private LocalDateTime comment_created_at;

	public int getComment_idx() {
		return comment_idx;
	}

	public void setComment_idx(int comment_idx) {
		this.comment_idx = comment_idx;
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

	public String getComment_content() {
		return comment_content;
	}

	public void setComment_content(String comment_content) {
		this.comment_content = comment_content;
	}

	public LocalDateTime getComment_created_at() {
		return comment_created_at;
	}

	public void setComment_created_at(LocalDateTime comment_created_at) {
		this.comment_created_at = comment_created_at;
	}

	// 날짜 데이터형식 변경
	public String getFormattedCommentDate() {
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy.MM.dd");
		return comment_created_at.format(formatter);
	}

}
