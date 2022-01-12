package com.koreait.nearby.repository;


import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.koreait.nearby.domain.Reply;

@Repository
public interface ReplyRepository {

	public List<Reply> selectReplyList(Long bNo);
	public List<Reply> selectReplyListForPaging(Map<String, Object> map);
	public int selectTotalCountPerBoard(Long bNo);
	public int insertReply(Reply reply);
	public int updatePreviousReplyGroupOrd(Reply reply);
	public int updateReply(Reply reply);
	public int deleteReply(Long rNo);
	
}
