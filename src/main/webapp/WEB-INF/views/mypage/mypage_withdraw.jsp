<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
	<head>
	<meta charset="UTF-8">
	<title>SPONIVERSE</title>

		<script>
			//회원탈퇴(DB삭제)
			function del(f) {
				let idx = f.user_idx.value;
				let c_pwd = f.c_pwd.value;//입력받은 비밀번호
		
				if (!confirm("회원님의 모든 정보가 삭제되며 되돌릴 수 없습니다.\n정말 회원탈퇴를 진행하시겠습니까?")) {
					return;
				}
				if (c_pwd == '') {
					alert("비밀번호를 입력하세요");
					return;
				}
		
				let url = "delete.do";
				let param = "user_idx=" + idx + "&user_pwd="
						+ encodeURIComponent(c_pwd);
				sendRequest(url, param, resultDelFn, "post");
			}
			function resultDelFn() {
				if (xhr.readyState == 4 && xhr.status == 200) {
		
					let data = xhr.responseText;
					let json = (new Function('return ' + data))();
		
					if (json[0].result == 'no') {
						alert("비밀번호가 일치하지 않습니다.");
						return;
					} else if (json[0].result == 'fail') {
						alert("[회원탈퇴 실패]여러차례 반복될 경우 담당자에게 문의하세요.");
						return;
					} else {
						alert("[회원탈퇴 완료]회원님의 모든 정보가 삭제 되었습니다.");
						location.href = "main.do";
					}
		
				}
			}
		</script>
	</head>
	
	<body>
		<div class="content_withdraw">
			<form>
		         <div class="withdraw_input">

		            <h2>회원 탈퇴 안내</h2>
		            	<div class="ment">
		            		<p>
		            		고객님! 그 동안 스포니버스를 이용해주셔서 감사합니다.<br>
							회원탈퇴를 신청하시기 전에 아래 안내 사항을 한번 더 확인해주세요.
							<br>
							<br>
							그럼 우리 또 만나요! (만나주실거죠? 🥺)
		            		</p>
		            	</div>
						
						<div class="Guidelines">
							<p class="Guide_first">
								- 회원탈퇴 신청 시, 회원님 이메일 아이디로 즉시 탈퇴 처리가 진행됩니다.
							</p>
							<p class="Guide">
								- 회원가입 시, 입력한 회원정보는 모두 삭제됩니다.
							</p>
							<p class="Guide">
								- 회원탈퇴가 완료된 이메일은 본인을 포함한 타인 모두 재사용이나 복구가 불가능합니다.
							</p>
							<p class="Guide">
								- 회원탈퇴 완료 후, 삭제된 행사와 접수내역의 데이터는 복구되지 않습니다.
							</p>
							<p class="Guide_last">
								- 개설한 행사나 참가한 행사 중에 진행중인 행사가 있을 시, 탈퇴가 불가능합니다. 행사 내역 삭제나 취소를 후에 탈퇴 부탁드립니다.
							</p>
						</div>
						
						<div class="agree">
						    <input type="checkbox" name="agree" id="agreeCheckbox" required>
						    <label for="agreeCheckbox">안내사항을 모두 확인하였으며, 이에 동의합니다.</label>
						</div>
						
						<div class="pwd">
							<p>사용중인 비밀번호</p>
							<input type="password" name="c_pwd" placeholder="비밀번호를 입력하세요">
							<input type="hidden" name="user_idx" value="${vo.user_idx}">
							<input type="hidden" name="user_pwd" value="${vo.user_pwd}">
							<input type="button" value="회원 탈퇴" onclick="del(this.form)">
						</div>
				</div>
			</form>
		</div>
	</body>
</html>