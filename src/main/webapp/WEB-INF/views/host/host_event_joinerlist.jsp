<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>행사 관리</title>
    
    <!-- CSS 파일 링크 -->
    <link rel="stylesheet" href="/getspo/resources/css/host/host_event_management.css">
    
    <!-- JS 파일 링크 (주석 처리된 스크립트는 필요시 활성화) -->
    <!-- <script src="/getspo/resources/js/host_event_management.js"></script> -->
    
    <!-- 외부 Chart.js 라이브러리 -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>            
   
</head>
<body>
    <!-- 내비게이션 및 사이드바 포함 -->
    <jsp:include page="host_event_navigation.jsp"/>
    <jsp:include page="host_sidebar.jsp"/>
    
    <div class="container">
        <div class="filters">
            <div class="filter-controls">
                <div class="filter">
                    <select class="filter-dropdown" style="width: 150px;">
                        <option value="all">전체</option>
                        <option value="confirmed">참가확정자</option>
                        <option value="waiting">참가대기자</option>
                        <option value="unpaid">미결제자</option>
                    </select>
                </div>
                <div class="filter">
                    <select class="filter-dropdown" style="width: 150px;">
                        <option value="all">전체</option>
                        <option value="present">출석</option>
                        <option value="absent">출석안함</option>
                    </select>
                </div>
                <div class="filter" style="width: 200px;">
                    <select class="filter-dropdown">
                        <option value="all">티켓 정보</option>
                        <option value="individual">개인</option>
                        <option value="relay">릴레이</option>
                    </select>
                </div>
            </div>
        </div>
        
        <div class="summary mt-3">
            <div class="summary-info">
                <label>신청인원: 44명</label> / 
                <label>신청 티켓 수: 44개</label> / 
                <label>모집 정원: 700명</label>
            </div>
            <div class="actions">
                <a class="btn btn-primary p-2 mr-2">QR출석/명찰출력</a>
                <a class="btn btn-primary p-2 mr-2">다운로드</a>
                <div class="dropdown-container">
                    <a class="btn btn-primary p-2 dropdown-toggle">+ 추가/업로드 <i class="mdi mdi-chevron-down"></i></a>
                    <div class="dropdown-menu d-none">
                        <a class="dropdown-item">참가자 추가하기</a>
                        <a class="dropdown-item modal-trigger">엑셀 업로드</a>
                    </div>
                </div>
                <div class="search-container ml-10px">
                    <input placeholder="참가자 검색" class="search-input" style="width: 200px; height: 40px;">
                    <button class="search-button"><i class="mdi mdi-magnify"></i></button>
                </div>
            </div>
        </div>
        
        <div class="table-header mt-3" style="background: rgb(248, 250, 251);">
            <div class="table-header-content py-3 font-weight-bold">
                <div class="row">
                    <div class="col s2"><span>신청자 정보</span></div>
                    <div class="col s5 px-0">
                        <span class="d-inline-block" style="width: 40%;">신청 티켓</span>
                        <span class="d-inline-block px-10px" style="width: 30%;">결제</span>
                        <span class="d-inline-block px-10px">상태</span>
                    </div>
                    <div class="col s1"></div>
                    <div class="col s2"></div>
                    <div class="col s2"></div>
                </div>
            </div>
        </div>
        
        <div class="applicant-list txt-15">
            <div class="row">
                <div class="col s2">
                    <div class="applicant-info py-3">
                        <div>
                            <div class="applicant-name font-weight-700">전성현</div>
                            <div class="applicant-email" title="efging6875@naver.com" style="word-break: break-all;">ef********@naver.com</div>
                            <div class="applicant-phone" title="01051761549">010****1549</div>
                            <div>개인코드 : <span>Ej2v2D</span></div>
                            <div class="mt-4px d-none">
                                <a class="d-inline-block text-underline">사전 설문</a>
                            </div>
                            <div class="mt-10px">신청일 : 24년06월06일</div>
                        </div>
                    </div>
                </div>
                <div class="col s5">
                    <div class="ticket-info-row attendee-border-bottom">
                        <div class="ticket-info py-3" style="width: 40%;">
                            <span class="d-inline-block">개인</span>
                            <div class="mt-2 mr-10px d-flex justify-content-between"><span>1개</span></div>
                        </div>
                        <div class="payment-info px-10px py-3" style="width: 30%;">
                            <div class="amount mb-10px">110,000원</div>
                            <p>
                                <span class="text-small">결제완료/신용카드</span> <br>
                                <span class="text-small">2024-06-06 오후 6:46:10</span>
                            </p>
                        </div>
                        <div class="status-info px-10px py-3" style="width: 30%;">
                            <div><span class="status-confirmed">참가확정</span></div>
                            <span class="status-change txt-12 mt-10px">상태변경</span>
                        </div>
                    </div>
                </div>
                <div class="col s1 py-3">
                    <div class="attendance-checkbox">
                        <input type="checkbox" id="attendance0" class="filled-in">
                        <label for="attendance0">출석</label>
                    </div>
                </div>
                <div class="col s2 py-3"></div>
                <div class="col s2 py-3 text-right">
                    <div class="cancel-settings">
                        <input type="checkbox" id="cancelLock0" class="filled-in">
                        <label for="cancelLock0">참가자 취소 잠금 설정</label>
                    </div>
                    <div class="action-buttons mt-10px">
                        <span class="file-download d-none"><a download="">파일 다운로드</a></span>
                        <a class="note">메모</a>
                        <a href="#editModal" class="modal-trigger ml-10px text-edit" style="color: rgb(58, 132, 232); z-index: 1007;">수정</a>
                        <a href="#PaymentCancelModal" class="modal-trigger ml-10px text-cancel" style="color: rgb(191, 69, 69); z-index: 1009;">취소/환불</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
