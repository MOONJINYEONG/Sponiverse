package com.kh.getspo;

import java.time.LocalDateTime;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import dao.PasswordResetTokenDAO;
import dao.UserDAO;
import service.MailSendService;
import util.Common;
import vo.PasswordResetTokenVO;
import vo.UserVO;

@Controller
public class UserController {

	@Autowired
	HttpServletRequest request;
	@Autowired
	HttpSession session;

	MailSendService mss;

	@Autowired
	UserDAO user_dao;

	@Autowired
	PasswordResetTokenDAO passwordreset_dao;

	public UserController(MailSendService mss, UserDAO user_dao, PasswordResetTokenDAO passwordreset_dao) {
		this.mss = mss;
		this.user_dao = user_dao;
		this.passwordreset_dao = passwordreset_dao;
	}

	// 로그인페이지이동
	@RequestMapping("/signinform.do")
	public String sign_form() {
		return Common.Sign.VIEW_PATH + "signinform.jsp";
	}

	// 비회원페이지이동
	@RequestMapping("/nonmemberconfirm.do")
	public String nonmem_form() {
		return Common.Sign.VIEW_PATH + "nonmembersignin.jsp";
	}

	// 회원가입폼
	@RequestMapping("/signupform.do")
	public String signUpForm() {
		return Common.Sign.VIEW_PATH + "signupform.jsp";
	}

	// 아이디 찾기 폼
	@RequestMapping("/forgotid.do")
	public String forgotId() {
		return Common.Sign.VIEW_PATH + "forgotid.jsp";
	}

	// 아이디 찾기
	@RequestMapping("/findid.do")
	@ResponseBody
	public String forgotId(@RequestParam String name, @RequestParam String email) {
		UserVO vo = new UserVO();
		vo.setUser_name(name);
		vo.setUser_email(email);

		String result = "";
		String resultStr = "";

		UserVO res = user_dao.findUserId(vo);
		if (res == null) { // 이름이 없을 시
			result = "no_name";
			resultStr = String.format("[{\"result\":\"%s\"}]", result);
			return resultStr;
		} else if (!res.getUser_email().equals(vo.getUser_email())) { // 이메일 틀릴 시
			result = "no_email";
			resultStr = String.format("[{\"result\":\"%s\"}]", result);
			return resultStr;
		} else {
			result = "clear";
			resultStr = String.format("[{\"result\":\"%s\", \"user_id\":\"%s\"}]", result, res.getUser_id());
		}

		return resultStr;
	}

	// 비밀번호 찾기 폼
	@RequestMapping("/forgotpassword.do")
	public String forgotPassword() {
		return Common.Sign.VIEW_PATH + "forgotpassword.jsp";
	}

	// 비번재설정링크 이메일
	@RequestMapping("/sendRestEmail.do")
	@ResponseBody
	public String sendResetEmail(@RequestParam String id, @RequestParam String name, @RequestParam String email) {
		UserVO vo = new UserVO();
		vo.setUser_id(id);
		vo.setUser_name(name);
		vo.setUser_email(email);

		String result = "";

		UserVO user = user_dao.findUser(vo);
		if (user == null) {
			result = "no_user";
		} else if (!user.getUser_email().equals(vo.getUser_email())) { // 이메일 틀릴시
			result = "no_email";
		} else if (!user.getUser_id().equals(vo.getUser_id())) { // 아이디 틀릴시
			result = "no_id";
		} else if (!user.getUser_name().equals(vo.getUser_name())) { // 이름 틀릴시
			result = "no_name";
		} else {
			// 토큰 생성 및 저장
			String token = UUID.randomUUID().toString();
			PasswordResetTokenVO tokenVO = new PasswordResetTokenVO();
			tokenVO.setToken(token);
			tokenVO.setUser_id(user.getUser_id());
			tokenVO.setCreated_at(LocalDateTime.now()); // 토큰 생성 시간 설정

			passwordreset_dao.insertToken(tokenVO); // 생성된 토큰을 DB에 저장

			mss.resetPwdEmail(user, tokenVO); // 이메일 방송 시 유저정보, 토큰 포함
			result = "clear";
		}

		String resultStr = String.format("[{\"result\":\"%s\"}]", result);
		return resultStr;

	}

	// 비번재설정 폼
	@RequestMapping("/resetPwd_form.do")
	public String resetPwd_form(@RequestParam("token") String token, Model model) {

		// 토큰 검증
		PasswordResetTokenVO tokenVO = passwordreset_dao.findByToken(token);

		// 토큰이 유효하지 않거나 만료된 경우 에러 페이지로 리다이렉트
		if (tokenVO == null || tokenVO.getCreated_at().plusMinutes(5).isBefore(LocalDateTime.now())) {
			model.addAttribute("message", "유효하지 않거나 만료된 토큰입니다.");
			return "errorPage.do";
		}

		model.addAttribute("token", token);
		return Common.Sign.VIEW_PATH + "resetpassword.jsp";
	}

	// 비밀번호 업데이트
	@RequestMapping("/changepwd.do")
	public String update_pwd(Model model, @RequestParam String token, @RequestParam String user_pwd) {
		// 토큰 검증
		PasswordResetTokenVO tokenVO = passwordreset_dao.findByToken(token);
		if (tokenVO == null || tokenVO.getCreated_at().plusMinutes(5).isBefore(LocalDateTime.now())) {
			model.addAttribute("message", "유효하지 않거나 만료된 토큰입니다.");
			return "errorpage.do"; // 토큰이 유효하지 않거나 만료된 경우
		}

		// 비밀번호 업데이트
		// 비밀번호 암호화를 위한 클래스 호출
		String encodePwd = Common.SecurePwd.encodePwd(user_pwd);

		UserVO user = new UserVO();
		user.setUser_id(tokenVO.getUser_id());
		user.setUser_pwd(encodePwd);

		int result = user_dao.updatePassword(user);

		if (result > 0) {
			// 토큰 삭제
			passwordreset_dao.deleteByToken(token);
			model.addAttribute("message", "비밀번호가 성공적으로 변경되었습니다.");
			return "signinform.do"; // 비밀번호 변경 후 로그인 페이지로 이동
		} else {
			model.addAttribute("message", "비밀번호 변경에 실패했습니다.");
			return "resetPwd_form.do"; // 비밀번호 변경 실패 시 다시 비밀번호 재설정 페이지로 이동
		}
	}

	// 에러페이지(비번 재설정 토큰만료시)
	@RequestMapping("/errorpage.do")
	public String errorpage() {
		return Common.Sign.VIEW_PATH + "errorPage.jsp";
	}

	// Ajax로 요청받은 인증처리 메서드
	@RequestMapping("/mailCheck.do")
	@ResponseBody
	public String mailCheck(String email) {
		System.out.println("인증요청 받음 : " + email);
		String res = mss.joinEmail(email);
		return res;
	}

	// 아이디중복체크
	@RequestMapping("checkDuplicate.do")
	@ResponseBody
	public String dualid(String id) {
		System.out.println("id: " + id);
		String result = user_dao.selectId(id);
		String res = "";
		if (result != null) {
			res = "true"; // 아이디가 이미 존재할 경우
		} else {
			res = "false"; // 아이디가 존재하지 않을 경우
		}
		return res;
	}

	// 회원가입
	@RequestMapping("signupInsert.do")
	public String signupInsert(UserVO vo) {

		// 비밀번호 암호화를 위한 클래스 호출
		String encodePwd = Common.SecurePwd.encodePwd(vo.getUser_pwd());
		vo.setUser_pwd(encodePwd); // 암호화된 비밀번호로 vo객체 갱신

		user_dao.userInsert(vo);
		return "redirect:signinform.do";
	}

	// 로그인
	@RequestMapping("/login.do")
	@ResponseBody
	public String loginUser(@RequestParam String id, @RequestParam String pwd) {

		UserVO user = user_dao.userlogin(id);

		String res = "";

		// 아이디가 없을 시
		if (user == null) {
			res = "no_id";
			return res;
		}
		// 비밀번호가 틀릴 시
		if (!Common.SecurePwd.isPwdMatch(pwd, user.getUser_pwd())) {
			res = "no_pwd";
			return res;
		}

		// 아이디와 비밀번호가 문제 없다면 세션에 vo객체 저장
		// 로그인 성공 시 세션에 사용자 정보 저장
		session.setAttribute("user", user);

		// 로그인 성공
		res = "clear";
		return res;

	}

	// 로그아웃
	@RequestMapping("/logout.do")
	public String userlogout() {
		session.removeAttribute("user");
		return "redirect:main.do";
	}

	// 유저 정보 수정
	@RequestMapping("/userinfo_modify.do")
	@ResponseBody
	public String modify(UserVO vo) {

		// db에 존재하는 실제 비번을 복호화해서 입력된 값과 비교
		boolean isValid = Common.SecurePwd.decodePwd(vo, user_dao);

		if (isValid) {// 복호화된 비번이 일치될 경우 정보 수정 진행 ㄱㄱ

			// 비밀번호 다시 암호화해서 vo에 담기
			String encodePwd = Common.SecurePwd.encodePwd(vo.getUser_pwd());
			vo.setUser_pwd(encodePwd);

			int res = user_dao.update_userInfo(vo);

			if (res > 0) {
				return "[{'result':'clear'}]";// 수정 성공시 돌아갈 콜백메시지
			} else {
				return "[{'result':'fail'}]";// 수정 실패시 돌아갈 콜백메시지
			}

		} else {// 복호화된 비번이 틀릴 경우 정보 수정 진행 ㄴㄴ
			return "[{'result':'wrong'}]";// 비밀번호 틀리면 돌아갈 콜백메시지
		}

	}

	// 회원탈퇴(DB삭제)
	@RequestMapping("delete.do")
	@ResponseBody
	public String delete(UserVO vo) {
		// 복호화
		boolean isValid = Common.SecurePwd.decodePwd(vo, user_dao);

		if (isValid) {
			int res_del = user_dao.delete(vo.getUser_idx());
			session.removeAttribute("user");
			if (res_del > 0) {
				return "[{'result':'clear'}]";// 삭제 성공
			} else {
				return "[{'result':'fail'}]";// 삭제 실패
			}

		} else {
			return "[{'result':'no'}]";// 비밀번호 틀림
		}
	}

}
