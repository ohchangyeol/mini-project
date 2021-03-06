package com.model2.mvc.view.user;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.framework.Action;
import com.model2.mvc.service.user.UserService;
import com.model2.mvc.service.user.impl.UserServiceImpl;


public class ListUserAction extends Action {

	@Override
	public String execute(HttpServletRequest request,	HttpServletResponse response) throws Exception {

		Search search=new Search();
		
		int currentPage=1;

		System.out.println("= request.getParameter(\"currentPage\")의 정보 = " + request.getParameter("currentPage"));
		System.out.println("= request.getParameter(\"currentPage\")가 null이 아니라면 ture , null이라면 false ----결과 값 [" + (request.getParameter("currentPage") != null)+"]");
		System.out.println("= \" \"이 getSearchCondition()랑 일치하지 않다면 = [" + !("".equals(request.getParameter("currentPage")))+"]");
			
		if(request.getParameter("currentPage") != null&& !("".equals(request.getParameter("currentPage")))){
			currentPage=Integer.parseInt(request.getParameter("currentPage"));
		}
		
		search.setCurrentPage(currentPage);
		search.setSearchCondition(request.getParameter("searchCondition"));
		search.setSearchKeyword(request.getParameter("searchKeyword"));
		
		// web.xml  meta-data 로 부터 상수 추출 
		int pageSize = Integer.parseInt( getServletContext().getInitParameter("pageSize"));
		int pageUnit  =  Integer.parseInt(getServletContext().getInitParameter("pageUnit"));
		search.setPageSize(pageSize);
		
		// Business logic 수행
		UserService userService=new UserServiceImpl();
		Map<String , Object> map=userService.getUserList(search);
		
		Page resultPage	= 
					new Page( currentPage, ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println("ListUserAction ::"+resultPage);
		
		// Model 과 View 연결
		request.setAttribute("list", map.get("list"));
		request.setAttribute("resultPage", resultPage);
		request.setAttribute("search", search);
		
		return "forward:/user/listUser.jsp";
	}
}