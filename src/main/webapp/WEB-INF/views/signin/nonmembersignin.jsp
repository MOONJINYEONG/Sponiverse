<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8"> 
		<title>로그인</title>
		
		<!-- signin css -->
		<link rel="stylesheet" href="/getspo/resources/css/signin.css">
		
		<style>
		#comment {
			color: gray;
			margin: 10px auto;
		}

		</style>
	
	</head>
	
	<body>
		<form>
			<div class="login_page">
	
				<div class=logo_text>
					<a href="javascript:" onclick="location.href='main.do'"> <img
						src="/getspo/resources/img/logo/가로로고.png">
					</a>
					<h2>비회원 신청 조회</h2>
				</div>
	
				<br>
				<br>
	
				<div class="login_input">
					<p>이메일(ID)</p>
					<input class="email_box" placeholder="이메일을 입력하세요" name="email"
						type="text"> <br> <br>
	
					<p>인증코드</p>
					<input class="pwd_box" placeholder="비밀번호를 입력하세요" name="pwd"
						type="password">
				</div>

				<div class="login_tool">
					<a href="javascript:" onclick="location.href='forgotcode.do'">인증코드
						찾기</a>
				</div>
	
				<input class="login_btn" type="button" value="신청조회" onclick="()">
	
				<br>
				<hr>
				<br>
	
				<p id="comment">회원가입을 하면 더욱 편하게 즐길 수 있어요!</p>
	
				<br> <input class="signup_btn" type="button" value="회원가입"
					onclick="location.href='signupform.do'">
	
			</div>
	
			
		</form>
	</body>
</html>