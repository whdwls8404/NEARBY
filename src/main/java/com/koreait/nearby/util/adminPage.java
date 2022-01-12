package com.koreait.nearby.util;

public class adminPage {
	// 게시물 수 관련 
		private int totalRecord;
		private int recordPerPage = 20;    // 한페이지에 표시하는 게시글 수   
		private int totalPage;			   // 전체 페이지 수 
		
		// 게시글 수  관련 
		private int page;   			  // 현재 페이지 번호
		private int beginRecord;
		private int endRecord;
		
		// 페이지 번호 표시 관련
		private int pagePerBlock = 5;   // 각 블록에 표시되는 페이지 수 < 1 2 3 4 5  >
		private int beginPage;
		private int endPage;
		
		
		
		public void setPageEntity(int cnt, int page) {
			this.totalRecord = cnt;   // cnt 현재 총 게시물 수 
			this.page = page;    // page 현재 페이지 번호 
			
			// totalPage 
			totalPage = cnt / recordPerPage;   // 현재 총 게시물 수 / 2 = 5 
			if (cnt % recordPerPage != 0) {   // 나머지 1있어서  => totalPage 는 6개 
				totalPage++;
			}
			
			// beginRecord~endReord => 각 페이지에 나타나는 게시물번호
			 beginRecord = (page-1) * recordPerPage + 1;
			
			 endRecord = beginRecord + recordPerPage - 1;
			 endRecord = (cnt < endRecord) ? cnt : endRecord;
			
			 // block의 페이지 번호
			 beginPage = ((page-1) / pagePerBlock) * pagePerBlock+1;
			 endPage = beginPage + pagePerBlock - 1;
			 endPage = (totalPage < endPage) ? totalPage : endPage;

		}
						// 주소값을 보내서 이미지보드, qna보드, 공지사항 보드 한번에 처리 가능하게 만든다!
		public String getPageEntity(String path) {
			StringBuilder sb = new StringBuilder();

			// 이전 페이지 이동
			if(page <= 1) {
				sb.append("<span class=\"page_prev enable pageNo\">PREV</span>&nbsp;");
			} else  {
				if( path.contains("?")) {
					sb.append("<a class=\"page_prev pageNo disable\"  href=\""+path+"&page="+(page-1)+"\">PREV</a>");
				} else {
					sb.append("<a  class=\"page_prev pageNo disable\" href=\""+path+"?page=" + (page - 1) + "\">PREV</a>");
				}
			}
			
			// 페이지를 누르면 페이지로 이동 
			for (int i = beginPage; i <= endPage; i++) {
				if (page == i) {
					sb.append("<span class=\"pageNo enable nowPage\">&nbsp"+i + "&nbsp;</span>");
				} else {
					if( path.contains("?")) {
						sb.append("<a class=\"pageNo disable\" href=\""+path+"&page=" + i + "\">&nbsp;" + i + "&nbsp;</a>");					
					} else {
						sb.append("<a class=\"pageNo disable\"  href=\""+path+"?page=" + i + "\">&nbsp;" + i + "&nbsp;</a>");
					}
				}
			}
			// 다음 페이지 이동 
			if(page == totalPage) {
				sb.append("<span class=\"page_next enable pageNo\">&nbsp;NEXT</span>");
			} else {
				if(path.contains("?")){
					sb.append("<a class=\"page_next pageNo disable\"  href=\""+path +"&page="+(page+1)+"\">&nbsp;NEXT</a>");
				}
				 else {
						sb.append("<a  class=\"page_next pageNo disable\"  href=\""+path+"?page=" + (page+1) + "\">&nbsp;NEXT</a>");
					}
			}
			return sb.toString();
		}
		
		
		
		public int getPagePerBlock() {
			return pagePerBlock;
		}
		public void setPagePerBlock(int pagePerBlock) { 
			this.pagePerBlock = pagePerBlock;
		}
		public int getBeginPage() {
			return beginPage;
		}
		public void setBeginPage() {   /* 수정 */
			beginPage = ((page-1) / pagePerBlock) * pagePerBlock +1;
		}
		public int getEndPage() {
			return endPage;
		}
		public void setEndPage() {     /* 수정 */
			endPage = beginPage + pagePerBlock -1;
			if ( endPage > totalPage ) {
				endPage = totalPage;
			}
		}

		
		public int getPage() {
			return page;
		}
		public void setPage(int page) {
			this.page = page;
		}

		public int getBeginRecord() {
			return beginRecord;
		}
		public void setBeginRecord() {   /* 수정 */
			beginRecord = (page - 1)*recordPerPage+1;
		}
		public int getEndRecord() {
			return endRecord;
		}
		public void setEndRecord() {      /* 수정 */
			endRecord = beginRecord + recordPerPage -1;
			if( endRecord > totalRecord) {    //  endRecord 계산식을 이용하면 전체 게시글 수보다 초과될 수 있기 때문에 endRecord에 totalRecord로 대입해야한다!
				endRecord = totalRecord;
			}
		}
		
		
		public int getTotalRecord() {
			return totalRecord;
		}
		
		public void setTotalRecord(int totalRecord) {
			this.totalRecord = totalRecord;
		}
		public int getRecordPerPage() {
			return recordPerPage;
		}
		public void setRecordPerPage(int recordPerPage) {
			this.recordPerPage = recordPerPage;
		}
		public int getTotalPage() {
			return totalPage;
		}
		
		public void setTotalPage() {  /* 수정 */
			totalPage = totalRecord / recordPerPage ;     
			if(totalRecord % recordPerPage != 0) {
				totalPage++;
			}
		}
}
