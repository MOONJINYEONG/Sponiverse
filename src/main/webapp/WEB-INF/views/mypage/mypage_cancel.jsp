<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>취소내역</title>
    <!-- ajax -->
    <script src="/getspo/resources/js/httpRequest.js"></script>
</head>
<body>
    <div class="content_cancel">
        <h2>취소 내역</h2>
        <div>
            <c:if test="${not empty cancel}">
                <table border="1">
                    <tr>
                        <th>행사이름</th>
                        <th>취소요청일시</th>
                        <th>취소금액</th>
                        <th>취소요청인</th>
                    </tr>
                    <c:forEach var="item" items="${cancel}">
                        <tr data-user-idx="${item.user_idx}" data-event-idx="${item.event_idx}">
                            <td>
                                <a href="javascript:" onclick="location.href='event_detail.do?event_idx=${item.event_idx}'">
                                    ${item.event_name}
                                </a>
                            </td>
                            <td>${item.formattedCancelDate}</td>
                            <td> <c:choose>
                             <c:when test="${item.event_price > 0}">
                                 ${item.event_price}
                             </c:when>
                             <c:otherwise>
                                 무료
                             </c:otherwise>
                         </c:choose>
                     </td>
                            <td>${item.order_name}</td> 
                        </tr>
                    </c:forEach>
                    <tr>
                     <td colspan="4" align="center"> ${pageMenuCc}</td>
                  </tr>
                </table>
            </c:if>
            <c:if test="${empty cancel}">
                <p>취소된 행사가 없습니다</p>
            </c:if>
        </div>
    </div>
</body>
</html>
