<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>행사 정보 수정</title>

    <!-- css -->
    <link rel="stylesheet" href="/getspo/resources/css/host/host_event_modify.css">

    <!-- 폰트 설정 -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">

    <!-- 주소 찾기 -->
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script src="/getspo/resources/js/eventaddr.js"></script>

    <!-- 에디터 -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

    <!-- include summernote css/js -->
    <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>

    <!-- Cropper.js -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/cropperjs/1.5.12/cropper.min.css" rel="stylesheet">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/cropperjs/1.5.12/cropper.min.js"></script>

    <!-- ajax -->
    <script src="/getspo/resources/js/httpRequest.js"></script>
</head>

<body>
    <jsp:include page="host_event_navigation.jsp"/>
    <jsp:include page="host_sidebar.jsp"/>
    <form id="eventForm" class="new_event_form" method="post" action="host_event_update.do" enctype="multipart/form-data">
        <input type="hidden" name="event_idx" value="${event.event_idx}">
        <div class="form-group">
            <h2>행사 정보 수정</h2>
        </div>

        <div class="form-group" id="event_category_group">
            <h5>카테고리</h5>
            <select id="event_sport_idx" name="event_sports_idx" required>
                <option value="" disabled selected>종목 선택</option>
                <option value="1">러닝</option>
                <option value="2">철인3종</option>
                <option value="3">기타</option>
            </select>
            
            <select id="category_loc" name="event_loc" required>
                <option value="" disabled selected>지역 선택</option>
                <option value="서울">서울</option>
                <option value="경기">경기</option>
                <option value="인천">인천</option>
                <option value="대전">대전</option>
                <option value="대구">대구</option>
                <option value="부산">부산</option>
                <option value="울산">울산</option>
                <option value="광주">광주</option>
                <option value="강원">강원</option>
                <option value="충북">충북</option>
                <option value="충남">충남</option>
                <option value="경북">경북</option>
                <option value="경남">경남</option>
                <option value="전북">전북</option>
                <option value="전남">전남</option>
                <option value="세종">세종</option>
                <option value="제주">제주</option>
            </select>
        </div>

        <div class="form-group" id="event_name_group">
            <h5>행사명</h5>
            <input id="event_name" name="event_name" type="text" value="${event.event_name}" required>
        </div>

        <div class="form-group" id="event_date_group">
            <h5>행사 기간</h5>
            <div>
                <p class="start_date">시작 날짜</p>
                <input type="hidden" id="event_h_start" value="${event.event_h_start}">
                <input type="date" id="start_date" name="start_date" required>
                <input type="time" id="start_time" name="start_time" required>
            </div>
            <div>
                <p class="end_date">종료 날짜</p>
                <input type="hidden" id="event_h_end" value="${event.event_h_end}">
                <input type="date" id="end_date" name="end_date" required>
                <input type="time" id="end_time" name="end_time" required>
                <span id="endDateWarning"></span>
            </div>
            <p id="comment">* 종료날짜는 시작날짜 보다 뒤로 설정해주세요!</p>
        </div>

        <div class="form-group" id="apply_date_group">
            <h5>모집 기간</h5>
            <div>
                <p class="start_date">시작 날짜</p>
                <input type="hidden" id="event_r_start" value="${event.event_r_start}">
                <input type="date" id="apply_start_date" name="apply_start_date" value="" required>
                <input type="time" id="apply_start_time" name="apply_start_time" value="" required>
            </div>
            <div>
                <p class="end_date">종료 날짜</p>
                <input type="hidden" id="event_r_end" value="${event.event_r_end}">
                <input type="date" id="apply_end_date" name="apply_end_date" value="" required>
                <input type="time" id="apply_end_time" name="apply_end_time" value="" required>
                <span id="applyEndDateWarning"></span>
                <span id="totalWarning"></span>
            </div>
            <p id="comment">* 종료날짜는 시작날짜 보다 뒤로 설정해주세요!</p>
        </div>

        <div class="form-group" id="event_addr_group">
            <h5>행사 장소
                <input type="button" class="addr_btn" onclick="sample6_execDaumPostcode()" value="주소 찾기"><br>
            </h5>
            <input type="text" id="event_addrcode" name="event_addrcode" value="${event.event_addrcode}" placeholder="우편번호">
            <input type="text" id="event_addr" name="event_addr" value="${event.event_addr}" placeholder="주소">
            <input type="text" id="event_addrdetail" name="event_addrdetail" value="${event.event_addrdetail}" placeholder="상세주소">
        </div>

        <div class="form-group" id="event_content_group">
            <h5>행사 대표 이미지
                <input type="button" id="reset_button" style="display: none;" onclick="resetThumbnail()" value="재설정">
            </h5>
            <div id="thumbnail_preview">
                <img id="image">
            </div>
            <div class="thumbnail_group">
                <label for="thumbnail_image" id="thumbnail_label" style="cursor: pointer;">
                    썸네일 이미지 추가
                    <input type="file" id="thumbnail_image" name="photo" style="display: none;" onchange="handleFileChange(event)">
                </label>
                <div id="image_size">960*540px</div>
            </div>
            <br>
            <h5>행사 정보</h5>
            <div id="summernote">
                <textarea id="summernote_content" name="event_content" style="display:none;">${event.event_content}</textarea> 
            </div>
        </div>

        <!-- Cropper Modal -->
        <div class="modal fade" id="cropperModal" tabindex="-1" role="dialog" aria-labelledby="cropperModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="cropperModalLabel">이미지 크롭</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div>
                            <img id="cropperImage" src="#" alt="크롭할 이미지">
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
                        <button type="button" class="btn btn-primary" id="crop_button">이미지 크롭 완료</button>
                    </div>
                </div>
            </div>
        </div>

        <div class="form-group" id="entry_group">
            <h5>참가자 정보 수집
                <input type="button" class="add-item-btn" onclick="addNewItem()" value="새 항목 추가">
            </h5>
            <span>
                <input id="entry_name" name="user_name" type="checkbox" value="이름" checked disabled>
                <label for="entry_name">이름 *</label>
            </span>
            <span>
                <input id="entry_email" name="user_email" type="checkbox" value="이메일" checked disabled>
                <label for="entry_email">이메일 *</label>
            </span>
            <span>
                <input id="entry_tel" name="user_tel" type="checkbox" value="휴대전화번호" checked disabled>
                <label for="entry_tel">휴대전화번호 *</label>
            </span>
            <span>
                <input id="entry_age" name="user_age" type="checkbox" value="생년월일" checked disabled>
                <label for="entry_age">생년월일 *</label>
            </span>
            <span>
                <input id="entry_gender" name="user_sex" type="checkbox" value="성별" checked disabled>
                <label for="entry_gender">성별 *</label>
            </span>
        </div>  

        <div class="form-group" id="event_pay_group">
    <h5>결제방식</h5>
    <div class="radio-group">
        <input type="radio" id="free" name="event_paymethod" value="free" required>
        <label for="free">무료</label>
        <input type="radio" id="paid" name="event_paymethod" value="paid" required>
        <label for="paid">유료</label>
    </div>

    <div class="paid_choice" id="paid_choice">
        <select id="bank" name="event_bank">
            <option value="" disabled checked>은행 선택</option>
            <option value="kookmin">국민은행</option>
            <option value="shinhan">신한은행</option>
            <option value="nonghyup">농협중앙회</option>
            <option value="sinhyup">신협중앙회</option>
            <option value="hana">KEB하나은행</option>
            <option value="kakao">카카오뱅크</option>
        </select>
        <input id="event_account" name="event_account" type="text" placeholder="입금받을 계좌번호" value="${event.event_account}">
        <input id="event_account_name" name="event_account_name" type="text" placeholder="예금주 성명" value="${event.event_account_name}">
    </div>
</div>
		
		<div class="form-group" id="ticket_group">
		    <h5>티켓</h5>
		    <input id="ticket_name" name="event_ticketname" type="text" placeholder="티켓명" value="${event.event_ticketname}" required>
		    <input id="member_limit" name="event_max_joiner" type="number" min="1" step="1" placeholder="모집정원" value="${event.event_max_joiner}" required>
		    <input id="ticket_amount" name="event_price" type="number" min="0" max="1000000" step="1000" placeholder="티켓금액" value="${event.event_price}" required>
		
		    <div class="radio-group">
		        <p>잔여수량</p>
		        <input type="radio" id="remain_open" name="event_ticket_open" value="open" required checked="checked">
		        <c:if test="${event.event_ticket_open eq 'open'}"></c:if>
		        <label for="remain_open">공개</label>
		        <input type="radio" id="remain_close" name="event_ticket_open" value="close" required checked="checked">
		        <c:if test="${event.event_ticket_open eq 'close'}"></c:if>
		        <label for="remain_close">비공개</label>
		    </div>
		</div>

        <div class="form-group" id="contact_group">
            <h5>담당자 정보</h5>
            <p>담당자 이름</p>
            <input id="contact_name" name="event_contact_name" type="text" value="${event.event_contact_name}" required>
            <p>이메일 주소</p>
            <input id="contact_email" name="event_contact_email" type="text" value="${event.event_contact_email}" required>
            <p>전화번호</p>
            <input id="contact_tel" name="event_contact_tel" type="text" placeholder="(010)-0000-0000" value="${event.event_contact_tel}" required>
            <span id="contactTelWarning"></span>
        </div>

        <input type="submit" class="event_btn" value="수정 완료"> 
    </form>

    <script>
        /* 상세정보 입력창 관련 함수 */
        $(document).ready(function () {
            $('#summernote').summernote({
                codeviewFilter: false,
                codeviewIframeFilter: false,
                height: 500,
                minHeight: null,
                maxHeight: null,
                focus: false,
                lang: 'ko-KR',
                toolbar: [
                    ['style', ['style']],
                    ['fontsize', ['fontsize']],
                    ['font', ['bold', 'underline', 'clear']],
                    ['color', ['color']],
                    ['table', ['table']],
                    ['para', ['ul', 'ol', 'paragraph']],
                    ['height', ['height']],
                    ['insert', ['picture', 'link', 'video']],
                    ['view', ['codeview', 'fullscreen', 'help']],
                ],
                fontSizes: [
                    '8', '9', '10', '11', '12', '14', '16', '18',
                    '20', '22', '24', '28', '30', '36', '50', '72',
                ],
                styleTags: [
                    'p',
                    {
                        title: 'Blockquote',
                        tag: 'blockquote',
                        className: 'blockquote',
                        value: 'blockquote',
                    },
                    'pre',
                    {
                        title: 'code_light',
                        tag: 'pre',
                        className: 'code_light',
                        value: 'pre',
                    },
                    {
                        title: 'code_dark',
                        tag: 'pre',
                        className: 'code_dark',
                        value: 'pre',
                    },
                    'h1', 'h2', 'h3', 'h4', 'h5', 'h6',
                ],
                callbacks: {
                    onImageUpload: function (files, editor, welEditable) {
                        for (var i = files.length - 1; i >= 0; i--) {
                            uploadSummernoteImageFile(files[i], this);
                        }
                    },
                },
            });

            // 초기화 후 내용 설정
            $('#summernote').summernote('code', $('#summernote_content').val());

            // 폼 제출 이벤트 핸들러
            $('.new_event_form').on('submit', function() {
                var content = $('#summernote').summernote('code');
                $('#summernote_content').val(content);
            });
        });

        function uploadSummernoteImageFile(file, el) {
            var data = new FormData();
            data.append("file", file);
            $.ajax({
                data: data,
                type: "POST",
                url: "hostuploadSummernoteImageFile", // 서버의 이미지 업로드 엔드포인트
                contentType: false,
                enctype: 'multipart/form-data',
                processData: false,
                success: function(data) {
                    console.log("서버 응답:", data); // 서버 응답 확인을 위해 로그 출력
                    try {
                        var jsonResponse;
                        if (typeof data === "string") {
                            jsonResponse = JSON.parse(data);
                        } else {
                            jsonResponse = data;
                        }

                        if (jsonResponse.responseCode === "success") {
                            $(el).summernote('insertImage', jsonResponse.url);                  
                        } else {
                            alert("이미지 업로드에 실패했습니다.");
                        }
                    } catch (e) {
                        console.error("JSON 파싱 오류:", e);
                        alert("서버 응답을 처리하는 중 오류가 발생했습니다.");
                    }
                },
                error: function(jqXHR, textStatus, errorThrown) {
                    console.error("AJAX 오류:", textStatus, errorThrown);
                    alert("이미지 업로드 중 오류가 발생했습니다.");
                }
            });
        }
	
        //티켓결제관련
        document.addEventListener('DOMContentLoaded', function() {
	    const freeRadio = document.getElementById('free');
	    const paidRadio = document.getElementById('paid');
	    const paidChoice = document.getElementById('paid_choice');
	    const ticketAmount = document.getElementById('ticket_amount');
	    const bankSelect = document.getElementById('bank');
	    const eventAccount = document.getElementById('event_account');
	    const eventAccountName = document.getElementById('event_account_name');
	
	    // 함수 정의
	    function togglePaidFields() {
	        if (freeRadio.checked) {
	            paidChoice.style.display = 'none';
	            paidChoice.querySelectorAll('input, select').forEach(input => {
	                input.required = false;
	            });
	            ticketAmount.value = 0;
	            ticketAmount.disabled = true;
	        } else if (paidRadio.checked) {
	            paidChoice.style.display = 'block';
	            paidChoice.querySelectorAll('input, select').forEach(input => {
	                input.required = true;
	            });
	            ticketAmount.disabled = false;
	        }
	    }
	
	    // 초기 상태 설정
	    togglePaidFields();
	
	    // 이벤트 리스너 설정
	    freeRadio.addEventListener('change', togglePaidFields);
	    paidRadio.addEventListener('change', togglePaidFields);
	
	    // 결제방식 라디오 버튼 설정
	    const payMethodValue = "${event.event_paymethod}";
	    if (payMethodValue === 'free') {
	        freeRadio.checked = true;
	    } else if (payMethodValue === 'paid') {
	        paidRadio.checked = true;
	    }
	    togglePaidFields(); // 초기 상태 반영
	
	    // 은행 선택 설정
	    const eventBankValue = "${event.event_bank}";
	    if (eventBankValue) {
	        bankSelect.value = eventBankValue;
	    }
	
	    // 계좌번호와 예금주명 값 설정
	    eventAccount.value = "${event.event_account}";
	    eventAccountName.value = "${event.event_account_name}";
	});

        /* 참가자 정보 모집 새 항목 추가 함수 */
        function addNewItem() {
            const entryGroup = document.getElementById('entry_group');

            // 새로운 체크박스 항목 생성
            const newSpan = document.createElement('span');
            const newCheckbox = document.createElement('input');
            newCheckbox.type = 'checkbox';
            newCheckbox.name = 'entry';
            newCheckbox.value = '';
            newCheckbox.id = 'entry_new_' + document.querySelectorAll('#entry_group input[type="checkbox"]').length;

            const newInput = document.createElement('input');
            newInput.type = 'text';
            newInput.placeholder = '새 항목 입력';
            newInput.oninput = function() {
                newCheckbox.value = newInput.value;
            };

            const deleteButton = document.createElement('button');
            deleteButton.type = 'button';
            deleteButton.textContent = '삭제';
            deleteButton.onclick = function() {
                entryGroup.removeChild(newSpan);
            };

            newSpan.appendChild(newCheckbox);
            newSpan.appendChild(newInput);
            newSpan.appendChild(deleteButton);

            // 새로운 항목 추가
            entryGroup.appendChild(newSpan);
        }

        /* 이미지 파일 프리뷰 */
        var cropper;

        $('#cropperModal').on('shown.bs.modal', function(e) {
            cropper = new Cropper(document.getElementById('cropperImage'), {
                aspectRatio: 16 / 9,
                viewMode: 2
            });
        });

        $('#cropperModal').on('hidden.bs.modal', function(e) {
            if (cropper) {
                cropper.destroy();
                cropper = null;
            }
        });

        function handleFileChange(event) {
            var file = event.target.files[0];
            var reader = new FileReader();

            reader.onload = function(e) {
                document.getElementById('cropperImage').src = e.target.result;
                $('#cropperModal').modal('show');
            };

            reader.readAsDataURL(file);
        }

        document.getElementById('crop_button').addEventListener('click', function() {
            if (cropper) {
                var canvas = cropper.getCroppedCanvas({
                    width: 960,
                    height: 540,
                });

                var smallCanvas = document.createElement('canvas');
                var smallContext = smallCanvas.getContext('2d');
                smallCanvas.width = 200;
                smallCanvas.height = 113;
                smallContext.drawImage(canvas, 0, 0, 200, 113);

                var croppedImage = document.createElement('img');
                croppedImage.src = smallCanvas.toDataURL();

                var previewDiv = document.getElementById('thumbnail_preview');
                previewDiv.innerHTML = '';
                croppedImage.style.maxWidth = '100%';
                previewDiv.appendChild(croppedImage);

                $('#cropperModal').modal('hide');
                previewDiv.style.display = 'block';
                document.querySelector('.thumbnail_group').style.display = 'none';
                document.getElementById('reset_button').style.display = 'block';
                document.getElementById('delete_button').style.display = 'block';
            }
        });

        function resetThumbnail() {
            var thumbnailImageInput = document.getElementById('thumbnail_image');
            thumbnailImageInput.value = ''; // 초기화하여 다시 선택할 수 있도록 함
            thumbnailImageInput.click(); // 파일 선택 다이얼로그 표시

            thumbnailImageInput.onchange = function(event) {
                handleFileChange(event);
                thumbnailImageInput.onchange = handleFileChange; // 변경 이벤트 핸들러 복원
            };
        }
        
        /* 삭제 버튼 보류
        function deleteThumbnail() {
         var thumbnailImageInput = document.getElementById('thumbnail_image');
         thumbnailImageInput.value = ''; // 파일 입력 초기화
         document.getElementById('cropperImage').src = ''; // 크롭 이미지 초기화
         document.getElementById('image').src = ''; // 프리뷰 이미지 초기화
         document.getElementById('thumbnail_preview').innerHTML = ''; // 썸네일 미리보기 초기화
         document.getElementById('thumbnail_label').style.display = 'block'; // 썸네일 추가 버튼 다시 보이기
         document.getElementById('reset_button').style.display = 'none'; // 재설정 버튼 숨기기
         document.getElementById('delete_button').style.display = 'none'; // 삭제 버튼 숨기기
         document.getElementById('thumbnail_preview').style.display = 'none'; // 썸네일 미리보기 숨기기
         document.querySelector('.thumbnail_group').style.display = 'block'; // 썸네일 그룹 보이기
   	    }
        */

        // 카테고리 포워딩
        document.addEventListener('DOMContentLoaded', (event) => {
            const selectedSportIdx = "${event.event_sports_idx}"; // 서버에서 받아온 값을 여기 넣습니다.
            const selectElement = document.getElementById('event_sport_idx');
            
            for (const option of selectElement.options) {
                if (option.value === selectedSportIdx) {
                    option.selected = true;
                    break;
                }
            }
        });

        // 지역 바인딩한거 포워딩하기
        document.addEventListener('DOMContentLoaded', (event) => {
            const selectedLoc = "${event.event_loc}"; // 서버에서 받아온 값을 여기 넣습니다.
            const selectElement = document.getElementById('category_loc');
            
            for (const option of selectElement.options) {
                if (option.value === selectedLoc) {
                    option.selected = true;
                    break;
                }
            }
        });

        // 유효성 검사
        document.getElementById('eventForm').addEventListener('submit', function(event) {
            const startDate = new Date(document.getElementById('start_date').value);
            const endDate = new Date(document.getElementById('end_date').value);
            const applyStartDate = new Date(document.getElementById('apply_start_date').value);
            const applyEndDate = new Date(document.getElementById('apply_end_date').value);
            const contactTel = document.getElementById('contact_tel').value;
            
            const endDateWarning = document.getElementById('endDateWarning');
            const applyEndDateWarning = document.getElementById('applyEndDateWarning');
            const totalWarning = document.getElementById('totalWarning');
            const contactTelWarning = document.getElementById('contactTelWarning');
            
            let valid = true;
            
            if (startDate && endDate && endDate < startDate) {
                endDateWarning.textContent = "행사 종료 날짜는 시작 날짜 이후여야 합니다";
                valid = false;
            } else {
                endDateWarning.textContent = "";
            }

            if (applyStartDate && applyEndDate && applyEndDate < applyStartDate) {
                applyEndDateWarning.textContent = "모집 종료 날짜는 시작 날짜 이후여야 합니다";
                valid = false;
            } else {
                applyEndDateWarning.textContent = "";
            }

            if (applyStartDate && startDate && (applyStartDate > startDate || applyEndDate > startDate)) {
                totalWarning.textContent = "모집 날짜는 행사 시작 날짜 이전이어야 합니다";
                valid = false;
            } else {
                totalWarning.textContent = "";
            }
            
            let telpattern = /^\d{3}-\d{4}-\d{4}$/;
            if (!telpattern.test(contactTel)) {
                contactTelWarning.textContent = "올바른 전화번호를 입력하세요";
                valid = false;
            } else {
                contactTelWarning.textContent = "";
                console.log("올바른 전화번호");
            }
            if (!valid) {
                event.preventDefault();
            }
            
        });

        // 시간과 날짜를 분리하는 함수를 사용하기 위해 '행사 시작&종료 일시'와 '모집 시작&종료 일시를 가져옴.
        let E_h_s = document.getElementById("event_h_start").value;
        let E_h_e = document.getElementById("event_h_end").value;
        let E_r_s = document.getElementById("event_r_start").value;
        let E_r_e = document.getElementById("event_r_end").value;
        
        // 'T'를 기준으로 문자열을 나누기
        let parts_E_h_s = E_h_s.split('T', 2);
        let parts_E_h_e = E_h_e.split('T', 2);
        let parts_E_r_s = E_r_s.split('T', 2);
        let parts_E_r_e = E_r_e.split('T', 2);
        
        // 각각 변수에 저장
        let E_h_s_day = parts_E_h_s[0];
        let E_h_s_time = parts_E_h_s[1];
        
        let E_h_e_day = parts_E_h_e[0];
        let E_h_e_time = parts_E_h_e[1];
        
        let E_r_s_day = parts_E_r_s[0];
        let E_r_s_time = parts_E_r_s[1];

        let E_r_e_day = parts_E_r_e[0];
        let E_r_e_time = parts_E_r_e[1];
        
        // date 및 time 입력 필드에 값 설정
        document.getElementById("start_date").value = E_h_s_day;
        document.getElementById("start_time").value = E_h_s_time;
        
        document.getElementById("end_date").value = E_h_e_day;
        document.getElementById("end_time").value = E_h_e_time;
        
        document.getElementById("apply_start_date").value = E_r_s_day;
        document.getElementById("apply_start_time").value = E_r_s_time;
        
        document.getElementById("apply_end_date").value = E_r_e_day;
        document.getElementById("apply_end_time").value = E_r_e_time;
        
     	// 라디오 버튼 선택된 값 설정
        document.addEventListener('DOMContentLoaded', function() {
            // 잔여수량 라디오 버튼 설정
            const ticketOpenValue = "${event.event_ticket_open}";
            if (ticketOpenValue === 'open') {
                document.getElementById('remain_open').checked = true;
            } else if (ticketOpenValue === 'close') {
                document.getElementById('remain_close').checked = true;
            }

            // 결제방식 라디오 버튼 설정
            const payMethodValue = "${event.event_paymethod}";
            if (payMethodValue === 'free') {
                document.getElementById('free').checked = true;
            } else if (payMethodValue === 'paid') {
                document.getElementById('paid').checked = true;
            }
        });
    </script>
</body>
</html>
