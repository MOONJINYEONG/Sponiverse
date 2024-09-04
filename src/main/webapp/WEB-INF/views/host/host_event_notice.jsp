<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>행사 공지/안내 페이지</title>
<!-- css -->
<link rel="stylesheet" href="/getspo/resources/css/host/host_event_notice.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">


</head>
<body>
    <jsp:include page="host_event_navigation.jsp"/>
    <jsp:include page="host_sidebar.jsp"/>
    
     <form class="event_notice">
        <div class="notice_header">
            <h2>
                공지/안내 작성하기
                <c:choose>
                    <c:when test="${not empty notice }">
                        <input type="button" value="수정하기" onclick="showModal('edit')" class="notice_btn">
                    </c:when>
                    <c:otherwise>
                        <input type="button" value="작성하기" onclick="showModal('new')" class="notice_btn">
                    </c:otherwise>
                </c:choose>
            </h2>
            <p>공지/안내할 내용을 작성해주세요.</p>
        </div>
        <c:choose>
            <c:when test="${empty notice}">
                <div id="no_notice_message">등록된 공지/안내가 없습니다.</div>
            </c:when>
            <c:otherwise>
                <div class="notice_content">
                    <div>
                       <span id="write_date">${notice.formattedNoticeDate}</span>   
                        <img id="image" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAAAXNSR0IArs4c6QAAAIJJREFUSEtjZKAxYKSx+QwjyIKOvon+//8zdDAwMPz/z8BQUlWcv42Y4CU6iNp7Jz5hYGCQhhp6r7I4X5naFjxkYGCQgxr6oLI4X5GqFkCDqIuBkeHH//8MlVQPImJci00N0XFAcwtGUxHBIB5NRcQG0WhZhDukRlMRwVRErgKal6YA5vdXGfdrqV8AAAAASUVORK5CYII=" />
                    </div>
                    <div id="delete_menu" role="menu" tabindex="0" style="display: none;">
                        <div id="menu-1">
                             <a href="#" id="mynotice" onclick="deleteNotice(${notice.notice_idx})">삭제하기</a>
                        </div>
                    </div>
                    <h3 id="notice_title">${notice.notice_title}</h3>
                    <div id="notice_content_body">${notice.notice_content}</div>
                </div>
            </c:otherwise>
        </c:choose>
    </form>

    <!-- Modal -->
    <div class="modal fade" id="noticeModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">공지/안내 작성하기</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form>
                    <div class="form-group">
                        <label for="modal-title" class="col-form-label">제목</label>
                        <input type="text" class="form-control" id="modal-title">
                    </div>
                    <div class="form-group">
                        <label for="modal-content" class="col-form-label">내용</label>
                        <textarea class="form-control" id="modal-content"></textarea>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
                <button type="button" class="btn btn-primary" onclick="saveNotice()">공지하기</button>
            </div>
        </div>
    </div>
</div>

    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script>
       let isEditMode = false;
       
       function showModal(mode) {
          isEditMode = (mode === 'edit');
           if (isEditMode) {
               document.getElementById('modal-title').value = '${notice.notice_title}';
               document.getElementById('modal-content').value = '${notice.notice_content}';
           } else {
               document.getElementById('modal-title').value = '';
               document.getElementById('modal-content').value = '';
           }
           $('#noticeModal').modal('show');
       }

       function saveNotice() {
           let title = document.getElementById('modal-title').value;
           let content = document.getElementById('modal-content').value;
           let url = isEditMode ? 'updateNotice.do' : 'saveNotice.do';
           
           if (title && content) {
               $.ajax({
                   url: url,
                   method: 'POST',
                   data: {
                       event_idx: ${event.event_idx},
                       notice_title: title,
                       notice_content: content
                   },
                   success: function(response) {
                       if (response === 'success') {
                           // 페이지 새로고침
                           location.reload();
                       } else {
                           alert('공지사항 저장에 실패했습니다.');
                       }
                   },
                   error: function() {
                       alert('공지사항 저장 중 오류가 발생했습니다.');
                   }
               });
           } else {
               alert('제목과 내용을 입력해주세요.');
           }

           $('#noticeModal').modal('hide');
       }

        
        document.addEventListener('DOMContentLoaded', function() {
           const image = document.getElementById('image');
            const menu = document.getElementById('delete_menu');

            image.addEventListener('click', function(event) {
               // 메뉴가 보이고 있는 경우 숨기기
                if (menu.style.display === 'block') {
                    menu.style.display = 'none';
                } else {
                    // 메뉴가 숨겨져 있는 경우 표시하기
                    menu.style.display = 'block';
                    menu.style.top = event.target.offsetTop + event.target.offsetHeight + 'px';
                    menu.style.left = event.target.offsetLeft + 'px';
                }
            });

            document.addEventListener('click', function(event) {
                if (event.target.id !== 'image' && !menu.contains(event.target)) {
                    menu.style.display = 'none';
                }
            });
           
            var noticeTitle = document.getElementById('notice_title').innerText;
            var noticeContent = document.getElementById('notice_content_body').innerText;
            if (!noticeTitle && !noticeContent) {
                document.querySelector('.notice_content').style.display = 'none';
                document.getElementById('no_notice_message').style.display = 'block';
            } else {
                document.querySelector('.notice_content').style.display = 'block';
                document.getElementById('no_notice_message').style.display = 'none';
            }
        });
        
        function deleteNotice(notice_idx) {
            if (confirm("정말 삭제하시겠습니까?")) {
                $.ajax({
                    url: 'deleteNotice.do',
                    type: 'POST',
                    data: { notice_idx: notice_idx },
                    success: function(response) {
                        if (response === 'success') {
                            alert("공지사항이 삭제되었습니다.");
                            location.reload();
                        } else if(response === 'fail'){
                            alert("공지사항 삭제에 실패했습니다.");
                        }
                    },
                    error: function() {
                        alert("공지사항 삭제 중 오류가 발생했습니다.");
                    }
                });
            }
        }
                
    </script>
</body>
</html>
