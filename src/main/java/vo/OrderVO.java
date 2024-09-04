package vo;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class OrderVO {
	private int order_idx, user_idx, event_idx, order_age;
	private String order_name, order_tel, order_email, order_addr, order_gen, cancel_status;
	private LocalDateTime order_date, cancel_date;

	// 조인된 필드
	private int event_sports_idx, event_price;
	private String event_name;
	private LocalDateTime event_h_start;
	private String event_addr;

	public int getOrder_idx() {
		return order_idx;
	}

	public void setOrder_idx(int order_idx) {
		this.order_idx = order_idx;
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

	public int getOrder_age() {
		return order_age;
	}

	public void setOrder_age(int order_age) {
		this.order_age = order_age;
	}

	public String getOrder_name() {
		return order_name;
	}

	public void setOrder_name(String order_name) {
		this.order_name = order_name;
	}

	public String getOrder_tel() {
		return order_tel;
	}

	public void setOrder_tel(String order_tel) {
		this.order_tel = order_tel;
	}

	public String getOrder_email() {
		return order_email;
	}

	public void setOrder_email(String order_email) {
		this.order_email = order_email;
	}

	public String getOrder_addr() {
		return order_addr;
	}

	public void setOrder_addr(String order_addr) {
		this.order_addr = order_addr;
	}

	public String getOrder_gen() {
		return order_gen;
	}

	public void setOrder_gen(String order_gen) {
		this.order_gen = order_gen;
	}

	public LocalDateTime getOrder_date() {
		return order_date;
	}

	public void setOrder_date(LocalDateTime order_date) {
		this.order_date = order_date;
	}


	public int getEvent_price() {
		return event_price;
	}

	public void setEvent_price(int event_price) {
		this.event_price = event_price;
	}

	public String getCancel_status() {
		return cancel_status;
	}

	public void setCancel_status(String cancel_status) {
		this.cancel_status = cancel_status;
	}

	public LocalDateTime getCancel_date() {
		return cancel_date;
	}

	public void setCancel_date(LocalDateTime cancel_date) {
		this.cancel_date = cancel_date;
	}


	// 조인된 gettter/setter

	public String getEvent_name() {
		return event_name;
	}

	public int getEvent_sports_idx() {
		return event_sports_idx;
	}

	public void setEvent_sports_idx(int event_sports_idx) {
		this.event_sports_idx = event_sports_idx;
	}

	public void setEvent_name(String event_name) {
		this.event_name = event_name;
	}

	public LocalDateTime getEvent_h_start() {
		return event_h_start;
	}

	public void setEvent_h_start(LocalDateTime event_h_start) {
		this.event_h_start = event_h_start;
	}

	public String getEvent_addr() {
		return event_addr;
	}

	public void setEvent_addr(String event_addr) {
		this.event_addr = event_addr;
	}

	
	//날짜데이터 형식 변경
	public String getFormattedOrderDate() {
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy.MM.dd(EEE) HH:mm");
		return order_date.format(formatter);
	}
	
	public String getFormattedCancelDate() {
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy.MM.dd(EEE) HH:mm");
		return cancel_date.format(formatter);
	}
	
	public String getFormattedEventHStart() {
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy.MM.dd(EEE) HH:mm");
		return event_h_start.format(formatter);
	}

}
