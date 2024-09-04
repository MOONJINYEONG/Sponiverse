<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>

<!-- css -->
<link rel="stylesheet" href="/getspo/resources/css/home/mypage.css">

<!-- 폰트설정 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">

<!-- Ajax -->
<script src="/getspo/resources/js/httpRequest.js"></script>

<!-- 우편번호 API -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="/getspo/resources/js/addr.js"></script>

</head>

<body>
	<jsp:include page="/WEB-INF/views/home/navigation.jsp"></jsp:include><br>

	<div class="container">
		<jsp:include page="/WEB-INF/views/mypage/mypage_sidebar.jsp"></jsp:include>

		<div class="contents_wrapper">
			<!-- 참가행사 -->
			<jsp:include page="/WEB-INF/views/mypage/mypage_event.jsp"></jsp:include>
			<!-- 취소내역 -->
			<jsp:include page="/WEB-INF/views/mypage/mypage_cancel.jsp"></jsp:include>
			<!-- 정보수정-->
			<jsp:include page="/WEB-INF/views/mypage/mypage_modify.jsp"></jsp:include>
			<!-- 회원탈퇴-->
			<jsp:include page="/WEB-INF/views/mypage/mypage_withdraw.jsp"></jsp:include>
		</div>
	</div>
</body>
</html>