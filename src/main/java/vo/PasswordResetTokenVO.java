package vo;

import java.time.LocalDateTime;
import java.util.Date;

public class PasswordResetTokenVO {
	private String token, user_id;
	private LocalDateTime created_at;
			
	public String getToken() {
		return token;
	}
	public void setToken(String token) {
		this.token = token;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public LocalDateTime getCreated_at() {
		return created_at;
	}
	public void setCreated_at(LocalDateTime created_at) {
		this.created_at = created_at;
	}
	
}