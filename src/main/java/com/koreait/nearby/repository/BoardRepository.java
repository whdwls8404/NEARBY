package com.koreait.nearby.repository;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.koreait.nearby.domain.Board;
import com.koreait.nearby.domain.Likes;
import com.koreait.nearby.domain.Profile;

@Repository
public interface BoardRepository {
   public List<Board> selectListBoard();
   public Board selectBoardByNo(Long bNo);
   public int insertBoard(Board board);
   public int updateBoard(Board board);
   public int deleteBoard(Map<String, Object> map);
   
// 통합 검색
   public List<Board> searchListBoard(Map<String, Object> map);
   // ID만 검색
   public List<Profile> searchProfileList(Map<String, Object> map);
   
   /* myHome 유저의 게시물 목록 가져오기 */
   public List<Board> selectMyHomeList(String id);
   
   /* myHome 및 유저의 게시물 갯수 구하기 */
   public int selectUserBoardsCount(String id);
   
   // 좋아요 관련 
   // 1. 좋아요 추가
   public int boardLike(Board board);
   // 2. 좋아요 삭제
   public int boardLikeCancel(Board board);
   // 3. 좋아요 총 수
   public Board boardLikesCount(Board board);
   
   // 로그인 유저가 각 게시물 좋아요 표시 확인위한 bNo 전달
   public int selectLikePerBoard(Map<String, Object> map);
   
   
   // 관리자
   public List<Board> adminBoardList();
   // 관리자 글삭제
   public int adminBoardDelete(Long bNo);
   
   /* userHome */
   public List<Board> selectUserHome(String id);
   
}
