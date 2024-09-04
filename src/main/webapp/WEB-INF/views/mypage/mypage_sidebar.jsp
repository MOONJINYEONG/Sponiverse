<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Mypage_sidebar</title>

	<script>
	/* 마이페이지(ul)안의 li(a)선택에 따라 출력되는 화면의 전환에 관한 js */
	document.addEventListener("DOMContentLoaded", function() {
		/* link1 클릭 시 */
		document.querySelector("#link1").addEventListener(
		"click", function(event) {
			document.querySelector(".content_event").style.display = "block"; 
			document.querySelector(".content_cancel").style.display = "none";
			document.querySelector(".content_modify").style.display = "none"; 
			document.querySelector(".content_withdraw").style.display = "none"; 
		});		
		
		/* link2 클릭 시 */
		document.querySelector("#link2").addEventListener(
		"click", function(event) {
			document.querySelector(".content_event").style.display = "none"; 
			document.querySelector(".content_cancel").style.display = "block"; 
			document.querySelector(".content_modify").style.display = "none"; 
			document.querySelector(".content_withdraw").style.display = "none"; 
		});		

		/* link3 클릭 시 */
		document.querySelector("#link3").addEventListener(
		"click", function(event) {
			document.querySelector(".content_event").style.display = "none"; 
			document.querySelector(".content_cancel").style.display = "none"; 
			document.querySelector(".content_modify").style.display = "block"; 
			document.querySelector(".content_withdraw").style.display = "none"; 
		});
		
		/* link4 클릭 시 */
		document.querySelector("#link4").addEventListener(
		"click", function(event) {
			document.querySelector(".content_event").style.display = "none"; 
			document.querySelector(".content_cancel").style.display = "none"; 
			document.querySelector(".content_modify").style.display = "none"; 
			document.querySelector(".content_withdraw").style.display = "block"; 
		});
	});
	</script>
	
</head>

<body>
    <div class="mypage_menu">
        <ul>
            <h2>마이페이지</h2>
            <li><a id="link1">참가행사</a></li>
            <li><a id="link2">취소내역</a></li>
            <li><a id="link3">정보수정</a></li>
            <li><a id="link4">회원탈퇴</a></li>
        </ul>
    </div>
</body>
</html>