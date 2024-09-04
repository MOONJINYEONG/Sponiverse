<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>배너</title>

<!-- Swiper.com에서 스와이퍼 쓰려고 가져옴 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />
<script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>

<!-- 기타 css 수정 -->
<link rel="stylesheet" href="/getspo/resources/css/home/banner.css" />
</head>

<body>
   <swiper-container class="mySwiper"
      pagination="true" pagination-clickable="true" navigation="true" slidesPerView="1" space-between="30" loop="true"
      centered-slides="true" autoplay-delay="3000" effect="fade"> <!-- grabCursor="true" pauseOnMouseEnter="true" 얘네 두개는 왜 적용안될까요? -->
      <swiper-slide><img class="banner_img" src="resources/img/banner/광고배너(마라톤).png" /></swiper-slide>
      <swiper-slide><img class="banner_img" src="resources/img/banner/광고배너(축구).png" /></swiper-slide>
      <swiper-slide><img class="banner_img" src="resources/img/banner/광고배너(테니스).png" /></swiper-slide>
      <swiper-slide><img class="banner_img" src="resources/img/banner/광고배너(라이딩).png" /></swiper-slide>
      <swiper-slide><img class="banner_img" src="resources/img/banner/광고배너(배구).png" /></swiper-slide>
      
   </swiper-container>

   <script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-element-bundle.min.js"></script>
   
   <!-- Initialize Swiper -->
   <script>
      var swiper = new Swiper(".mySwiper", {
         pagination: {
            el: ".swiper-pagination",
            clickable: true,
         },
         
         navigation: {
            nextEl: ".swiper-button-next",
            prevEl: ".swiper-button-prev",
         },
         
       });
   </script>
</body>
<!-- 07/10 이전에 만든 배너의 js참조  
<script src="/getspo/resources/js/slide.js"></script>
 -->
</html>