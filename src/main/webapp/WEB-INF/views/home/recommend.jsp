<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
   <html>
   <head>
      <meta charset="UTF-8">
      <title>추천행사 메뉴</title>
      
      <link rel="stylesheet" href="/getspo/resources/css/home/recommend.css">
      
   </head>
   <body>
       <!-- 개최 행사 메뉴 -->
      <div class="recommend">
         <h4 class="menu_title">Upcoming Event</h4>
            <h6 class="menu_subtitle">다가오는 스포츠 행사를 만나보세요!
               <a href="javascript:" onclick="location.href='event_list.do'" id="event_more">더 많은 행사보기 ></a>
            </h6>

      <!-- 대회썸네일 -->
       <table align="center" width="1200px;">
            <c:forEach var="event" items="${events}" varStatus="status">
                <c:if test="${status.index < 8}"> <!-- 2줄 * 4열 = 8개 항목 제한 -->
                    <c:if test="${status.index % 4 == 0}">
                        <tr>
                    </c:if>
                    <td>
                        <div style="cursor:pointer" class="container" onclick="location.href='event_detail.do?event_idx=${event.event_idx}'">
                            <img class="thumbnail" src="/getspo/resources/upload/${event.event_thumbnail}" alt="${event.event_name}">
                            <div class="overlay">
                                <p class="hover_text">대회참가</p>
                            </div>
                            <a class="event_date">${event.getFormattedEventHStart()} / ${event.event_loc}</a><br>
                            <a class="event_name">${event.event_name}</a><br>
                            <c:choose>
                                <c:when test="${event.event_price > 0}">
                                    <a class="price"><fmt:formatNumber value="${event.event_price}" type="number" groupingUsed="true" />원</a>
                                </c:when>
                                <c:otherwise>
                                    <a class="price">무료</a>
                                </c:otherwise>
                            </c:choose>
                            <a class="view">조회수 ${event.event_viewCount}</a>
                        </div>
                    </td>
                    <td class="gutter"></td>
                    <c:if test="${status.index % 4 == 3}">
                        </tr>
                    </c:if>
                </c:if>
            </c:forEach>
            <c:if test="${status.count % 4 != 0}">
                </tr>
            </c:if>
        </table>
      </div>
   </body>
</html>