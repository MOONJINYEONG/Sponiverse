<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
   <meta charset="UTF-8">
   <title>Insert title here</title>

   <link rel="stylesheet" href="/getspo/resources/css/host/host_event_cancel.css">
   <!-- ajax -->
   <script src="/getspo/resources/js/httpRequest.js"></script>
</head>

<body>
   <jsp:include page="host_navigation.jsp" /><br>

   <div class="host_content">
      <h2 class="menu_title">개설 취소 내역</h2>
      <p class="menu_subtitle">
         개설을 취소하신 행사를 확인하실 수 있습니다.
         <a id="event_list" href="javascript:" onclick="location.href='hostMain.do'">개설 행사 리스트 보러가기 </a>
      </p>
      
      <br>

      <c:if test="${not empty events}">
         <table border="1">
            <tr>
               <th>행사번호</th>
               <th>행사이름</th>
               <th>행사장소</th>
               <th>행사일자</th>
               <th>개설취소일자</th>
            </tr>

            <c:forEach var="event" items="${events}">
               <tr>
                  <td>${event.event_idx}</td>
                  <td>
                     <a href="javascript:" onclick="location.href='host_event_management.do?event_idx=${event.event_idx}'">
                        ${event.event_name}
                     </a>
                  </td>
                  <td>${event.event_addr}</td>
                  <td>${event.formattedEventHStart}</td>
                  <td>${event.formattedDeleteDate}</td>
               </tr>
            </c:forEach>
            <tr>
               <td colspan="5" align="center">${pageMenu}</td>
            </tr>
         </table>
      </c:if>

      <c:if test="${empty events}">
         <p>취소된 행사가 없습니다</p>
      </c:if>
   </div>
</body>
</html>
