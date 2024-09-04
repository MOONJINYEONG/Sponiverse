<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>호스트 사이드 바</title>
    <link rel="stylesheet" href="/getspo/resources/css/host/host_sidebar.css">
</head>

<body>
    <div class="sidebar">
        <div class="event_select">
            <select onchange="goToEvent(this)">
                <option selected disabled>행사선택</option>
                <c:forEach var="event" items="${events}">
                    <option value="${event.event_idx}">${event.event_name}</option>
                </c:forEach>
            </select>
        </div>

        <ul class="menu">
            <li class="menu-item">
                <a href="#" class="menu-link" data-target="submenu1">행사관리</a>
                <ul class="submenu" id="submenu1">
                    <li>
                        <a href="javascript:" onclick="location.href='host_event_management.do?event_idx=${event.event_idx}'">행사개요</a>
                    </li>
                    <li>
                        <a href="javascript:" onclick="location.href='host_event_modify.do?event_idx=${event.event_idx}'">행사수정</a>
                    </li>
                    <li>
                        <a href="javascript:" onclick="location.href='host_event_notice.do?event_idx=${event.event_idx}'">공지/안내작성</a>
                    </li>
                    <!-- <li><a href="#">행사할인쿠폰발송</a></li> -->
                </ul>
            </li>

            <li class="menu-item">
                <a href="#" class="menu-link" data-target="submenu2">참가자관리</a>
                <ul class="submenu" id="submenu2">
                    <li>
                        <a href="javascript:" onclick="location.href='register_list.do?event_idx=${event.event_idx}'">참가자리스트</a>
                    </li>
                    <!-- <li><a href="#">결제리스트</a></li>
                    <li><a href="#">받은문의내역</a></li> -->
                </ul>
            </li>
        </ul>
    </div>

    <script src="/getspo/resources/js/host_sidebar.js"></script>
    <script>
        function goToEvent(selectElement) {
            var eventIdx = selectElement.value;
            if (eventIdx) {
                var url = 'host_event_management.do?event_idx=' + eventIdx;
                window.location.href = url;
            }
        }
    </script>
</body>
</html>
