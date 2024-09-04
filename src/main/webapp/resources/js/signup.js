document.addEventListener("DOMContentLoaded", function() {
	            const authenticateBtn = document.querySelector(".btn-authenticate");
	            const verificationGroup = document.getElementById("verificationGroup");
	            
	
	            authenticateBtn.addEventListener("click", function() {
	            	let pattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
	            	let emailInput = document.getElementById("user_email");	
	            	
		                    	
	            	if(!pattern.test(emailInput.value)){
	            		alert("올바른 이메일주소를 입력하세요");
	            		return;	
	            	}
	            	            	
	            	verificationGroup.classList.add("show");
            		let userEmail = emailInput.value;
    				let url = "mailCheck.do";
    				let param = "email="+ encodeURIComponent(userEmail);
    				sendRequest(url, param, resultMail, "post");		                               
	            });
	            	             
	            let res;
				function resultMail(){
					if(xhr.readyState == 4 && xhr.status == 200){
						let data = xhr.responseText;
						alert("인증코드가 입력하신 이메일로 전송 되었습니다");
						//전역변수 res에 넘겨받은 인증번호를 담는다
						res = data;
					}
				}
				      
	            const verifyBtn = document.querySelector(".btn-verify");
	
	            verifyBtn.addEventListener("click", function() {
	            	let check_input = document.getElementById("verificationCode");
	            	let email_input = document.getElementById("user_email");
	                // 여기에 실제 인증번호 확인 로직을 추가하면 됩니다.
	            	if( check_input.value == res ){
						alert("인증되었습니다");
					}else{
						alert("인증번호 불일치");
						return;
					}
	            });
	        }); 
	        
	        function checkDul(){
	        	let id = document.getElementById("user_id");
	        	
				//유효성 검사
				//아이디
				//알파벳 소문자로 시작하고, 그 다음에는 알파벳 소문자나 숫자가 6자에서 20자까지
				let idpattern = /^[a-z][a-z0-9]{5,19}$/;
				if(!idpattern.test(id.value)){
					idWarning.textContent = "6~20자의 영문 소문자와 숫자만 사용 가능합니다"
					return;					
				}else{
					idWarning.textContent = ""; //경고 메세지 초기화
				}
				
			    let url = "checkDuplicate.do"; // 서버의 확인 URL
         	    let param = "id=" + id.value;
            	sendRequest(url, param, dupId, "post");				        	
	        } 
	        function dupId(){
	        	let id = document.getElementById("user_id");
            	if(xhr.readyState == 4 && xhr.status == 200){
            		let data = xhr.responseText;
            		if (data === "true") {
            	           alert("이미 사용 중인 아이디입니다.");
            	           // 사용자가 이미 사용 중인 아이디임을 알리는 추가적인 처리
            	           return;
            	       } else {
            	           alert("사용할 수 있는 아이디입니다.");
            	           // 사용자가 없어 사용할 수 있는 아이디
            	           // id.readOnly = true 쓰기불가능            	           
            	    }
            	}
            }
            
            function send(f){
				let email = f.user_email.value;
				let pwd = f.user_pwd.value;
				let name = f.user_name.value;
				let birth = f.user_birth.value;
				let tel = f.user_tel.value;
				let addr = f.user_addr.value;
				
				
				//유효성 검사
				
				//아이디
				//알파벳 소문자로 시작하고, 그 다음에는 알파벳 소문자나 숫자가 6자에서 20자까지
				let idpattern = /^[a-z][a-z0-9]{5,19}$/;
				if(!idpattern.test(id.value)){
					idWarning.textContent = "6~20자의 영문 소문자와 숫자만 사용 가능합니다"
					return;					
				}else{
					idWarning.textContent = ""; //경고 메세지 초기화
				}
												
				// 비밀번호
				// 최소 8자 이상, 최대 15자 이하, 영문 대소문자 포함, 숫자, 특수문자 포함
			    let pattern = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()_+\-=[\]{}|;:',.<>/?]).{8,15}$/;			
				if(!pattern.test(pwd)) {
			            passwordWarning.textContent = "띄어쓰기 없는 8~15자의 영문 대/소문자 숫자 및 특수문자 조합으로 입력";
			            return;
			        } else {
			            passwordWarning.textContent = ""; // 경고 메시지 초기화
			        }
				
				// 전화번호
				let telpattern = /\d{3}-\d{4}-\d{4}/;
				if(!telpattern.test(tel)) {
		            telWarning.textContent = "올바른 전화번호를 입력하세요";
		            return;
		        } else {
		            telWarning.textContent = ""; // 경고 메시지 초기화
		        }
				
				f.method="post";
				f.action = "signupInsert.do";
				f.submit();
			}
		    function sample6_execDaumPostcode() {
		        new daum.Postcode({
		            oncomplete: function(data) {
		                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

		                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
		                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
		                var addr = ''; // 주소 변수
		                var extraAddr = ''; // 참고항목 변수

		                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
		                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
		                    addr = data.roadAddress;
		                } else { // 사용자가 지번 주소를 선택했을 경우(J)
		                    addr = data.jibunAddress;
		                }

		                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
		                if(data.userSelectedType === 'R'){
		                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
		                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
		                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
		                        extraAddr += data.bname;
		                    }
		                    // 건물명이 있고, 공동주택일 경우 추가한다.
		                    if(data.buildingName !== '' && data.apartment === 'Y'){
		                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
		                    }
		                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
		                    if(extraAddr !== ''){
		                        extraAddr = ' (' + extraAddr + ')';
		                    }
		                    // 조합된 참고항목을 해당 필드에 넣는다.
		                    document.getElementById("user_addrdetail").value = extraAddr;
		                
		                } else {
		                    document.getElementById("user_addrdetail").value = '';
		                }

		                // 우편번호와 주소 정보를 해당 필드에 넣는다.
		                document.getElementById('user_addrcode').value = data.zonecode;
		                document.getElementById("user_addr").value = addr;
		                // 커서를 상세주소 필드로 이동한다.
		                document.getElementById("user_addrdetail").focus();
		            }
 	}).open();
 }
 