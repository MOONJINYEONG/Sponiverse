<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
   <head>
      <meta charset="UTF-8">
      <title>행사 관리</title>
      
     	 <!-- css -->
        <link rel="stylesheet" href="/getspo/resources/css/host/host_event_management.css">
        
        <!-- js -->
        <!-- <script src="/getspo/resources/js/host_event_management.js"></script> -->
      
      <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>                
   </head>
   <body>
   <jsp:include page="host_event_navigation.jsp"/>
   <jsp:include page="host_sidebar.jsp"/>
   
   <article id="event_info_section" class="event_info_section">
       <div class="event_info_img_wrapper">
           <div class="event_info_img">
               <img src="/getspo/resources/upload/${event.event_thumbnail}" alt="Event Image">
           </div>
           <div class="event_info_dday">
               <canvas id="canvas" class="confetti" width="238" height="123" style="display: none;"></canvas>
               <div class="dday_wrapper">
                   <p class="dday">D+20</p>
               </div>
           </div>
       </div>
       <div class="event_info_wrapper">
           <div class="category">
               <c:choose>
                <c:when test="${event.event_sports_idx == 1}">
                    <p>러닝</p>
                </c:when>
                <c:when test="${event.event_sports_idx == 2}">
                    <p>철인3종</p>
                </c:when>
                <c:otherwise>
                    <p>기타</p>
                </c:otherwise>
            </c:choose>
               <span class="wall">|</span>
               <p>${event.event_loc}</p>
           </div>
           <div class="edit_icon_box">
               <div class="edit_icon_wrapper">
                   <div class="edit_icon" onclick="toggleMenu();">
                       <svg xmlns="http://www.w3.org/2000/svg" width="20px" height="20px" color="#878d91" viewBox="0 0 20 20" fill="currentColor">
                           <path d="M10 6a2 2 0 110-4 2 2 0 010 4zM10 12a2 2 0 110-4 2 2 0 010 4zM10 18a2 2 0 110-4 2 2 0 010 4z"></path>
                       </svg>
                   </div>
                   <div class="edit_menu_box">
                       <a class="event_delete">행사 삭제</a>
                   </div>
               </div>
           </div>
           <div  class="event_info">
               <a class="title-link" href="event_detail.do?event_idx=${event.event_idx}">
                  (행사번호 : ${event.event_idx}) ${event.event_name}
               </a>
           </div>
           <div class="detail_info">
               <p class="detail_title">일시</p>
               <p class="detail_info_data">${event.getFormattedEventHStart()} ~ ${event.getFormattedEventHEnd() }</p>
           </div>
           <div class="detail_info">
               <p class="detail_title">장소</p>
               <p class="detail_info_data">${event.event_addr}${event.event_addrdetail}</p>
           </div>
           <div class="detail_info">
               <p class="detail_title">링크</p>
               <p id="event-url" class="detail_info_data">http://localhost:9090/getspo/event_detail.do?event_idx=${event.event_idx}</p>
               <div class="clipboard_btn">
                   <a data-clipboard-target="#event_url" href="#urlModal" class="copy_url">URL 복사</a>
               </div>
           </div>
       </div>
   </article>
   
   <!-- 모집 -->   
   <article class="event_info_section2">
       <div class="title_box">
           <p class="subtitle">참가자 모집</p>
           <div class="direct_btn_wrapper">
               <a href="/getspo/register_list.do?event_idx=${event.event_idx}" target="_self" class="direct_btn">참가자리스트 바로가기</a>
               <span class="chevron-right"></span>
           </div>
       </div>
       <div class="info_box1" style="display: inline-block; width: 100%;">
           <div class="row">
               <div class="join_box">
                   <div class="join_box_sub">
                       <div class="card_title_wrapper">
                           <p class="card_name">참가 신청</p>
                       </div>
                       <div class="join_chart">
                           <div class="join_chartsub">
                               <div>
                                   <p class="join_chart_count">${event.event_max_joiner}<span class="join_chart_count_unit">&nbsp;명</span></p>
                                   <p class="join_chart_info_percent">모집정원의&nbsp;<span>${percent}%</span></p>
                               </div>
                               <div class="join_chartgraph">
                               <canvas id="myChart" class="myChart"></canvas>
                               </div>
                           </div>
                       </div>
                   </div>
               </div>
               <div class="join_box_2">
                   <div class="join_box_sub2">
                       <div class="join_cancle">
                           <p class="card_name">취소</p>
                           <p class="join_chart_count">${canceltotal}<span class="join_chart_count_unit">&nbsp;명</span></p>
                       </div>
                   </div>
               </div>
           </div>
       </div>
   </article>
   
   <script>
   // 메뉴 토글 함수
    function toggleMenu() {
        var menuBox = document.querySelector('.edit_menu_box');
        if (menuBox.style.display === 'none' || menuBox.style.display === '') {
            menuBox.style.display = 'block';
            // 메뉴가 열릴 때, 문서 전체에 클릭 이벤트 리스너 추가
            document.addEventListener('click', closeMenuOnClickOutside);
        } else {
            menuBox.style.display = 'none';
            // 메뉴가 닫힐 때, 문서 전체에 클릭 이벤트 리스너 제거
            document.removeEventListener('click', closeMenuOnClickOutside);
        }
    }

    // 메뉴 외부 클릭 시 메뉴를 닫는 함수
    function closeMenuOnClickOutside(event) {
        var menuBox = document.querySelector('.edit_menu_box');
        var editIcon = document.querySelector('.edit_icon');
        // 클릭한 요소가 메뉴 또는 메뉴 아이콘이 아닌 경우
        if (!menuBox.contains(event.target) && !editIcon.contains(event.target)) {
            menuBox.style.display = 'none';
            document.removeEventListener('click', closeMenuOnClickOutside);
        }
    }

    // 메뉴 아이콘 클릭 시 메뉴 토글
    document.querySelector('.edit_icon').addEventListener('click', function(event) {
        // 이벤트 버블링을 막아 메뉴가 바로 닫히지 않도록 함
        event.stopPropagation();
        toggleMenu();
    });

    // 차트 생성 코드
     window.onload = function() {
       var ctx = document.getElementById('myChart').getContext('2d');
       var myChart = new Chart(ctx, {
           type: 'doughnut', // 도넛 차트
           data: {
               labels: ['전체 참가자 수', '신청한 참가자 수'],
               datasets: [{
                   label: '참가자 수 비교',
                   data: [${event.event_max_joiner}, ${appliecount}], // 데이터: 전체 참가자 수 , 신청한 참가자 수 
                   backgroundColor: [
                       'rgba(54, 162, 235, 0.2)', // 전체 참가자 수의 배경 색상
                       'rgba(255, 99, 132, 0.2)'  // 내가 신청한 참가자 수의 배경 색상
                   ],
                   borderColor: [
                       'rgba(54, 162, 235, 1)', // 전체 참가자 수의 테두리 색상
                       'rgba(255, 99, 132, 1)'  // 내가 신청한 참가자 수의 테두리 색상
                   ],
                   borderWidth: 1
               }]
           },
           options: {
               responsive: true,
               maintainAspectRatio: false // 이 옵션을 추가하여 비율을 유지하지 않도록 설정
           }
       });
   }
   </script>
   
      
   
   </body>
</html>