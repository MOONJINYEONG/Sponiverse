<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>행사 페이지</title>
    <link rel="stylesheet" href="/getspo/resources/css/event/event_detail.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
    <!-- ajax -->
    <script src="/getspo/resources/js/httpRequest.js"></script>
    <script>
        // 메뉴바 이동
        document.addEventListener("DOMContentLoaded", function() {
            const buttons = document.querySelectorAll(".button_bar button");

            buttons.forEach(button => {
                button.addEventListener("click", function() {
                    buttons.forEach(btn => btn.classList.remove("active"));
                    this.classList.add("active");

                    // 섹션 이동
                    const targetSection = this.getAttribute("data-target");
                    document.getElementById(targetSection).scrollIntoView({ behavior: 'smooth' });
                });
            });

            // 모달 관련 스크립트
            const modal = document.querySelector('.modal');
            const modalOpen = document.querySelector('.modal_btn');
            const modalClose = document.querySelectorAll('.close_btn');
            const submitBtn = document.getElementById('submitQuestion');
            const qa_content = document.getElementById('qa_content');
            const isPrivateCheckbox = document.getElementById('qa_is_private');

            // 모달 열기
            modalOpen.addEventListener('click', function() {
                modal.style.display = 'block';
                qa_content.value = ""; //내용 초기화
                isPrivateCheckbox.checked = false; // 초기화: 비밀글 체크박스 초기 상태로 되돌리기
                qa_content.focus();
            });

            // 모달 닫기
            modalClose.forEach(btn => {
                btn.addEventListener('click', function() {
                    modal.style.display = 'none';
                });
            });

            // 문의하기 버튼 클릭 시
            submitBtn.addEventListener('click', function() {
                const user_idx = document.getElementById("user_idx").value;
                const event_idx = document.getElementById("event_idx").value;
                const content = qa_content.value.trim();
                const qa_is_private = isPrivateCheckbox.checked ? 'Y' : 'N';
                if (content !== '') {
                    let url = "question.do";
                    let param = "user_idx=" + user_idx + "&event_idx=" + event_idx + "&qa_content=" + encodeURIComponent(content) + "&qa_is_private=" + qa_is_private;
                    sendRequest(url, param, resultQa, "POST");
                } else {
                    alert('문의 내용을 입력해주세요.');
                }
            });

            function resultQa() {
                if (xhr.readyState == 4 && xhr.status == 200) {
                    let data = xhr.responseText;
                    if (data == "success") {
                        alert("문의완료");
                        location.href = "event_detail.do?event_idx=${event.event_idx}";
                    } else if (data == "no_user") {
                        alert("로그인을 해주세요");
                        return;
                    } else {
                        alert("문의실패");
                        return;
                    }
                }
            }
        });

        // 댓글 작성
        document.addEventListener("DOMContentLoaded", function() {
            document.querySelectorAll(".submitComment").forEach(button => {
                button.addEventListener("click", function() {
                    const qaIdx = this.getAttribute("data-qa-idx");
                    const commentContent = document.getElementById("comment_content_" + qaIdx).value.trim();
                    if (commentContent !== '') {
                        console.log("Submitting comment for qa_idx: " + qaIdx + ", content: " + commentContent);
                        let url = "add_comment.do";
                        let param = "qa_idx=" + qaIdx + "&comment_content=" + encodeURIComponent(commentContent);
                        sendRequest(url, param, resultComment, "POST");
                    } else {
                        alert('댓글 내용을 입력해주세요.');
                    }
                });
            });

            function resultComment() {
                if (xhr.readyState == 4 && xhr.status == 200) {
                    let data = xhr.responseText;
                    console.log("Response from server: " + data);
                    if (data == "success") {
                        alert("댓글이 등록되었습니다.");
                        location.reload();
                    } else {
                        alert("댓글 등록에 실패했습니다.");
                        return;
                    }
                }
            }

            // 댓글 삭제
            document.querySelectorAll(".deleteComment").forEach(button => {
                button.addEventListener("click", function() {
                    const commentIdx = this.getAttribute("data-comment-idx");
                    if (confirm("댓글을 삭제하시겠습니까?")) {
                        console.log("Deleting comment with comment_idx: " + commentIdx);
                        let url = "delete_comment.do";
                        let param = "comment_idx=" + commentIdx;
                        sendRequest(url, param, resultDeleteComment, "POST");
                    }
                });
            });

            function resultDeleteComment() {
                if (xhr.readyState == 4 && xhr.status == 200) {
                    let data = xhr.responseText;
                    console.log("Response from server: " + data);
                    if (data == "success") {
                        alert("댓글이 삭제되었습니다.");
                        location.reload();
                    } else {
                        alert("댓글 삭제에 실패했습니다.");
                        return;
                    }
                }
            }
        });

        // 공지사항 날짜
        document.addEventListener("DOMContentLoaded", function() {
            const noticeDateSpan = document.querySelector(".notice-date");
            const noticeDateStr = noticeDateSpan.dataset.noticeDate; // 데이터셋을 이용해 날짜 값을 가져옴
            const noticeDate = new Date(noticeDateStr);
            const today = new Date();

            // 시간 부분을 제거하여 날짜만 비교
            noticeDate.setHours(0, 0, 0, 0);
            today.setHours(0, 0, 0, 0);

            // 시간 차이를 계산하여 일 단위로 변환
            const timeDiff = today - noticeDate;
            const diffDays = Math.ceil(timeDiff / (1000 * 3600 * 24));

            // 날짜 차이에 따라 텍스트 설정
            if (diffDays === 0) {
                noticeDateSpan.textContent = "오늘";
            } else {
                noticeDateSpan.textContent = diffDays + "일 전";
            }
        });

        // 토글 버튼에 클릭 이벤트 추가
        document.addEventListener('DOMContentLoaded', function() {
            const toggleButtons = document.querySelectorAll('.toggle_btn');
            toggleButtons.forEach(button => {
                button.addEventListener('click', function() {
                    const comment = this.parentNode.querySelector('.comment');
                    comment.style.display = comment.style.display === 'none' ? 'block' : 'none';
                    this.textContent = comment.style.display === 'none' ? '▼' : '▲';
                });
            });
        });
        
        //마스킹 처리
         document.addEventListener("DOMContentLoaded", function() {
            // 서버 측에서 세션 상태를 전달받음
            var isUserEmpty = ${empty sessionScope.user};

            if (isUserEmpty) {
                var emailElement = document.getElementById('email');
                var nameElement = document.getElementById('name');
                var telElement = document.getElementById('tel');

                if (emailElement) {
                    var email = emailElement.innerHTML;
                    var maskedEmail = email.replace(/(.{2})(.*)(@.*)/, function(fullMatch, firstTwo, middle, afterAt) {
                        var maskedMiddle = middle.replace(/./g, '*');
                        var maskedAfterAt = afterAt.replace(/([^@])/g, '*');
                        return firstTwo + maskedMiddle + maskedAfterAt;
                    });
                    emailElement.innerHTML = maskedEmail;
                }
                if (nameElement) {
                    var name = nameElement.innerHTML;
                    var maskedName = name.replace(/.(?=.{1,})/g, '*');
                    nameElement.innerHTML = name[0] + name.substring(1).replace(/./g, '*');
                }
                if (telElement) {
                	 var tel = telElement.innerHTML;
                     var maskedTel = tel.replace(/\d/g, '*');
                     telElement.innerHTML = maskedTel;
                }
            }
        });
    </script>
</head>
<body>
    <jsp:include page="../home/navigation.jsp"></jsp:include>
    <br>
    <div class="event_detail_page">
        <div class="event_line">
            <div>
                <img src="/getspo/resources/upload/${event.event_thumbnail}" id="event_image" alt="Event Thumbnail">
            </div>
            <div class="button_bar">
                <ul>
                    <li>
                        <button type="button" class="active" data-target="intro">
                            <span>행사소개</span>
                        </button>
                    </li>
                    <li>
                        <button type="button" data-target="place">
                            <span>행사장소</span>
                        </button>
                    </li>
                    <li>
                        <button type="button" data-target="notice">
                            <span>공지/안내</span>
                        </button>
                    </li>
                    <li>
                        <button type="button" data-target="ask">
                            <span>문의하기</span>
                        </button>
                    </li>
                    <li>
                        <button type="button" data-target="cancel">
                            <span>취소/환불</span>
                        </button>
                    </li>
                </ul>
            </div>
            <br>
            <hr>
            <br>
            <section id="intro" class="intro">
                <div>
                    <span>일시 : </span> <span>${event.getFormattedEventHStart()}~${event.getFormattedEventHEnd()}</span>
                </div>
                <div>
                    <span>신청 : </span> <span>${event.getFormattedEventRStart()}~${event.getFormattedEventREnd()}</span>
                </div>
                <div>
                    <span>비용 : </span>
                    <c:choose>
                        <c:when test="${event.event_price > 0}">
                            <fmt:formatNumber value="${event.event_price}" type="number" groupingUsed="true" />원
                        </c:when>
                        <c:otherwise>
                            <span>무료</span>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div>
                    <span>장소 : </span> <span>${event.event_addr}${event.event_addrdetail}</span>
                </div>
            </section>
            <hr>
            <br>
            <section id="content" class="content">
                <div>${event.event_content}</div>
            </section>
            <section id="place" class="place">
                <div>
                    <h4>행사장소</h4>
                    <div>
                        <span id="loc">장소</span> <span>${event.event_addr}${event.event_addrdetail}</span>
                    </div>
                </div>
            </section>
            <section id="notice" class="notice">
                <c:choose>
                    <c:when test="${empty notice}">
                        <div>
                            <h4>공지/안내</h4>
                            <div class="notice_box">
                                <span>등록된 공지/안내가 없습니다.</span>
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <h4>공지/안내</h4>
                        <div class="notice-container">
                            <div class="notice-header">
                                <div class="notice-title">${notice.notice_title}</div>
                                <span class="notice-date" data-notice-date="${notice.notice_date}"></span>
                            </div>
                            <div class="notice-content" id="feedBody">
                                <div class="notice-content-body">${notice.notice_content}</div>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </section>
            <section id="ask" class="ask">
                <c:choose>
                    <c:when test="${empty qaList}">
                        <div>
                            <h4>
                                문의하기
                                <button type="button" class="modal_btn">호스트에게 문의하기</button>
                            </h4>
                            <div class="ask_box">
                                <span>등록된 문의가 없습니다.</span>
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div>
                            <h4>
                                문의하기
                                <button type="button" class="modal_btn">호스트에게 문의하기</button>
                            </h4>
                            <div class="ask_box_list">
                                <c:forEach var="qa" items="${qaList}">
                                    <div class="qa_box">
                                        <c:choose>
                                            <c:when test="${qa.qa_is_private eq 'N'}">
                                                ${qa.user_name} <span class="date">&nbsp;${qa.getFormattedQaDate()}&nbsp;</span>
                                                <c:if test="${qa.comments == null || qa.comments.isEmpty()}">
                                                    <span class="cmt"> 답변미완료</span>
                                                </c:if>
                                                <c:if test="${qa.comments != null && !qa.comments.isEmpty()}">
                                                    <span class="cmt"> 답변완료</span>
                                                    <c:if test="${currentUser.user_idx != event.user_idx}">
                                                        <button type="button" class="toggle_btn">▼</button>
                                                    </c:if>
                                                </c:if>
                                                <br>
                                                <p class="qa_content">${qa.qa_content}</p>
                                                <c:forEach var="comment" items="${qa.comments}">
                                                    <div class="comment" style="<c:if test='${currentUser.user_idx != event.user_idx}'>display: none;</c:if>">
                                                        <p id="host">
                                                            호스트 <span class="date">&nbsp;${comment.getFormattedCommentDate()}</span>
                                                            <c:if test="${currentUser != null && currentUser.user_idx == event.user_idx}">
                                                                <button type="button" class="deleteComment" data-comment-idx="${comment.comment_idx}">삭제</button>
                                                            </c:if>
                                                        </p>
                                                        <span class="comment_content">${comment.comment_content}</span>
                                                    </div>
                                                </c:forEach>
                                            </c:when>
                                            <c:otherwise>
                                                <c:choose>
                                                    <c:when test="${qa.canViewPrivate}">
                                                        ${qa.user_name} <span class="date">&nbsp;${qa.getFormattedQaDate()}&nbsp;</span>
                                                        <c:if test="${qa.comments == null || qa.comments.isEmpty()}">
                                                            <span class="cmt"> 답변미완료</span>
                                                        </c:if>
                                                        <c:if test="${qa.comments != null && !qa.comments.isEmpty()}">
                                                            <span class="cmt"> 답변완료</span>
                                                            <c:if test="${currentUser.user_idx != event.user_idx}">
                                                                <button type="button" class="toggle_btn">▼</button>
                                                            </c:if>
                                                        </c:if>
                                                        <br>
                                                        <p class="qa_content">${qa.qa_content}</p>
                                                        <c:forEach var="comment" items="${qa.comments}">
                                                            <div class="comment" style="<c:if test='${currentUser.user_idx != event.user_idx}'>display: none;</c:if>">
                                                                <p id="host">
                                                                    호스트 <span class="date">&nbsp;${comment.getFormattedCommentDate()}</span>
                                                                    <c:if test="${currentUser != null && currentUser.user_idx == event.user_idx}">
                                                                        <button type="button" class="deleteComment" data-comment-idx="${comment.comment_idx}">삭제</button>
                                                                    </c:if>
                                                                </p>
                                                                <span class="comment_content">${comment.comment_content}</span>
                                                            </div>
                                                        </c:forEach>
                                                    </c:when>
                                                    <c:otherwise>
                                                        ${qa.user_name} <span class="date">&nbsp;${qa.getFormattedQaDate()}&nbsp;</span>
                                                        <c:if test="${qa.comments == null || qa.comments.isEmpty()}">
                                                            <span class="cmt"> 답변미완료</span>
                                                        </c:if>
                                                        <c:if test="${qa.comments != null && !qa.comments.isEmpty()}">
                                                            <span class="cmt"> 답변완료</span>
                                                        </c:if>
                                                        <br>
                                                        <span>비공개 문의입니다<img class="lockicon" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAAAXNSR0IArs4c6QAAAYJJREFUSEvdlc1KAzEUhU+m+gQiIoIgCrr1FUTUnRvxHQRppJlNphvFnxnRtKSg7+DKnVChr+DCjSuLgogL8QV05mpKC0M7M5n+bcxqyM2cL/eem4RhzIONWR+5AGeXtR3mRHsgtmY2xIAGMVzJEr+1bdAKCJS+IMBNETqUgh9lQTIBQUXvEuGmLXBcCCeuzXdY+NkHUG7NM7YpS8X7NEgmwFf6AcAqiErSPajGRXylDeCEwOqeKG4NCggBOJP0Pe267mdc5LRanXUi552AL0/wqUEBZH78q3Nipr7SmfF2Q6RbZBOwxRMBQUVvEyEAsGJrwa74k+k2T/C7+HxP6r7SbwDm+hTvLG9KwRdtAGtdk+Bp5UrK4J8CYuZTkplDl8hX+gPATLv+PWYODQiUbhKwYAAEPHuCL3VdHYne5TbZr9Q2QFQ3ohGwXha8MVKAEcs6uUOXaJSAVwDzA57kFyl4y6fO6PGg1Y4RzsGw3BeE4ZEI0noX9SWaY7H1Tc6hkbnkF7fd0Blhx3I5AAAAAElFTkSuQmCC" /></span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:otherwise>
                                        </c:choose>
                                        <c:choose>
		                                	<c:when test="${qa.comments == null || qa.comments.isEmpty()}">
		                                 	<c:if test="${currentUser != null && currentUser.user_idx == event.user_idx}">
			                                    <div  class="comment_form" id="comment_form_${qa.qa_idx}">
			                                        <textarea id="comment_content_${qa.qa_idx}" rows="2" placeholder="문의사항에 대한 답변을 입력하세요." class="comment_textarea"></textarea>
			                                        <button type="button" class="submitComment" data-qa-idx="${qa.qa_idx}">답변등록</button>
			                                    </div>
		                               	 	</c:if>
		                                </c:when>
		                                </c:choose>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </section>
            <section id="contact" class="contact">
                <div>
                    <div>
                        <div class="contact_category">
                            <span>담당자</span>
                        </div>
                        <div class="contact_db" id="name">${event.event_contact_name}</div>
                    </div>
                    <div>
                        <div class="contact_category">
                            <span>이메일</span>
                        </div>
                        <div class="contact_db" id="email">${event.event_contact_email}</div>
                    </div>
                    <div>
                        <div class="contact_category">
                            <span>전화번호</span>
                        </div>
                        <div class="contact_db" id="tel">${event.event_contact_tel}</div>
                    </div>
                </div>
            </section>
            <section id="cancel" class="cancel">
                <div>
                    <h4>취소 및 환불규정</h4>
                    <div class="cancel_box">
                        <div>
                            <span>- <b>행사의 취소/환불 기간은</b> 행사 호스트가 설정한 신청기간과 동일합니다.
                            </span>
                        </div>
                        <div>
                            <span>- 신청한 행사의 <b>신청 정보 수정 및 취소/환불은</b> ‘마이페이지-신청 행사’에서 할
                                수 있습니다.
                            </span>
                        </div>
                        <div>
                            <span>- 결제 수단, 환불 신청 시점, 환불 사유에 따라 <b>환불 수수료가 부과</b>될 수
                                있습니다.
                            </span>
                        </div>
                        <div style="color: red;">
                            <span>*이벤터스는 통신판매 중개자이며, 해당 행사의 호스트가 아닙니다.</span>
                        </div>
                    </div>
                </div>
            </section>
        </div>
        <div class="apply_line">
            <div class="apply_box">
                <div class="apply_category">
                    <c:choose>
                        <c:when test="${event.event_sports_idx == 1}">
                            <a href="javascript:" onclick="location.href='event_list.do?event_loc=all&event_sports_idx=1'" id="sports">러닝</a>
                        </c:when>
                        <c:when test="${event.event_sports_idx == 2}">
                            <a href="javascript:" onclick="location.href='event_list.do?event_loc=all&event_sports_idx=2'" id="sports">철인3종</a>
                        </c:when>
                        <c:otherwise>
                            <a href="javascript:" onclick="location.href='event_list.do?event_loc=all&event_sports_idx=0'" id="sports">기타</a>
                        </c:otherwise>
                    </c:choose>
                    <span>|</span> <a href="javascript:" onclick="location.href='event_list.do?event_loc=${event.event_loc}'" id="loc">${event.event_loc}</a>
                </div>
                <div class="apply_name">
                    <span>${event.event_name}</span>
                </div>
                <div class="apply_ticket">
                    <div class="ticket_details">
                        <span class="ticketname">${event.event_ticketname}</span>
                        <div class="price">
                            <c:choose>
                                <c:when test="${event.event_price > 0}">
                                    <fmt:formatNumber value="${event.event_price}" type="number" groupingUsed="true" />원
                                </c:when>
                                <c:otherwise>
                                    <span>무료</span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
                <div class="remain" style="${event.event_ticket_open eq 'open' ? '' : 'display: none;'}">
                    <span>잔여수량 : ${remainticket}</span>
                </div>
                <input type="button" id="apply_btn" value="신청하기" onclick="location.href='event_apply.do?event_idx=${event.event_idx}'">
            </div>
        </div>
    </div>
    <div class="modal" style="display: none;">
        <div class="modal_popup">
            <input type="hidden" id="event_idx" name="event_idx" value="${event.event_idx}">
            <input type="hidden" id="user_idx" name="user_idx" value="${currentUser.user_idx}">
            <h3>호스트에게 문의하세요!</h3>
            <p>행사와 관련 없거나, 부적합한 내용이 기재되어 있을 경우 관리자에 의해 삭제되거나 차단 될 수 있습니다</p>
            <input type="checkbox" id="qa_is_private" name="qa_is_private">
            <label for="qa_is_private">비밀글로 문의하기</label>
            <textarea id="qa_content" name="qa_content" rows="4" placeholder="문의 사항이 자세할수록 더욱 정확한 답변을 받으실 수 있습니다."></textarea>
            <button type="button" class="close_btn">닫기</button>
            <button type="button" id="submitQuestion" class="submit_btn">문의하기</button>
        </div>
    </div>
</body>
</html>
