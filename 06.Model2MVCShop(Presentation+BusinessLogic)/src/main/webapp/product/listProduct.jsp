<%@ page contentType="text/html; charset=euc-kr" %>
<%--
<%@ page import="java.util.*"  %>
<%@ page import="com.model2.mvc.common.*" %>
<%@ page import="com.model2.mvc.service.domain.*" %>
<%@ page import="com.model2.mvc.common.util.CommonUtil"%>
<%@ page import="com.model2.mvc.common.Page"%>
 --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
<%
	Search search=(Search)request.getAttribute("search");
	
	String urlMenu = request.getParameter("menu");
	System.out.println("= List Product :: "+ urlMenu);
	
	List<Product> list= (List<Product>)request.getAttribute("list");
	Page resultPage=(Page)request.getAttribute("resultPage");
	
	//==> null 을 ""(nullString)으로 변경
	String searchCondition = CommonUtil.null2str(search.getSearchCondition());
	String searchKeyword = CommonUtil.null2str(search.getSearchKeyword());
%>
 --%>
<html>
<head>
<c:choose>
	<c:when test="${param.menu == 'search'}">
		<title>상품 목록 조회</title>	
	</c:when>
	<c:otherwise>
		<title>상품 관리</title>
	</c:otherwise>
</c:choose>
<link rel="stylesheet" href="/css/admin.css" type="text/css">

<script type="text/javascript">
function fncGetUserList(currentPage){
	console.log(currentPage);
	document.getElementById("currentPage").value = currentPage;
	document.detailForm.submit();
}
</script>
</head>

<body bgcolor="#ffffff" text="#000000">

<div style="width:98%; margin-left:10px;">

<form name="detailForm" action="/listProduct.do?menu=${param.menu}" method="post">

<table width="100%" height="37" border="0" cellpadding="0"	cellspacing="0">
	<tr>
		<td width="15" height="37">
			<img src="/images/ct_ttl_img01.gif" width="15" height="37">
		</td>
		<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left:10px;">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<c:choose>
						<c:when test="${param.menu == 'search'}">
							<td width="93%" class="ct_ttl01">상품 목록 조회</td>	
						</c:when>
						<c:otherwise>
							<td width="93%" class="ct_ttl01">상품 관리</td>
						</c:otherwise>
					</c:choose>
					
				</tr>
			</table>
		</td>
		<td width="12" height="37">
			<img src="/images/ct_ttl_img03.gif" width="12" height="37">
		</td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<tr>
		<td align="right">
			<select name="searchCondition" class="ct_input_g" style="width:80px">
				<option value="0" ${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>상품명</option>
				<option value="1" ${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>상품번호</option>
			</select>
			<input 	type="text" name="searchKeyword"  value="${! empty search.searchKeyword ? search.searchKeyword : ""}" 
							class="ct_input_g" style="width:200px; height:19px" >
		</td>
		<td align="right" width="70">
			<table border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td width="17" height="23">
						<img src="/images/ct_btnbg01.gif" width="17" height="23">
					</td>
					<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top:3px;">
						<a href="javascript:fncGetProductList('1');">검색</a>
					</td>
					<td width="14" height="23">
						<img src="/images/ct_btnbg03.gif" width="14" height="23">
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top:10px;">
	<td colspan="11" >
		전체  ${resultPage.totalCount} 건수,	현재 ${resultPage.currentPage} 페이지
	</td>
	<tr>
		<td class="ct_list_b" width="100">No</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">상품명</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b" width="150">가격</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">등록일</td>
		<td class="ct_line02"></td>
		<td class="ct_list_b">현재상태</td>		
	</tr>
	<tr>
		<td colspan="11" bgcolor="808285" height="1"></td>
	</tr>
	<%--
	<%
		for(int i=0; i<list.size(); i++) {
			Product vo = list.get(i);
	%>
	
	<tr class="ct_list_pop">
		<td align="center"><%= i + 1 %></td>
		<td></td>
		<td align="left">
			<%if(urlMenu.equals("manage")){%>
			<a href="/updateProductView.do?prodNo=<%=vo.getProdNo() %>"><%= vo.getProdName() %></a>
			<%}else{%> 
				<a href="/getProduct.do?prodNo=<%=vo.getProdNo() %>"><%= vo.getProdName() %></a>
			<%} %>
		</td>
		<td></td>
		<td align="left"><%= vo.getPrice() %></td>
		<td></td>
		<td align="left"><%= vo.getRegDate() %>	</td>		
		<td></td>
		<td align="left">
			<% if(vo.getProTranCode() == null){ %>
				판매중
			<% } %>
		</td>
	</tr>
	<tr>
		<td colspan="11" bgcolor="D6D7D6" height="1"></td>
	</tr>
	<% } %> --%>
	<c:set var="i" value="0" />
	<c:forEach var ="product" items="${list}">
		<c:set var="i" value="${ i+1 }" />
		<tr class="ct_list_pop">
			<td align="center">${i} </td>
			<td></td>
			<td align="left">
			<c:if test="${param.menu == 'manage'}">
				<c:choose>
					<c:when test="${empty product.prodTranCode}">
						<a href="/updateProductView.do?prodNo=${product.prodNo}">${product.prodName}</a>
					</c:when>
					<c:otherwise>
						${product.prodName}
					</c:otherwise>
				</c:choose>
				
			</c:if>
			<c:if test="${param.menu == 'search'}">
				<c:choose>
					<c:when test="${empty product.prodTranCode}">
						<a href="/getProduct.do?prodNo=${product.prodNo}">${product.prodName}</a>
					</c:when>
					<c:otherwise>
						${product.prodName}
					</c:otherwise>
				</c:choose>
				
			</c:if>
			</td>
			<td></td>
			<td align="left">${product.price}</td>
			<td></td>
			<td align="left">${product.regDate}</td>		
			<td></td>
			<td align="left">
			<c:if test="${param.menu == 'manage'}">
				<c:choose>
					<c:when test="${empty product.prodTranCode}">
						판매중
					</c:when>
					<c:when test="${product.prodTranCode == '1  '}">
						구매 완료  <a href="/updateTranCodeByProd.do?prodNo=${product.prodNo}&menu=${param.menu}" onclick="return confirm('선택 하신 상품 ${vo.prodName}을 배송 하시겠습니까?')">배송하기</a>
					</c:when>
					<c:when test="${product.prodTranCode == '2  '}">
						배송중
					</c:when>
					<c:otherwise>
						재고없음
					</c:otherwise>
				</c:choose>
			</c:if>
			<c:if test="${param.menu == 'search'}">
				<c:choose>
					<c:when test="${empty product.prodTranCode}">
						판매중
					</c:when>
					<c:otherwise>
						재고없음
					</c:otherwise>
				</c:choose>
			</c:if>
			</td>
		</tr>
		<tr>
			<td colspan="11" bgcolor="D6D7D6" height="1"></td>
		</tr>
	</c:forEach>
</table>

<!-- PageNavigation Start... -->
<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top:10px;">
	<tr>
		<td align="center">
		   <input type="hidden" id="currentPage" name="currentPage" value=""/>
		   <%--
			<% if( resultPage.getCurrentPage() <= resultPage.getPageUnit() ){ %>
					◀ 이전
			<% }else{ %>
					<a href="javascript:fncGetProductList('<%=resultPage.getCurrentPage()-1%>')">◀ 이전</a>
			<% } %>

			<%	for(int i=resultPage.getBeginUnitPage();i<= resultPage.getEndUnitPage() ;i++){	%>
					<a href="javascript:fncGetProductList('<%=i %>');"><%=i %></a>
			<% 	}  %>
	
			<% if( resultPage.getEndUnitPage() >= resultPage.getMaxPage() ){ %>
					이후 ▶
			<% }else{ %>
					<a href="javascript:fncGetProductList('<%=resultPage.getEndUnitPage()+1%>')">이후 ▶</a>
			<% } %>
			 --%>
			<jsp:include page="../common/pageNavigator.jsp"/>
			<%-- <c:choose>
				<c:when test="${resultPage.currentPage <= resultPage.pageUnit}">
				◀ 이전
				</c:when>
				<c:otherwise>
				<a href="javascript:fncGetProductList('${resultPage.currentPage -1 }')">◀ 이전</a>
				</c:otherwise>
			</c:choose>
			<c:forEach var="i" end="${(resultPage.endUnitPage)}" begin="${resultPage.beginUnitPage}">
			<a href="javascript:fncGetProductList('${i}');">${i}</a>	
			</c:forEach>
			<c:choose>
				<c:when test="${resultPage.endUnitPage >= resultPage.maxPage}">
				이후 ▶
				</c:when>
				<c:otherwise>
				<a href="javascript:fncGetProductList('${resultPage.endUnitPage + 1 }')">이후 ▶</a>
				</c:otherwise>
			</c:choose> --%>
		
    	</td>
	</tr>
</table>
<!-- PageNavigation End... -->
<!--  페이지 Navigator 끝 -->
</form>
</div>

</body>
</html>