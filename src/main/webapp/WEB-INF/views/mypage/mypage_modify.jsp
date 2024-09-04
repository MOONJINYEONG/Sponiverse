<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Mypage_modify</title>

<script>
	//회원정보 수정
	function modify(f) {
	   let user_idx = f.user_idx.value;
	   let input_pwd = f.input_pwd.value;//입력받은 비밀번호


		let url = "userinfo_modify.do";
		let param = "user_idx=" + user_idx 
					+ "&user_name="+ f.user_name.value 
					+ "&user_pwd=" + encodeURIComponent(input_pwd)
					+ "&user_tel=" + f.user_tel.value 
					+ "&user_email=" + f.user_email.value 
					+ "&user_birth=" + f.user_birth.value 
					+ "&user_addrcode=" + f.user_addrcode.value 
					+ "&user_addr=" + f.user_addr.value
					+ "&user_addrdetail=" + f.user_addrdetail.value;

		sendRequest(url, param, resultFn, "post");
	}
	
	  function resultFn() {
	      if (xhr.readyState == 4 && xhr.status == 200) {
	         
	         let data = xhr.responseText;
	         let json = (new Function('return ' + data))();

	         if (json[0].result == 'wrong') {
	            alert("비밀번호 불일치");
	            return;
	         } else if (json[0].result == 'fail') {
	            alert("수정실패");
	            return;
	         } else {
	            alert("수정완료");
	            location.href = 'mypageform.do?user_idx=${vo.user_idx}&menu=link1';
	         }

	      }
	   }
</script>

</head>

<body>
	<div class="content_modify">
		<h2>내 정보 수정</h2>
		<div class="information">
			<form>
				<input type="hidden" name="user_idx" value="${vo.user_idx}">
				
				<h4>ID</h4>
				<p id="user_id" name="user_id" class="inp">${vo.user_id}</p>
				
				<h4>이름</h4>
				<input type="text" id="user_name" name="user_name" class="inp" value="${vo.user_name}" required>

				<h4>전화번호</h4>
				<input type="tel" id="user_tel" name="user_tel" class="inp" value="${vo.user_tel}" required>
				
				<h4>이메일</h4>
				<input type="text" id="user_email" name="user_email" class="inp" value="${vo.user_email}" required>
				
				<h4>생년월일</h4>
				<input type="date" id="user_birth" name="user_birth" class="inp" value="${vo.user_birth}" required>

				<h4>주소
					<input type="button" id="find_btn" class="btn" value="찾기" onclick="sample6_execDaumPostcode()">
				</h4>
				<div class="addr_group">
					<br>
					<input type="text" id="user_addrcode" name="user_addrcode" class="addrinp" value="${vo.user_addrcode}">
					<br>
					<input type="text" id="user_addr" name="user_addr" class="addrinp" value="${vo.user_addr}">
					<br>
					<input type="text" id="user_addrdetail" name="user_addrdetail" class="addrinp" value="${vo.user_addrdetail}">
				</div>

				<h4>수정을 위한 비밀번호 입력</h4>
            	<input type="password" id="input_pwd" name="input_pwd" class="inp" required>
				
				<div class="last_btn_div">
					<input type="button" id="cancel_btn" value="취소" onclick="location.href='mypageform.do?user_idx=${vo.user_idx}'">
					<input type="button" id="ok_btn" value="완료" onclick="modify(this.form);">
				</div>
			</form>
		</div>
	</div>
</body>
</html>