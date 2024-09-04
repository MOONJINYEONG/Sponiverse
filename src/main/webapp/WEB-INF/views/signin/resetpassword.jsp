<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
	<html>
	<head>
		<meta charset="UTF-8">
		<title>비밀번호 재설정</title>
		
		<link rel="stylesheet" href="/getspo/resources/css/signin/resetpassword.css">
		
		<script>
			function reset_pwd(f){
				let new_pwd = f.user_pwd.value;
				let confirm_pwd = f.confirm_password.value;
				//유효성 검사
				let pwdpattern = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()_+\-=[\]{}|;:',.<>/?]).{8,15}$/;
				if(new_pwd === '' || !pwdpattern.test(new_pwd)){
		              newpwdWarning.textContent = "올바르지 않은 비밀번호입니다."
		              document.getElementById('user_pwd').classList.add('warning');
		               return;               
		            }else{
		               newpwdWarning.textContent = ""; //경고 메세지 초기화
		               document.getElementById('user_pwd').classList.remove('warning');
		            }
				
				if(new_pwd !== confirm_pwd){
					 confirmpwdWarning.textContent = "비밀번호가 같지 않습니다"
			         document.getElementById('confirm_password').classList.add('warning');
			         return;  
				}else{
					confirmpwdWarning.textContent = ""; //경고 메세지 초기화
		            document.getElementById('confirm_password').classList.remove('warning');
				}
				
				
				f.method = "post";
				f.action = "changepwd.do";
				f.submit();
			}
			
			// 페이지 로드 시 메시지를 확인하고 알림 창을 표시
	        document.addEventListener('DOMContentLoaded', function() {
	            const message = "${message}";
	            if (message) {
	                alert(message);
	            }
	        });
			
		</script>
				
	</head>
	<body>
		<div class="container">
	        <div class="form-wrapper">
	            <h2>비밀번호 재설정</h2>
	            <form>
	             	<input type="hidden" name="token" value="${token}">
	                <div class="input-group">
	                    <label for="user_pwd">새 비밀번호</label>
	                    <input type="password" id="user_pwd" name="user_pwd" placeholder="새 비밀번호를 입력하세요" required>
	                    <span id="newpwdWarning"></span>
	                </div>
	                <div class="input-group">
	                    <label for="confirm_password">비밀번호 확인</label>
	                    <input type="password" id="confirm_password" name="confirm_password" placeholder="비밀번호를 다시 입력하세요" required>
	                    <span id="confirmpwdWarning"></span>
	                </div>
	                <input type="button" value="비밀번호 설정하기" onclick="reset_pwd(this.form);">
	            </form>
	        </div>
	    </div>
	</body>
</html>