<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>참가행사</title>
<!-- ajax -->
<script src="/getspo/resources/js/httpRequest.js"></script>

</head>

<body>
   <div class="content_event">
      <h2>참가 행사 목록</h2>
      <div>
         <c:if test="${not empty order}">

            <table border="1">
               <tr>
                  <th>카테고리</th>
                  <th>행사이름</th>
                  <th>행사장소</th>
                  <th>행사일시</th>
                  <th>신청일시</th>
                  <th>참가취소</th>
               </tr>

               <c:forEach var="order" items="${order}">

                 
                  <tr data-user-idx="${order.user_idx}" data-event-idx="${order.event_idx}">
                     <td><c:choose>
                           <c:when test="${order.event_sports_idx == 1}">러닝</c:when>
                           <c:when test="${order.event_sports_idx == 2}">철인3종</c:when>
                           <c:otherwise>기타</c:otherwise>
                        </c:choose></td>
                     <td><a href="javascript:" onclick="location.href='event_detail.do?event_idx=${order.event_idx}'"> ${order.event_name} </a></td>
                     <td>${order.event_addr}</td>
                     <td>${order.formattedEventHStart}</td>
                     <td>${order.formattedOrderDate}</td>
                     <td><a href="javascript:" onclick="cancelEvent(this)">취소</a></td>
                  </tr>
               </c:forEach>
               <tr>
               <td colspan="6" align="center"> ${pageMenu}</td>
            </tr>
            </table>
         </c:if>
         <c:if test="${empty order}">
            <p>신청한 행사가 없습니다</p>
         </c:if>
      </div>
   </div>
</body>
<script>
   function cancelEvent(element) {
      if (confirm("정말 취소하시겠습니까?")) {
          let row = element.closest('tr');
            let userIdx = row.dataset.userIdx;
            let eventIdx = row.dataset.eventIdx;

           // 이후, 유료 티켓의 '신용카드/간편결제'로 참가를 진행한 경우 환불 절차를 추가할 것.

           let url = "cancelEvent.do";
           let param = "user_idx=" + userIdx + "&event_idx=" + eventIdx;
           sendRequest(url, param, resultFntwo, "post");
       } else {
           // 취소 버튼을 눌렀을 때의 처리 (필요한 경우)
           console.log("신청취소가 취소되었습니다.");
       }
   }
   function resultFntwo() {
       if (xhr.readyState == 4 && xhr.status == 200) {
          
          let data = xhr.responseText;
          let json = (new Function('return ' + data))();
          if (json[0].result == 'clear') {
            alert("행사 신청취소 되었습니다");
            location.href = 'mypageform.do?user_idx=${vo.user_idx}&menu=link1';
         } else if (json[0].result == 'fail') {
            alert("행사 신청 취소에 실패하였습니다. 다시 시도해 주세요.");
            return ;
         }
          
       }
   }
</script>
</html>