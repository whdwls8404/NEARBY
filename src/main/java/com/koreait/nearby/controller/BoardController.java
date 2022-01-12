package com.koreait.nearby.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.koreait.nearby.domain.Board;
import com.koreait.nearby.domain.Follow;
import com.koreait.nearby.domain.Likes;
import com.koreait.nearby.domain.Member;
import com.koreait.nearby.service.BoardService;

@Controller
@RequestMapping("board")
public class BoardController {
  
	   private BoardService service;
	   
	   @Autowired
	   public BoardController(BoardService service) {
	      super();
	      this.service = service;
	   }
	   
	   // 전체 리스트
	   @GetMapping("boardList")
	   public String boardList(Model model, HttpSession session) {
	      model.addAttribute("list", service.selectBoardList());
	      return "board/board";
	   }
	   
	   // 로그인 유저가 각 게시물 좋아요 표시 확인위한 bNo 전달
	   @GetMapping(value="boardBnoList",  produces ="application/json; charset=UTF-8")
	   @ResponseBody
	   public Map<String, Object> boardBnoList(@RequestParam Long bNo, HttpSession session){
		  return  service.boardBnoList(bNo, session);
	   }
	   

	    // 등록하는 곳으로가기
	   @GetMapping(value="insertPage")
	   public String insertPage() {
	      return "board/insert";
	   }
	   
	   
	   // 등록하기
	   @PostMapping(value="insertBoard")
	   public void insertBoard(MultipartHttpServletRequest multipartRequest, HttpServletResponse response) {
	      service.insertBoard(multipartRequest, response);
	   }
	   
	   // 상세보기
	   @GetMapping("selectBoard")
	   public String selectBoard(@RequestParam Long bNo, Model model) {
	      Board board = service.selectBoardByNo(bNo);
	      model.addAttribute("board", board);
	      return "board/selectView";
	   }
	   
	   
	    // 수정하러가기
	   @GetMapping("updateBoardPage")
	   public String updateBoardPage(@RequestParam Long bNo, Model model) {
	      Board board = service.selectBoardByNo(bNo);
	      model.addAttribute("board", board);
//	      System.out.println("보드 수정하기 : "+board.toString());
	      return "board/boardUpdate";
	   }
	   
	   // 수정하기
	   @PostMapping("updateBoard")
	   public void updateBoard(MultipartHttpServletRequest multipartRequest, HttpServletResponse response) {
	      service.updateBoard(multipartRequest, response);
	   }
	   
	   
	   
	   // 삭제하기
	   @GetMapping("deleteBoard")
	   public void deleteBoard(HttpServletRequest request, HttpServletResponse response) {
	      service.deleteBoard(request, response);
	      
	   }
	   
	   // 좋아요
	   @ResponseBody
	   @PostMapping(value="likes", produces ="application/json; charset=UTF-8" )
	    public Board likes(@RequestParam Long bNo, HttpSession session) {
//		   System.out.println("controller bNo" + bNo);
		   Likes likes = new Likes();
		   likes.setbNo(bNo); // 좋아요 한 게시글 번호
		   Member user = (Member)session.getAttribute("loginUser");
		   likes.setId(user.getId()); // 좋아요 한 유저 아이디
		   
		   Board board = service.likes(likes, session);
		  return board;
	   }

	   // 좋아요 취소하기
	   @ResponseBody
	   @PostMapping(value="likesCancel",  produces ="application/json; charset=UTF-8")
	   public Board likesCancel(@RequestParam Long bNo, HttpSession session){
		   System.out.println("controller bNo" + bNo);
		   Likes likes = new Likes();
		   likes.setbNo(bNo); // 좋아요 한 게시글 번호
		   Member user = (Member)session.getAttribute("loginUser");
		   likes.setId(user.getId()); // 좋아요 한 유저 아이디
		   
		   Board board = service.likesCancel(likes, session);
		  return board;	 
       }
	  
		// 통합 검색
	    @GetMapping("searchBoardList")
	    public String searchBoardList(Model model, HttpServletRequest request) {
	       model.addAttribute("list", service.searchBoardList(request));
	       model.addAttribute("query", request.getParameter("query"));
	       model.addAttribute("profileList", service.searchProfileList(request));
	       return "board/search";
	    }	
	    

	    /* myHome 이동 및 유저의 게시물 갯수 구하기 */
		@GetMapping("myHome")
		public String myHome(HttpServletRequest request, Model model) {
			request.getSession().setAttribute("userBoardCount", service.selectUserBoardsCount(request));
			request.getSession().setAttribute("list", service.selectMyHomeList(request));
			model.addAttribute("followingList", service.userFollowingIdById(request));
			model.addAttribute("followedList", service.userFollowedIdById(request));
			return "board/myHome";
		}
	    
		/* 해당 유저의 홈으로 가기 */
		@GetMapping("selectUserHome")
			public String selectUserHome (@RequestParam("id")String id, Model model) {
			System.out.println("Controller Request param ID : " +  id);
			model.addAttribute("user", service.selectUserHome(id));
			model.addAttribute("followingList", service.selectFollowingIdById(id));
			model.addAttribute("followedList", service.selectFollowedIdById(id));
			model.addAttribute("userBoardCount", service.selectUserHomeBoardsCount(id));
			model.addAttribute("userId", id);
			System.out.println("userId@@@@@" + id);
			System.out.println("@@@ 내가 어떻게 담았나 ? " + model);
			
			return "board/userHome";
		}

	    
}
