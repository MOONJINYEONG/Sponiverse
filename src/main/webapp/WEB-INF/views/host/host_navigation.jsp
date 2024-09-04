<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>호스트 네비게이션 바</title>

    <!-- css -->
    <link rel="stylesheet" href="/getspo/resources/css/host/host_navigation.css">

    <!-- 폰트 설정 -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">

    <script src="${pageContext.request.contextPath}/resources/js/navigation.js"></script>
</head>

<body>
    <nav class="hostCenterBar">
        <div class="resolution">
            <div class="logo">
            	<a href="javascript:" onclick="location.href='hostMain.do'" >
                	<img class="hostlogo_img" src="/getspo/resources/img/logo/host_logo.png">
            	</a>
            </div>

            <div class="right">
                <div id="user-info">
                    <c:if test="${not empty sessionScope.user}">
                        <button class="user-button">
                            <span class="user-name"><b>${sessionScope.user.user_name}</b> 님</span>
                            <svg class="user-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20">
                                <path d="M9.293 12.95l.707.707L15.657 8l-1.414-1.414L10 10.828 5.757 6.586 4.343 8z"></path>
                            </svg>
                        </button>
                        <div id="menu-items" role="menu" tabindex="0">
                            <div id="menu-1">
                                <p id="user_id">${sessionScope.user.user_id}</p>
                                <a href="mypageform.do?user_idx=${sessionScope.user.user_idx}" id="mypage_btn">마이페이지</a>
                            </div>
                            <div id="menu-2" class="border-t"></div>
                            <form action="logout.do" method="post">
                                <button id="logout-button">로그아웃</button>
                            </form>
                        </div>
                    </c:if>
                </div>

                <input class="toMake" type="button" value="행사 개설" onclick="location.href='event_new.do'">
                <input class="toMain" type="button" value="스포니버스 홈" onclick="location.href='main.do'">
            </div>
        </div>
    </nav>
</body>
</html>