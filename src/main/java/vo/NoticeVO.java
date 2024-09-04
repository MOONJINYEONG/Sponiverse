package vo;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class NoticeVO {
	private int event_idx, notice_idx;
	private String notice_title, notice_content;
	private LocalDateTime notice_date;

	public int getNotice_idx() {
		return notice_idx;
	}

	public void setNotice_idx(int notice_idx) {
		this.notice_idx = notice_idx;
	}

	public int getEvent_idx() {
		return event_idx;
	}

	public void setEvent_idx(int event_idx) {
		this.event_idx = event_idx;
	}

	public String getNotice_title() {
		return notice_title;
	}

	public void setNotice_title(String notice_title) {
		this.notice_title = notice_title;
	}

	public String getNotice_content() {
		return notice_content;
	}

	public void setNotice_content(String notice_content) {
		this.notice_content = notice_content;
	}

	public LocalDateTime getNotice_date() {
		return notice_date;
	}

	public void setNotice_date(LocalDateTime notice_date) {
		this.notice_date = notice_date;
	}

	// 날짜 데이터형식 변경
	public String getFormattedNoticeDate() {
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy.MM.dd(EEE) HH:mm");
		return notice_date.format(formatter);
	}
}
