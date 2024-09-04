package vo;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import org.springframework.web.multipart.MultipartFile;

public class EventVO {
	private int event_idx, event_sports_idx, event_addrcode, event_max_joiner, event_price, user_idx, event_viewCount;
	private String event_loc, event_name, event_addr, event_addrdetail, event_thumbnail, event_content, event_paymethod,
			event_ticketname, event_contact_name, event_contact_email, event_contact_tel, event_bank, event_account,
			event_account_name, event_ticket_open, delete_status;
	private LocalDateTime event_h_start, event_h_end, event_r_start, event_r_end, event_createdate, delete_date;

	// 파일 업로드와 관련된 객체 썸네일
	private MultipartFile photo;

	// getter와 setter 메서드들

	public int getEvent_idx() {
		return event_idx;
	}

	public void setEvent_idx(int event_idx) {
		this.event_idx = event_idx;
	}

	public int getEvent_sports_idx() {
		return event_sports_idx;
	}

	public void setEvent_sports_idx(int event_sports_idx) {
		this.event_sports_idx = event_sports_idx;
	}

	public int getEvent_addrcode() {
		return event_addrcode;
	}

	public void setEvent_addrcode(int event_addrcode) {
		this.event_addrcode = event_addrcode;
	}

	public int getEvent_max_joiner() {
		return event_max_joiner;
	}

	public void setEvent_max_joiner(int event_max_joiner) {
		this.event_max_joiner = event_max_joiner;
	}

	public int getEvent_price() {
		return event_price;
	}

	public void setEvent_price(int event_price) {
		this.event_price = event_price;
	}

	public String getEvent_loc() {
		return event_loc;
	}

	public void setEvent_loc(String event_loc) {
		this.event_loc = event_loc;
	}

	public String getEvent_name() {
		return event_name;
	}

	public void setEvent_name(String event_name) {
		this.event_name = event_name;
	}

	public String getEvent_addr() {
		return event_addr;
	}

	public void setEvent_addr(String event_addr) {
		this.event_addr = event_addr;
	}

	public String getEvent_addrdetail() {
		return event_addrdetail;
	}

	public void setEvent_addrdetail(String event_addrdetail) {
		this.event_addrdetail = event_addrdetail;
	}

	public String getEvent_content() {
		return event_content;
	}

	public void setEvent_content(String event_content) {
		this.event_content = event_content;
	}

	public String getEvent_paymethod() {
		return event_paymethod;
	}

	public void setEvent_paymethod(String event_paymethod) {
		this.event_paymethod = event_paymethod;
	}

	public String getEvent_ticketname() {
		return event_ticketname;
	}

	public void setEvent_ticketname(String event_ticketname) {
		this.event_ticketname = event_ticketname;
	}

	public String getEvent_contact_name() {
		return event_contact_name;
	}

	public void setEvent_contact_name(String event_contact_name) {
		this.event_contact_name = event_contact_name;
	}

	public String getEvent_contact_email() {
		return event_contact_email;
	}

	public void setEvent_contact_email(String event_contact_email) {
		this.event_contact_email = event_contact_email;
	}

	public String getEvent_contact_tel() {
		return event_contact_tel;
	}

	public void setEvent_contact_tel(String event_contact_tel) {
		this.event_contact_tel = event_contact_tel;
	}

	public LocalDateTime getEvent_h_start() {
		return event_h_start;
	}

	public void setEvent_h_start(LocalDateTime event_h_start) {
		this.event_h_start = event_h_start;
	}

	public LocalDateTime getEvent_h_end() {
		return event_h_end;
	}

	public void setEvent_h_end(LocalDateTime event_h_end) {
		this.event_h_end = event_h_end;
	}

	public LocalDateTime getEvent_r_start() {
		return event_r_start;
	}

	public void setEvent_r_start(LocalDateTime event_r_start) {
		this.event_r_start = event_r_start;
	}

	public LocalDateTime getEvent_r_end() {
		return event_r_end;
	}

	public void setEvent_r_end(LocalDateTime event_r_end) {
		this.event_r_end = event_r_end;
	}

	public String getEvent_bank() {
		return event_bank;
	}

	public void setEvent_bank(String event_bank) {
		this.event_bank = event_bank;
	}

	public String getEvent_account() {
		return event_account;
	}

	public void setEvent_account(String event_account) {
		this.event_account = event_account;
	}

	public String getEvent_account_name() {
		return event_account_name;
	}

	public void setEvent_account_name(String event_account_name) {
		this.event_account_name = event_account_name;
	}

	public String getEvent_thumbnail() {
		return event_thumbnail;
	}

	public void setEvent_thumbnail(String event_thumbnail) {
		this.event_thumbnail = event_thumbnail;
	}

	public MultipartFile getPhoto() {
		return photo;
	}

	public void setPhoto(MultipartFile photo) {
		this.photo = photo;
	}

	public String getEvent_ticket_open() {
		return event_ticket_open;
	}

	public void setEvent_ticket_open(String event_ticket_open) {
		this.event_ticket_open = event_ticket_open;
	}

	public int getUser_idx() {
		return user_idx;
	}

	public void setUser_idx(int user_idx) {
		this.user_idx = user_idx;
	}

	public int getEvent_viewCount() {
		return event_viewCount;
	}

	public void setEvent_viewCount(int event_viewCount) {
		this.event_viewCount = event_viewCount;
	}

	public String getDelete_status() {
		return delete_status;
	}

	public void setDelete_status(String delete_status) {
		this.delete_status = delete_status;
	}

	public LocalDateTime getDelete_date() {
		return delete_date;
	}

	public void setDelete_date(LocalDateTime delete_date) {
		this.delete_date = delete_date;
	}

	public LocalDateTime getEvent_createdate() {
		return event_createdate;
	}

	public void setEvent_createdate(LocalDateTime event_createdate) {
		this.event_createdate = event_createdate;
	}

	// 날짜 데이터형식 변경
	public String getFormattedEventHStart() {
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy.MM.dd(EEE) HH:mm");
		return event_h_start.format(formatter);
	}

	public String getFormattedEventHEnd() {
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy.MM.dd(EEE) HH:mm");
		return event_h_end.format(formatter);
	}

	public String getFormattedEventRStart() {
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy.MM.dd(EEE) HH:mm");
		return event_r_start.format(formatter);
	}

	public String getFormattedEventREnd() {
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy.MM.dd(EEE) HH:mm");
		return event_r_end.format(formatter);
	}

	public String getFormattedEventCreateDate() {
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy.MM.dd(EEE) HH:mm");
		return event_createdate.format(formatter);
	}

	public String getFormattedDeleteDate() {
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy.MM.dd(EEE) HH:mm");
		return delete_date.format(formatter);
	}
}
