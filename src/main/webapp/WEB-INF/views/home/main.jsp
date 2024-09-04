<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
   <head>
      <meta charset="UTF-8"> 
      <title>SPONIVERSE</title>
     
      <!-- 폰트 설정 -->
      <link rel="preconnect" href="https://fonts.googleapis.com">
      <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
      <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
     
   </head>
   
   <body>
   
      <jsp:include page="navigation.jsp"></jsp:include><br>
      <jsp:include page="banner.jsp"></jsp:include><br>
      <%-- <jsp:include page="sport.jsp"></jsp:include><br> --%>
      <jsp:include page="loc.jsp"></jsp:include><br>
      <jsp:include page="recommend.jsp"></jsp:include> 
      
   </body>
</html>