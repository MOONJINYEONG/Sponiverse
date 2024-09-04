<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>네비게이션 바</title>
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/home/navigation.css">
    <script src="${pageContext.request.contextPath}/resources/js/navigation.js"></script>
    <script>
       // 전역 네임스페이스를 오염시키지 않기 위해 myApp 객체 생성
       var myApp = myApp || {};
   
       // myApp 객체에 search 함수를 정의
       myApp.search = function() {
           console.log("search function called"); // 함수 호출 확인
           
           // 검색어
           let search_text = document.getElementById("search_text").value;
           
           if (search_text === '') {
               location.href="event_list.do";
           }
           
           // URL 파라미터로 검색어를 추가
           location.href = "event_list.do?page=1&search_text=" + encodeURIComponent(search_text);
       };
       
       // 엔터 키를 감지하여 search 함수 호출
          document.addEventListener('DOMContentLoaded', function() {
              document.getElementById("search_text").addEventListener("keydown", function(event) {
                  if (event.key === "Enter") {
                      event.preventDefault();
                      myApp.search();
                  }
              });
          });
    </script>
</head>
<body>
    <nav class="navibar">
        <div class="resolution">
            <div class="logo_div">
                <a href="main.do">
                    <img class="main_logo" src="${pageContext.request.contextPath}/resources/img/logo/메인로고.png">
                </a>
            </div>
            
            <div class="left">
                <input type="text" id="search_text" class="searchbox" placeholder="검색어를 입력해주세요.">
                <a href= "javascript:void(0);" onclick="myApp.search();">
                    <img src="${pageContext.request.contextPath}/resources/img/logo/돋보기아이콘.png" class="searchbutton">
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
                    <c:if test="${empty sessionScope.user}">
                        <a href="javascript:" onclick="location.href='signinform.do'" class="signin">로그인</a>
                        <a href="javascript:" onclick="location.href='signupform.do'" class="signup">회원가입</a>
                    </c:if>
                </div>
                <c:if test="${empty sessionScope.user}">
                   <a href="javascript:" onclick="location.href='signinform.do'" class="new_event">무료행사개설</a>
                </c:if>
                <c:if test="${not empty sessionScope.user}">
                   <a href="javascript:" onclick="location.href='event_new.do'" class="new_event">무료행사개설</a>
                </c:if>
                <c:if test="${empty sessionScope.user}">
                     <a href="javascript:" onclick="location.href='signinform.do'" class="hostpage">호스트센터</a>
                </c:if>
                <c:if test="${not empty sessionScope.user}">
                   <a href="javascript:" onclick="location.href='hostMain.do'" class="hostpage">호스트센터</a>
                </c:if>
            </div>
        </div>
    </nav>
</body>
</html>
