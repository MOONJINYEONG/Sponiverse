<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html> 
	<head>
		<meta charset="UTF-8">
		<title>비밀번호 찾기</title>
		
		<!-- css -->
		<link rel="stylesheet" href="/getspo/resources/css/signin/forgotpassword.css">
		
		<!-- Ajax -->
      	<script src="/getspo/resources/js/httpRequest.js"></script>
      	
      	<script>
	      	function validateInput(input, pattern, warningElement, warningMessage) {
	            if (!pattern.test(input.value)) {
	                warningElement.textContent = warningMessage;
	                input.classList.add('warning');
	            } else {
	                warningElement.textContent = "";
	                input.classList.remove('warning');
	            }
	        }
	
	        function addInputListeners() {
	            let idInput = document.getElementById('user_id');
	            let nameInput = document.getElementById('user_name');
	            let emailInput = document.getElementById('user_email');
	
	            idInput.addEventListener('input', function() {
	                validateInput(idInput, /^[a-z][a-z0-9]{5,19}$/, document.getElementById('idWarning'), "6~20자의 영문 소문자와 숫자만 사용 가능합니다");
	            });
	
	            nameInput.addEventListener('input', function() {
	                validateInput(nameInput, /^[가-힣]{2,5}$/, document.getElementById('nameWarning'), "올바른 이름을 입력하세요");
	            });
	
	            emailInput.addEventListener('input', function() {
	                validateInput(emailInput, /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/, document.getElementById('emailWarning'), "이메일 형식에 맞지 않습니다");
	            });
	        }
	
	        document.addEventListener('DOMContentLoaded', function() {
	            addInputListeners();
	        });
      	
      		function send(f){
      			let id = f.user_id.value;
      			let name = f.user_name.value;
      			let email = f.user_email.value;    
      			
      			//유효성 검사				
				//아이디
				let idpattern = /^[a-z][a-z0-9]{5,19}$/;
      			//이름
          		let nameptn = /^[가-힣]{2,5}$/;
          		//이메일
          		let emailptn = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
								
				if(!idpattern.test(id) || id == ''){
					idWarning.textContent = "6~20자의 영문 소문자와 숫자만 사용 가능합니다"
					document.getElementById('user_id').classList.add('warning');
					return;					
				}else{
					idWarning.textContent = ""; //경고 메세지 초기화
					document.getElementById('user_id').classList.remove('warning');
				}
          		
          		if(!nameptn.test(name) || name == ''){
          			nameWarning.textContent = "올바른 이름을 입력하세요";
          			document.getElementById('user_name').classList.add('warning');
    				return;					
    				}else{
    					nameWarning.textContent = ""; //경고 메세지 초기화
    					document.getElementById('user_name').classList.remove('warning');
    			}
          		
          		if(!emailptn.test(email) || email == ''){
          			emailWarning.textContent = "이메일 형식에 맞지 않습니다";
          			document.getElementById('user_email').classList.add('warning');
    				return;					
    				}else{
    					emailWarning.textContent = ""; //경고 메세지 초기화
    					document.getElementById('user_email').classList.remove('warning');
    			}
      			
          		
      			let url = "sendRestEmail.do";
      			let param = "id=" + encodeURIComponent(id) + "&name=" + encodeURIComponent(name) + "&email=" + encodeURIComponent(email);
      			
      			sendRequest(url, param, resultFn, "POST");
      			
      		}
      		
      		function resultFn(){
      			if(xhr.readyState == 4 && xhr.status == 200){
      				let data = xhr.responseText;
      				let json = JSON.parse(data);
      				if(json[0].result === "no_name") {
      	                alert("이름이 일치하지 않습니다");
      	            } else if(json[0].result === "no_email") {
      	                alert("이메일이 일치하지 않습니다");
      	            } else if(json[0].result === "no_id") {
      	                alert("아이디가 일치하지 않습니다");
      	            } else if(json[0].result === "clear") {
      	                alert("비밀번호 재설정 이메일 발송");
      	                location.href = "signinform.do";
      	            } else{
      	                alert("유저정보가 없습니다");
      	            }
      				      				
      			}
      		}
      		
      	</script>
      	
		
	</head>
	
	<body>
		<form>
			<div class="forgot_pwd">
				<div class="header">
					<h3>비밀번호 찾기</h3>
					<p id="comment">가입하신 이메일로 비밀번호 재설정 URL을 전송해드립니다</p>
					<br>
					
					<div class="form-group">
					<p>아이디(ID)</p>
					<input placeholder="아이디를 입력하세요" id="user_id" name="user_id" type="text">
					<span id="idWarning"></span>
					</div>
					
					
					<div class="form-group">
					<p>이름</p>
					<input placeholder="이름을 입력하세요" id="user_name" name="user_name" type="text">
					<span id="nameWarning"></span>
					</div>
					
									
					<div class="form-group">
					<p>이메일</p>
					<input placeholder="이메일을 입력하세요" id="user_email" name="user_email" type="text">
					<span id="emailWarning"></span>
					</div>
					
					<br>
					<input class="reset_pwd" type="button" value="재설정 메일 받기" onclick="send(this.form);">
				</div>
	
				<hr>
				
				<a href="javascript:" onclick="location.href='main.do'">
					<img src="/getspo/resources/img/logo/가로로고.png">
				</a>					
			</div>
		</form>
	</body>
</html>