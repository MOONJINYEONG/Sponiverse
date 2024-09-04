<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>참가자 리스트</title>
		
		<!-- css -->
        <link rel="stylesheet" href="/getspo/resources/css/host/host_register_list.css">
        
		                
	</head>
	<body>
		<jsp:include page="host_event_navigation.jsp"/>
		<jsp:include page="host_sidebar.jsp"/>
		
		<div class="channel-list-container">
		    <div class="header-row">
		        <div class="header-content">
		            <!-- <div class="filter-options">
		                <div class="filter-select">
		                    <select class="filter-dropdown" style="width: 150px;">
		                        <option value="all">전체</option>
		                        <option value="add">참가확정자</option>
		                        <option value="payattend">참가대기자</option>
		                        <option value="outstanding">미결제자</option>
		                    </select>
		                </div>
		                <div class="filter-select mx-16">
		                    <select class="filter-dropdown" style="width: 150px;">
		                        <option value="all">전체</option>
		                        <option value="true">출석</option>
		                        <option value="false">출석안함</option>
		                    </select>
		                </div>
		            </div> -->
		        </div>
		    </div>
		    <div class="info-row">
		        <div class="info-content">
		            <div class="info-details">
		                <label>신청인원: ${appliecount}명</label> / 
		                <label>모집 정원: ${event.event_max_joiner}명</label>
		            </div>
		            <!-- <div class="action-buttons">
		                <a class="action-btn">다운로드</a>
		                <div class="search-container">
		                    <input placeholder="참가자 검색" class="search-input">
		                    <button class="search-button"><i class="search-icon"></i></button>
		                </div>
		            </div> -->
		        </div>
		    </div>
		    <div class="list-header">
		        <div class="list-header-content">
		            <div class="list-header-item">신청자 정보</div>
		            <div class="list-header-item" style="width: 40%;">신청 티켓</div>
		            <div class="list-header-item" style="width: 30%;">결제</div>
		            <div class="list-header-item">상태</div>
		        </div>
		    </div>
		    <c:forEach var="order" items="${order}">
		    <div class="list-row">
		        <div class="list-item">
		            <div class="applicant-info">
		                <div class="name">${order.order_name}</div>
		                <div class="email" title="${order.order_email}">${order.order_email}</div>
		                <div class="phone" title="${order.order_tel}">${order.order_tel}</div>
		                <div class="survey-link" style="display: none;">
		                    <a class="survey-link-text">사전 설문</a>
		                </div>
		                <div class="apply-date">신청일 : ${order.formattedOrderDate}</div>
		            </div>
		            <div class="ticket-info" style="width: 40%;">
		                <div class="ticket-count">1개</div>
		            </div>
		            <div class="payment-info" style="width: 30%;">
		                <c:choose>
					        <c:when test="${event.event_price > 0}">
					            <div>${event.event_price}</div>
					            <p>
					                <span class="payment-status">결제완료/신용카드</span> <br>
					                <span class="payment-time">2024-06-06 오후 6:46:10</span>
					            </p>
					        </c:when>
					        <c:otherwise>
					            <div>무료</div>
					        </c:otherwise>
					    </c:choose>
		            </div>
		            <div class="status-info" style="width: 30%;">
		                <c:choose>
		                   <c:when test="${order.cancel_status eq 'Y'}">
		                       <div><span class="status-confirm">참가 취소</span></div>
		                   </c:when>
		                   <c:otherwise>
		                       <div><span class="status-confirm">참가</span></div>
		                   </c:otherwise>
		                   
		               </c:choose>
		                <!-- <span class="status-change-btn">상태변경</span> -->
		            </div>
		        </div>
		        <!-- <div class="attendance-checkbox">
		            <input type="checkbox" id="allAttend0" class="filled-in">
		            <label for="allAttend0">출석</label>
		        </div> -->
		        <div class="empty-space"></div>
		        <!-- <div class="action-links">
		            <input type="checkbox" id="cancelLockCheckbox0" class="filled-in">
		            <label for="cancelLockCheckbox0">참가자 취소 잠금 설정</label>
		            <div class="action-link-group">
		                <a class="file-download" style="display: none;">파일 다운로드</a>
		                <a class="memo-link">메모</a>
		                <a href="#editModal" class="modal-trigger edit-link">수정</a>
		                <a href="#PaymentCancelModal" class="modal-trigger cancel-link">취소/환불</a>
		            </div>
		        </div> -->
		    </div>
		    </c:forEach>
		</div>
	</body>
</html>