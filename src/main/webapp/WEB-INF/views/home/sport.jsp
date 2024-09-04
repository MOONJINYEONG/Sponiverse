<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
   <head>
      <meta charset="UTF-8"> 
      <title>종목 메뉴</title>
      
      <link rel="stylesheet" href="/getspo/resources/css/home/sport.css">
      
   </head>
   
   <body>
      <div class="sport">
            <h4 class="menu_title">종목별 스포츠 행사</h4>
            <h6 class="menu_subtitle">참가하고 싶은 종목의 행사들을 한번에 볼 수 있어요!</h6>
         
            <a href="javascript:" onclick="sport_running(this.form);">
               <img src="/getspo/resources/img/sport_img/러닝 픽토그램.png">
            </a> 
            
            <a href="javascript:" onclick="sport_triathlon(this.form);">
               <img src="/getspo/resources/img/sport_img/철인3종 픽토그램.png">
            </a> 
            
            <a href="javascript:" onclick="sport_etc(this.form);"> 
               <img src="/getspo/resources/img/sport_img/기타 픽토그램.png">
            </a>
      </div>
   </body>
</html>