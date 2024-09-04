
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>  
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>행사 전체 페이지</title>
    <link rel="stylesheet" href="/getspo/resources/css/event/event_list.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
    
    <!-- ajax -->
   <script src="/getspo/resources/js/httpRequest.js"></script>
    
    <script>
    	//종목 선택시
	    document.addEventListener('DOMContentLoaded', function() {
	    	const running = document.querySelector('#running');
	        const triathlon = document.querySelector('#triathlon');
	        const locationSelect = document.getElementById('location');

	        running.addEventListener('click', function() {
	            if (running.checked) {
	                triathlon.checked = false;
	            }
	            applyFilters();
	        });

	        triathlon.addEventListener('click', function() {
	            if (triathlon.checked) {
	                running.checked = false;
	            }
	            applyFilters();
	        });

	        locationSelect.addEventListener('change', function() {
	            applyFilters();
	        });
	    });

	    function applyFilters() {
	        let loc = document.getElementById('location').value;
	        let sport = '';

	        if (document.getElementById('running').checked) {
	            sport = document.getElementById('running').value;
	        } else if (document.getElementById('triathlon').checked) {
	            sport = document.getElementById('triathlon').value;
	        }

	        let url = "event_list.do?event_loc=" + encodeURIComponent(loc);
	        if (sport) {
	            url += "&event_sports_idx=" + sport;
	        }

	        location.href = url;
	    }
    	
    	    
		//리셋버튼 클릭시 초기화
        function resetFilters() {
            document.getElementById('location').value = 'all';
            document.getElementById('running').checked = false;
            document.getElementById('triathlon').checked = false;
            applyFilters(); // 초기화 후 필터링 함수를 호출하여 전체 이벤트를 표시합니다.
        }
		
		
    </script>
</head>
<body>
    <jsp:include page="/WEB-INF/views/home/navigation.jsp"></jsp:include><br>
    <div class="container">
        <!-- 필터 섹션 추가 -->
        <div class="filterSection" id="filterSection">
            <div class="filter">필터 <button class="reset-button" onclick="resetFilters()">필터 초기화</button></div>
            <div class="filter-box">
                <!-- 지역 선택 -->
                <div class="filter-item">
                    <label for="location">지역</label>
                    <select id="location" name="location" class="location" onchange="locEvents();">
                        <option value="all" ${selectedLoc == 'all' ? 'selected' : ''}>전체</option>
                        <option value="서울_경기_인천" ${selectedLoc == '서울_경기_인천' ? 'selected' : ''}>서울/경기/인천</option>
                        <option value="부산_울산_경남" ${selectedLoc == '부산_울산_경남' ? 'selected' : ''}>부산/울산/경남</option>
                        <option value="대구_경북" ${selectedLoc == '대구_경북' ? 'selected' : ''}>대구/경북</option>
                        <option value="충북_충남_대전_세종" ${selectedLoc == '충북_충남_대전_세종' ? 'selected' : ''}>충청/대전/세종</option>
                        <option value="전남_전북_광주" ${selectedLoc == '전남_전북_광주' ? 'selected' : ''}>전라/광주</option>
                        <option value="강원" ${selectedLoc == '강원' ? 'selected' : ''}>강원</option>
                        <option value="제주" ${selectedLoc == '제주' ? 'selected' : ''}>제주</option>
                        <!-- 필요한 다른 지역 추가 -->
                    </select>
                </div>
                <!-- 종목 선택 체크박스 -->
                <div class="filter-item">
                    <label>종목</label>
                    <div class="checkbox-group">
                        <div>
                            <input type="checkbox" id="running" name="sport" value="1" ${selectedSport == 1 ? 'checked' : ''}>
                            <label for="running">러닝</label>
                        </div>
                        <div>
                            <input type="checkbox" id="triathlon" name="sport" value="2" ${selectedSport == 2 ? 'checked' : ''}>
                            <label for="triathlon">철인3종</label>
                        </div>
                        <!-- 필요한 다른 종목 추가 -->
                    </div>
                </div>
            </div>
        </div>
        
        <!-- 이벤트 섹션  -->
        <div class="eventSection" id="eventSection">
            <div class="search-group">
                <div class="total-box">
                    <span class="total-event">${totalEvent}</span> <span>개의 행사가 검색되었습니다</span>
                </div>
            </div>
            <div class="item-box" id="item-box">
                <!-- JSTL forEach를 사용하여 이벤트 목록 출력 -->
                <c:forEach var="event" items="${events}">
                    <div class="content">
                        <div class="items-1">
                            <a class="title-link" href="event_detail.do?event_idx=${event.event_idx}">
                                <img class="img-link" src="/getspo/resources/upload/${event.event_thumbnail}" alt="${event.event_name}">
                            </a>
                        </div>
                        <div class="items-2">
                            <div class="dayloc-box">
                                <div>
                                    <span class="openday">${event.getFormattedEventHStart()}</span>
                                </div>
                                <div>
                                    <span>${event.event_loc}</span>
                                </div>
                            </div>
                            <div class="title-box">
                                <a class="title-link" href="event_detail.do?event_idx=${event.event_idx}">${event.event_name}</a>
                            </div>
                            <div class="info-box">
                                <div class="pay-box">
                                    <c:choose>
                                        <c:when test="${event.event_price > 0}">
                                            <fmt:formatNumber value="${event.event_price}" type="number" groupingUsed="true" />원
                                        </c:when>
                                        <c:otherwise>
                                            <span>무료</span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                
                        <div class="check-box">
                            <span class="check-count"> 조회 <fmt:formatNumber value="${event.event_viewCount}" type="number" groupingUsed="true" /></span>
                        </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>

            <!-- 페이징 -->
            <div align="center">${pageMenu}</div>
        </div>
    </div>
   
</body>
</html>