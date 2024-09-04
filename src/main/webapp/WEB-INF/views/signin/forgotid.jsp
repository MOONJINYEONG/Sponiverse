<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<!DOCTYPE html>
<html>
   <head>
      <meta charset="UTF-8">
      <title>ID 찾기</title>
      
      <link rel="stylesheet" href="/getspo/resources/css/signin/forgotid.css">
      
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
          let nameInput = document.getElementById('user_name');
          let emailInput = document.getElementById('user_email');

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
      
      	function findId(f){
      		let name = f.user_name.value;
      		let email = f.user_email.value;
      		
      		//유효성검사
      		//이름
      		let nameptn = /^[가-힣]{2,5}$/;
      		//이메일
      		let emailptn = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
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
      		
      		let url = "findid.do";
      		let param = "name="+ encodeURIComponent(name) + "&email=" + encodeURIComponent(email);
      		
      		sendRequest(url, param, resultFn, "POST");      		
      	}
      	
      	function resultFn(){
			if(xhr.readyState == 4 && xhr.status == 200){
				let data = xhr.responseText;
				let json = JSON.parse(data);
				if(json[0].result === "no_name"){
					alert("아이디가 존재하지 않습니다");
				}else if(json[0].result === "no_email"){
					alert("이메일이 일치하지 않습니다");
				}else if(json[0].result === "clear"){
					document.getElementById('modal-body').textContent = "찾은 아이디: " + json[0].user_id;
	                document.getElementById('modal').style.display = "block";
				}else{
					alert("알수없는 오류");
				}
			
							
			}
		}
      	
     	// 모달 닫기 기능 추가
      	document.addEventListener("DOMContentLoaded", function() {
      	    document.querySelector(".close").addEventListener("click", function() {
      	        document.getElementById("modal").style.display = "none";
      	    });

      	    window.addEventListener("click", function(event) {
      	        if (event.target == document.getElementById("modal")) {
      	            document.getElementById("modal").style.display = "none";
      	        }
      	    });
      	});
      	
      </script>
            
   </head>
   
   <body>
      <form>
           <div class="forgot_id">
               <div class="header">
                   <h3>ID 찾기</h3>
                   <p id="comment">이름과 이메일을 입력해주세요</p>
                   
                   <div class="form-group">
	                   <p>이름</p>
	                   <input placeholder="이름을 입력하세요" name="user_name" id="user_name" type="text" required>
	                   <span id="nameWarning"></span>
                   </div>
                   
                   <div class="form-group">
	                   <p>이메일</p>
	                   <input placeholder="메일을 입력하세요" name="user_email" id="user_email" type="text" required>
	                   <span id="emailWarning"></span>
                   </div>
                   
                   <input class="find_id" type="button" value="ID 찾기" onclick="findId(this.form);">
               </div>
                 
               <hr>
               
              <a href="javascript:" onclick="location.href='main.do'">
                     <img src="/getspo/resources/img/logo/가로로고.png">
              </a>
           </div>
          </form>
          
          <!-- 모달  -->
          <div id="modal" class="modal">
			    <div class="modal-content">
			        <span class="close">&times;</span>  <!-- 닫기 버튼 &times은 x뜻함 -->
			        <p id="modal-body"></p>
			        <button class="modal-button" onclick="location.href='forgotpassword.do'">비밀번호 찾기</button>
			    </div>
			</div>
          
   </body>
</html>












