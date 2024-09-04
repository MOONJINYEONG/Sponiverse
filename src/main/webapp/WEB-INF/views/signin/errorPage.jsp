<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>오류 페이지</title>
		<link rel="stylesheet" href="/getspo/resources/css/signin/errorPage.css">
	</head>
	<body>
		<div class="container">
	        <div class="error-wrapper">
	            <h2>오류 발생</h2>
	            <p>${message}</p>
	            <a href="signinform.do">로그인 페이지로 돌아가기</a>
	        </div>
	    </div>
	</body>
</html>