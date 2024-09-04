<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
   <head>
   <meta charset="UTF-8"> 
   <title>로그인</title>
      
      <!-- signin css -->
      <link rel="stylesheet" href="/getspo/resources/css/signin/signin.css">
      
      <!-- 폰트 설정 -->
      <link rel="preconnect" href="https://fonts.googleapis.com">
      <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
      <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap"
         rel="stylesheet">
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
     
      /* Warning 칸 */
      function addInputListeners() {
          let idInput = document.getElementById('user_id');
          let pwdInput = document.getElementById('user_pwd');

          idInput.addEventListener('input', function() {
              validateInput(idInput, /^[a-z][a-z0-9]{5,19}$/, document.getElementById('idWarning'), "올바른 아이디를 입력하세요");
          });

          pwdInput.addEventListener('input', function() {
              validateInput(pwdInput, /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()_+\-=[\]{}|;:',.<>/?]).{8,15}$/, document.getElementById('pwdWarning'), "올바른 비밀번호를 입력하세요");
          });

      }

      document.addEventListener('DOMContentLoaded', function() {
          addInputListeners();
          

          // 엔터 키 이벤트 리스너 추가
          document.getElementById('user_id').addEventListener('keydown', function(event) {
              if (event.key === 'Enter') {
                  event.preventDefault(); // 폼 제출 방지
                  document.querySelector('.login_btn').click(); // 로그인 버튼 클릭
              }
          });

          document.getElementById('user_pwd').addEventListener('keydown', function(event) {
              if (event.key === 'Enter') {
                  event.preventDefault(); // 폼 제출 방지
                  document.querySelector('.login_btn').click(); // 로그인 버튼 클릭
              }
          });
          
      });
      
      /* Warning 메세지 */
         function validateId(f){
            let id = f.user_id.value;
            let pwd = f.user_pwd.value;
            
            console.log("id = " + id);
            console.log("pwd = " + pwd);
            
            //유효성검사
            let idpattern = /^[a-z][a-z0-9]{5,19}$/;
            let pwdpattern = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()_+\-=[\]{}|;:',.<>/?]).{8,15}$/;
            
            if(id == '' || !idpattern.test(id)){
               idWarning.textContent = "올바르지 않은 아이디입니다."
               document.getElementById('user_id').classList.add('warning');
               return;               
            }else{
               idWarning.textContent = ""; //경고 메세지 초기화
               document.getElementById('user_id').classList.remove('warning');
            }
               
            
         
            if(pwd == '' || !pwdpattern.test(pwd)){
              pwdWarning.textContent = "올바르지 않은 비밀번호입니다."
              document.getElementById('user_pwd').classList.add('warning');
               return;               
            }else{
               pwdWarning.textContent = ""; //경고 메세지 초기화
               document.getElementById('user_pwd').classList.remove('warning');
            }
              
           
            
            let url = "login.do";
            let param = "id=" + id + "&pwd=" + encodeURIComponent(pwd);
            
            sendRequest(url, param, resultLog, "POST");           
         }
         
         function resultLog(){
            if(xhr.readyState == 4 && xhr.status == 200){
                let data = xhr.responseText;
                if (data === 'no_id') {
                    alert("아이디가 존재하지 않습니다");    
                } else if(data === 'no_pwd'){
                    alert("비밀번호가 일치하지 않습니다");
                } else if(data === 'clear'){
                    location.href = "main.do";
                } else {
                    alert("로그인 실패");
                }
            }
         }
         
         //비밀번호재설정 시 알림메세지
         document.addEventListener('DOMContentLoaded', function() {
             const message = "${message}";
             if (message) {
                 alert(message);
             }
         });
      </script>
      
      
   </head>
   
   <body>
      <form action="login.do" method="post">
      <div class="login_page">
      
         <div class=logo_text>
            <a href="javascript:" onclick="location.href='main.do'">
               <img src="/getspo/resources/img/logo/가로로고.png">
            </a>
            <h2>다시 만나서 반가워요!</h2> 
         </div>
         
         <br><br>
         
         <div class="login_input">
            <p>아이디(ID)</p>
            <input class="id_box" placeholder="아이디를 입력하세요" name="user_id" id="user_id" type="text" required>
            <span id="idWarning"></span>
            <br>
            <br>
            
            <p>비밀번호</p>
            <input class="pwd_box" placeholder="비밀번호를 입력하세요" name="user_pwd" id="user_pwd" type="password" required>
            <span id="pwdWarning"></span>
         </div>
         
         <div class="login_tool">
            <input type="checkbox" id="keep_login" name="keep_login" value="로그인 유지"> 로그인 유지
              <a href="javascript:" onclick="location.href='forgotid.do'">아이디(ID) 찾기</a>
              <a href="javascript:" onclick="location.href='forgotpassword.do'">비밀번호 찾기</a>
         </div>
      
            <input class="login_btn" type="button" value="로그인" onclick="validateId(this.form);">
            <input class="signup_btn" type="button" value="회원가입" onclick="location.href='signupform.do'">
         
         <!--  비회원 신청 조회 보류 (주석처리만 풀면 사용 가능)
         <br>
         <br>
         <br>
         
         <div>
            <hr>
            
            <br>
               
            <a class="nonmember" href="javascript:" onclick="location.href='nonmemberconfirm.do'">비회원 신청 조회</a>
         </div>
         -->
      </div>
      
      </form>
   </body>
</html>