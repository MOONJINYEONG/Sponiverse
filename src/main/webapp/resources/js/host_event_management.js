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
		                    data: [100, 44], // 예시 데이터: 전체 참가자 수 100명, 내가 신청한 참가자 수 20명
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