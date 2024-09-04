package com.kh.getspo;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.JsonObject;

import dao.EventDAO;
import dao.UserDAO;
import util.Common;
import util.Paging;
import vo.CommentVO;
import vo.EventVO;
import vo.NoticeVO;
import vo.QaVO;
import vo.UserVO;

@Controller
public class EventController {

   @Autowired
   HttpServletRequest request;
   @Autowired
   HttpSession session;

   @Autowired
   ServletContext app;

   @Autowired
   EventDAO event_dao;

   @Autowired
   UserDAO user_dao;

   public EventController(EventDAO event_dao, UserDAO user_dao) {
      this.event_dao = event_dao;
      this.user_dao = user_dao;
   }

   // 공통 메서드: 행사 정보를 가져오고 모델에 추가
   private void addEventDetailsToModel(int event_idx, Model model) {
      EventVO event = event_dao.eventByIdx(event_idx);
      int appliecount = event_dao.applieCount(event_idx);
      int remainticket = event.getEvent_max_joiner() - appliecount;

      List<Integer> viewedEvents = (List<Integer>) session.getAttribute("viewedEvents");
      if (viewedEvents == null) {
         viewedEvents = new ArrayList<>();
      }

      if (!viewedEvents.contains(event_idx)) {
         event_dao.update_viewcount(event_idx);
         viewedEvents.add(event_idx);
         session.setAttribute("viewedEvents", viewedEvents);
      }

      model.addAttribute("event", event);
      model.addAttribute("remainticket", remainticket);
   }

   // 행사 전체보기
   @RequestMapping("/event_list.do")
   public String event_list(Model model, String page, String search_text, String event_loc, Integer event_sports_idx) {
      int nowPage = 1;
      if (page != null && !page.isEmpty()) {
         nowPage = Integer.parseInt(page);
      }

      // 한 페이지에 표시되는 게시물의 시작과 끝 번호를 계산
      // ?page=2
      int start = (nowPage - 1) * Common.Board.BLOCKLIST + 1;
      int end = start + Common.Board.BLOCKLIST - 1;

      // start, end변수를 Map저장
      Map<String, Object> map = new HashMap<String, Object>();
      map.put("start", start);
      map.put("end", end);

      // 검색어 관련 파라미터
      // list.do?search_text=abc&page=2

      // 검색어가 있는 경우
      if (search_text != null && !search_text.isEmpty()) {
         map.put("event_loc", search_text);
         map.put("event_name", search_text);
         map.put("event_content", search_text);
         map.put("event_addr", search_text);
         map.put("event_addrdetail", search_text);
         map.put("event_h_start", search_text);
         map.put("event_r_start", search_text);
      }

      // event_loc 파라미터 처리
      if (event_loc != null && !event_loc.equals("all")) {
         // 여러 지역을 처리하기 위해 리스트로 변환
         String[] locations = event_loc.split("_");
         List<String> locationList = new ArrayList<>();
         for (String loc : locations) {
            locationList.add(loc);
         }
         map.put("event_loc_list", locationList);
      } else {
         map.put("event_loc_list", null);
      }

      // event_sport_idx 파라미터 처리
      if (event_sports_idx != null) {
         map.put("event_sports_idx", event_sports_idx);
      } else {
         map.put("event_sports_idx", null);
      }

      // 전체목록 가져오기
      List<EventVO> events = event_dao.allevents(map);

      // 전체 게시글 수 가져오기
      int row_total = event_dao.eventcount(map);

      // 페이지 메뉴 생성
      String search_param = "";
      if (search_text != null && !search_text.isEmpty()) {
         search_param = String.format("search_text=%s", search_text);
      }
      if (event_loc != null && !event_loc.isEmpty()) {
         if (!search_param.isEmpty()) {
            search_param += "&";
         }
         search_param += String.format("event_loc=%s", event_loc);
      }
      if (event_sports_idx != null) {
         if (!search_param.isEmpty()) {
            search_param += "&";
         }
         search_param += String.format("event_sports_idx=%d", event_sports_idx);
      }

      // 페이징 처리 문자열 생성
      String pageMenu = Paging.getPaging("event_list.do", nowPage, row_total, search_param, Common.Board.BLOCKLIST,
            Common.Board.BLOCKPAGE);

      // 모델에 데이터 추가
      model.addAttribute("events", events);
      model.addAttribute("pageMenu", pageMenu);
      model.addAttribute("totalEvent", row_total);// 전체 이벤트 수
      model.addAttribute("selectedLoc", event_loc); // 선택된 옵션 값을 모델에 추가
      model.addAttribute("selectedSport", event_sports_idx); // 선택된 종목 값을 모델에 추가
      // 조회수 증가를 위해 기록되있던 show정보를 삭제
      session.removeAttribute("show");

      // JSP 페이지로 포워딩
      return Common.Event.VIEW_PATH + "event_list.jsp";
   }

   // 행사 상세보기 페이지
   @RequestMapping("/event_detail.do")
   public String eventDetail(@RequestParam("event_idx") int event_idx, Model model) {
      // 세션에서 현재 사용자 정보 가져오기
       UserVO currentUser = (UserVO) session.getAttribute("user");
      
      // 해당 이벤트정보 가져오기
      EventVO event = event_dao.eventByIdx(event_idx);

      // 이벤트에 신청된 수 계산
      int appliecount = event_dao.applieCount(event_idx);

      // 잔여 수량 계산
      int remainticket = event.getEvent_max_joiner() - appliecount;

      // 세션에서 조회한 이벤트 번호 목록 가져오기
      List<Integer> viewedEvents = null; // 세션에서 가져올 이벤트 번호 목록을 담을 변수 선언
      Object obj = session.getAttribute("viewedEvents"); // 세션에서 "viewedEvents"라는 이름으로 저장된 객체 가져오기
      if (obj instanceof List) { // 가져온 객체가 List<Integer> 타입인지 확인
         viewedEvents = (List<Integer>) obj; // 만약 List<Integer> 타입이면 캐스팅하여 변수에 할당
      }

      if (viewedEvents == null) { // 만약 세션에서 가져온 객체가 null이면 (세션에 "viewedEvents"가 없는 경우)
         viewedEvents = new ArrayList<>(); // 새로운 ArrayList<Integer> 객체를 생성하여 변수에 할당 (새로운 세션에 저장할 준비)
      }

      // 이벤트가 이미 조회되었는지 확인
      if (!viewedEvents.contains(event_idx)) { // 현재 조회하려는 이벤트 번호가 이미 세션에 있는지 확인
         // 조회수 증가
         event_dao.update_viewcount(event_idx); // 이벤트의 조회수를 증가시키는 메서드 호출
         // 조회한 이벤트 번호를 세션에 추가
         viewedEvents.add(event_idx); // 조회한 이벤트 번호를 세션에 추가
         session.setAttribute("viewedEvents", viewedEvents); // 업데이트된 조회 이벤트 목록을 세션에 다시 저장
      }

      // 공지사항 조회
      NoticeVO notice = event_dao.noticeByIdx(event_idx);
      
      // 문의하기 조회
      List<QaVO> qaList = event_dao.qalist(event_idx);
      
      // 각 QaVO에 대해 작성자와 행사 개최자 여부 확인
      for (QaVO qa : qaList) { // qaList의 각 QaVO 객체를 순회
    	    // 현재 QaVO가 비공개인지와 currentUser가 null이 아닌지를 확인
    	    if (qa.isPrivate() && currentUser != null) {
    	        // currentUser가 이 QaVO의 소유자인지 확인
    	        boolean isOwner = qa.getUser_name().equals(currentUser.getUser_name());
    	        // currentUser가 이 이벤트의 호스트인지 확인
    	        boolean isHost = event.getUser_idx() == currentUser.getUser_idx();
    	        // 소유자이거나 호스트인 경우에만 비공개 내용을 볼 수 있게 설정
    	        qa.setCanViewPrivate(isOwner || isHost);
    	    } else {
    	        // 비공개 내용을 볼 수 없게 설정
    	        qa.setCanViewPrivate(false);
    	    }
    	    
    	    // 댓글 조회
    	    List<CommentVO> comments = event_dao.getCommentsByQaIdx(qa.getQa_idx()); // qa의 댓글을 조회
    	    qa.setComments(comments); // 조회한 댓글을 qa에 설정
    	}
      
      // 바인딩
      model.addAttribute("event", event);
      model.addAttribute("remainticket", remainticket);
      model.addAttribute("notice", notice);
      model.addAttribute("qaList", qaList);      
      model.addAttribute("currentUser", currentUser); // 현재 사용자 정보 바인딩
      return Common.Event.VIEW_PATH + "event_detail.jsp";
   }

   // 행사 신청 페이지
   @RequestMapping("/event_apply.do")
   public String eventApply(@RequestParam("event_idx") int event_idx, Model model) {

      // 해당 이벤트정보 가져오기
      EventVO event = event_dao.eventByIdx(event_idx);

      // 바인딩
      model.addAttribute("event", event);

      addEventDetailsToModel(event_idx, model);
      return Common.Event.VIEW_PATH + "event_apply.jsp";
   }

   // 행사 개설 페이지
   @RequestMapping("/event_new.do")
   public String event_form() {
      return Common.Event.VIEW_PATH + "event_new.jsp";
   }

   // 행사 개설하기
   @RequestMapping("/event_insert.do")
   public String event_insert(@ModelAttribute EventVO vo,
         @RequestParam("start_date") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate startDate,
         @RequestParam("start_time") @DateTimeFormat(iso = DateTimeFormat.ISO.TIME) LocalTime startTime,
         @RequestParam("end_date") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate endDate,
         @RequestParam("end_time") @DateTimeFormat(iso = DateTimeFormat.ISO.TIME) LocalTime endTime,
         @RequestParam("apply_start_date") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate applyStartDate,
         @RequestParam("apply_start_time") @DateTimeFormat(iso = DateTimeFormat.ISO.TIME) LocalTime applyStartTime,
         @RequestParam("apply_end_date") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate applyEndDate,
         @RequestParam("apply_end_time") @DateTimeFormat(iso = DateTimeFormat.ISO.TIME) LocalTime applyEndTime,
         @RequestParam("event_content") String event_content) {

      try {
         UserVO user = (UserVO) session.getAttribute("user");
         if (user != null) {
            vo.setUser_idx(user.getUser_idx());

            // 이벤트 시작 종료 시간 설정
            LocalDateTime eventHStart = LocalDateTime.of(startDate, startTime);
            LocalDateTime eventHEnd = LocalDateTime.of(endDate, endTime);
            LocalDateTime eventRStart = LocalDateTime.of(applyStartDate, applyStartTime);
            LocalDateTime eventREnd = LocalDateTime.of(applyEndDate, applyEndTime);

            vo.setEvent_h_start(eventHStart);
            vo.setEvent_h_end(eventHEnd);
            vo.setEvent_r_start(eventRStart);
            vo.setEvent_r_end(eventREnd);
            vo.setEvent_content(event_content);

            // 파일업로드 경로설정
            String webPath = "/resources/upload/";
            // upload까지의 절대경로
            String savePath = app.getRealPath(webPath);
            System.out.println(savePath);

            // 업로드 된 파일 정보
            MultipartFile photo = vo.getPhoto();

            String filename = "no_file";
            if (photo != null && !photo.isEmpty()) {
               filename = photo.getOriginalFilename();

               // 파일을 저장할 경로 생성
               File saveFile = new File(savePath, filename);

               if (!saveFile.exists()) {
                  saveFile.mkdirs();
               } else {
                  // 동일파일명이 존재하는 경우 업로드 시간을 추가하여 중복을 방지
                  long time = System.currentTimeMillis();
                  filename = String.format("%d_%s", time, filename);
                  saveFile = new File(savePath, filename);
               }

               try {
                  photo.transferTo(saveFile);
               } catch (IllegalStateException e) {
                  e.printStackTrace();
               } catch (IOException e) {
                  e.printStackTrace();
               }
            }

            vo.setEvent_thumbnail(filename);

            event_dao.eventInsert(vo);

            return "hostMain.do";
         }
      } catch (Exception e) {
         e.printStackTrace();
      }

      return "redirect:hostMain.do";
   }

   // 썸머노트
   @RequestMapping(value = "/uploadSummernoteImageFile", produces = "application/json; charset=utf8")
   @ResponseBody
   public String uploadSummernoteImageFile(@RequestParam("file") MultipartFile multipartFile,
         HttpServletRequest request) {
      JsonObject jsonObject = new JsonObject();

      // 내부경로로 저장
      String contextRoot = new HttpServletRequestWrapper(request).getRealPath("/");
      String fileRoot = contextRoot + "resources/fileupload/";
      System.out.println("파일루트 경로: " + fileRoot);

      String originalFileName = multipartFile.getOriginalFilename(); // 오리지날 파일명
      String extension = originalFileName.substring(originalFileName.lastIndexOf(".")); // 파일 확장자
      String savedFileName = UUID.randomUUID() + extension; // 저장될 파일 명

      File targetFile = new File(fileRoot + savedFileName);
      try (InputStream fileStream = multipartFile.getInputStream()) {
         // 파일 저장
         FileUtils.copyInputStreamToFile(fileStream, targetFile);
         jsonObject.addProperty("url", request.getContextPath() + "/resources/fileupload/" + savedFileName);
         jsonObject.addProperty("responseCode", "success");
      } catch (IOException e) {
         // 저장된 파일 삭제
         FileUtils.deleteQuietly(targetFile);
         jsonObject.addProperty("responseCode", "error");
         e.printStackTrace();
      }

      return jsonObject.toString();
   }

   // 행사신청내역 페이지
   @RequestMapping("/applyEvent_list.do")
   public String applyEvent_list() {
      return Common.Mypage.VIEW_PATH + "mypage.jsp";
   }
   
   //행사 문의하기
   @RequestMapping("/question.do")
   @ResponseBody
   public String questionEvent(int user_idx, int event_idx, String qa_content, String qa_is_private) {
      // 세션에서 사용자 정보 가져오기
       UserVO user = (UserVO) session.getAttribute("user");
       // 사용자 정보가 없는 경우 처리
       if (user == null) {
           return "no_user"; // 사용자가 로그인하지 않은 상태
       }
    
       String userName = user.getUser_name();
       String userEmail = user.getUser_email();
       
       QaVO vo = new QaVO();
       vo.setUser_idx(user_idx);
       vo.setEvent_idx(event_idx);
       vo.setUser_name(userName);
       vo.setUser_email(userEmail);
       vo.setQa_content(qa_content);
       vo.setQa_is_private(qa_is_private);
       
       int res = event_dao.insertQa(vo);
       
       if(res > 0) {
          return "success";
       }else {
          return "fail";
       }
   
   }
   
   @RequestMapping("/add_comment.do")
   @ResponseBody
   public String addComment(int qa_idx, String comment_content) {
       // 로그 추가
       System.out.println("addComment called with qa_idx: " + qa_idx + ", comment_content: " + comment_content);
       
       // 세션에서 현재 사용자 정보 가져오기
       UserVO user = (UserVO) session.getAttribute("user");
       if (user == null) {
           System.out.println("No user logged in");
           return "no_user"; // 사용자가 로그인하지 않은 상태
       }

       // qa_idx로 문의 가져오기
       QaVO qa = event_dao.getQaByIdx(qa_idx);
       if (qa == null) {
           System.out.println("No question found for qa_idx: " + qa_idx);
           return "no_question"; // 해당 문의가 존재하지 않는 경우
       }

       // 이벤트 개최자인지 확인
       EventVO event = event_dao.eventByIdx(qa.getEvent_idx());
       if (event == null || event.getUser_idx() != user.getUser_idx()) {
           System.out.println("User is not the host for event_idx: " + qa.getEvent_idx());
           return "no_permission"; // 이벤트 개최자가 아닌 경우
       }

       // 댓글 저장 로직 추가
       CommentVO comment = new CommentVO();
       comment.setQa_idx(qa_idx);
       comment.setUser_idx(user.getUser_idx());
       comment.setComment_content(comment_content);

       int res = event_dao.insertComment(comment);

       if (res > 0) {
           return "success";
       } else {
           return "fail";
       }
   }
   
   @RequestMapping("/delete_comment.do")
   @ResponseBody
   public String deleteComment(int comment_idx) {
       // 댓글 삭제 로직 추가
       int res = event_dao.deleteComment(comment_idx);

       if (res > 0) {
           return "success";
       } else {
           return "fail";
       }
   }
   

}









