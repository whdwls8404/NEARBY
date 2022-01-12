package com.koreait.nearby.repository;


import java.util.Map;

import com.koreait.nearby.domain.Likes;

public interface LikesRepository {
   public int likeCheck(Map<String, Object> map);
   public int likeCheckCancel(Map<String, Object> map);
	
   public int likeInsert(Likes like);
   public Likes likeSelectByNO(Likes likes);

}
