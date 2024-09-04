document.addEventListener("DOMContentLoaded", function() {
        var userButton = document.querySelector('.user-button');
        var menuItems = document.getElementById('menu-items');

        // 클릭 이벤트 리스너 설정
        userButton.addEventListener('click', function(event) {
            event.stopPropagation(); // 클릭 이벤트 전파 방지
            toggleMenu(); // 메뉴 바 토글 함수 호출
        });

        // 메뉴 바 이외의 영역 클릭 시 메뉴 바 숨김
        document.addEventListener('click', function(event) {
            var targetElement = event.target; // 클릭된 요소

            // 메뉴 바가 열려 있고, 클릭된 요소가 메뉴 바 내부가 아니면 메뉴 바 숨김
            if (menuItems.style.display === 'block' && !menuItems.contains(targetElement)) {
                menuItems.style.display = 'none';
            }
        });

        // 메뉴 바 토글 함수
        function toggleMenu() {
            if (menuItems.style.display === 'none' || menuItems.style.display === '') {
                menuItems.style.display = 'block';
            } else {
                menuItems.style.display = 'none';
            }
        }
    });
