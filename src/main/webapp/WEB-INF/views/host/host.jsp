<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
   <meta charset="UTF-8">
   <title>Insert title here</title>
   <link rel="stylesheet" href="/getspo/resources/css/host/host.css">
   <!-- ajax -->
   <script src="/getspo/resources/js/httpRequest.js"></script>
</head>

<body>
   <jsp:include page="host_navigation.jsp" /><br>

   <div class="host_content">
      <h2 class="menu_title">개설 행사 리스트</h2>
      <p class="menu_subtitle">
         행사 관리 페이지로 가려면 행사이름을 클릭하세요.
         <a id="cancel_list" href="javascript:" onclick="location.href='host_event_cancel.do'">개설 취소 내역 보러가기</a>
      </p>
      <br>

      <c:if test="${not empty events}">
         <table border="1">
            <tr>
               <th>행사번호</th>
               <th>조회수</th>
               <th>행사이름</th>
               <th>행사장소</th>
               <th>행사일자</th>
               <th>개설일자</th>
               <th>개설취소</th>
            </tr>

            <!-- 대회 개설 시, 보여짐 -->
            <c:forEach var="event" items="${events}">
               <input type="hidden" id="event_idx" name="event_idx" value="${event.event_idx}">
               <tr>
                  <td>${event.event_idx}</td>
                  <td>${event.event_viewCount}</td>
                  <td><a href="javascript:" onclick="location.href='host_event_management.do?event_idx=${event.event_idx}'">${event.event_name}</a></td>
                  <td>${event.event_addr}</td>
                  <td>${event.formattedEventHStart}</td>
                  <td>${event.formattedEventCreateDate}</td>
                  <td data-event-idx="${event.event_idx}"><a href="javascript:" onclick="deleteEvent(this);">취소</a></td>
               </tr>
            </c:forEach>
            <tr>
               <td colspan="7" align="center">${pageMenu}</td>
            </tr>
         </table>
      </c:if>

      <c:if test="${empty events}">
         <p>개설된 이벤트가 없습니다</p>
      </c:if>
   </div>

   <script>
      // 행사 개설취소
      function deleteEvent(element) {
         if (confirm("정말 취소하시겠습니까?")) {
            // 클릭된 요소의 부모 <td>를 찾습니다.
            let td = element.closest('td');
            let eventIdx = td.dataset.eventIdx;

            // 이후 삭제 요청을 보냅니다.
            let url = "deleteEvent.do";
            let param = "event_idx=" + eventIdx; // param의 첫번째 항목에 & 필요 없음
            sendRequest(url, param, resultDelete, "post");
         } else {
            // 취소 버튼을 눌렀을 때의 처리 (필요한 경우)
            console.log("[행사취소 실패]");
         }
      }

      function resultDelete() {
         if (xhr.readyState == 4 && xhr.status == 200) {
            let data = xhr.responseText;
            let json = (new Function('return ' + data))();

            if (json[0].result == 'fail') {
               alert("[행사취소 실패]여러차례 반복될 경우 담당자에게 문의하세요.");
               return;
            } else if (json[0].result == 'clear') {
               alert("[행사취소 완료]개설된 행사가 취소되었습니다.");
               location.href = 'hostMain.do';
            } else {
               alert("행사취소 실패");
               return;
            }
         }
      }
   </script>
</body>
</html>
