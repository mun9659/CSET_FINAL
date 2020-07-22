<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>${param.pageTitle}</title>

<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
<script type="text/javascript" src="resources/assets/script/common.js"></script>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css">
<link rel="stylesheet" type="text/css" href="resources/assets/style/common.css" />

<style type="text/css">

.main-nav > ul li a:hover {
	background: lightsteelblue;
} 


</style>

</head>
<body>
	<header>
		<div class="top-header">		
			<div class="top-banner"></div>
			<div class="logo-box">
				<form action="productsOrderByDynamic">
					<button type="submit" class="queryBtn">
						<i class="fas fa-search"></i>
					</button>
					<input type="text" name="searchBox"/>
				</form>
				<a class="logo" href="/cset/">Clothes-Set</a>
				<ul class="top-nav">
					<c:if test="${loginDTO eq null}">
						<li><a href="memberLoginPage">로그인</a></li>
						<li><a href="memberInsertPage">회원가입</a></li>
					</c:if>
					<c:if test="${loginDTO ne null }">
						<li><a href="memberLogout">로그아웃</a></li>
						<li><a href="memberLeavePage">회원 탈퇴</a></li>		
						<li><a href="memberViewPage">마이페이지</a></li>
						<li><a href="cartListPage">장바구니</a></li>
					</c:if>
				</ul>
			</div>
			<div class="nav-box">
				<nav class="main-nav">
					<ul>
						<li><a href="/cset">TOP10</a></li>
						<li class="dropdown a">
							<a class="dropbtn a" href="productsListPage?pCategory='상의'">상의</a>
							<div class="dropdown-content a">
								<a href="productsListPage?pCategory_sub='티셔츠'">티셔츠</a>
								<a href="productsListPage?pCategory_sub='맨투맨후드'">후드/맨투맨</a>
								<a href="productsListPage?pCategory_sub='셔츠'">셔츠</a>
								<a href="productsListPage?pCategory_sub='남방'">남방</a>
							</div>
						</li>
						<li class="dropdown b">
							<a class="dropbtn b" href="productsListPage?pCategory='하의'">하의</a>
							<div class="dropdown-content b">
								<a href="productsListPage?pCategory_sub='청바지'">청바지</a>
								<a href="productsListPage?pCategory_sub='슬랙스'">슬랙스</a>
								<a href="productsListPage?pCategory_sub='면바지'">면바지</a>
								<a href="productsListPage?pCategory_sub='반바지'">반바지</a>
							</div>
						</li>
						<li class="dropdown c">
							<a class="dropbtn c" href="productsListPage?pCategory='아우터'">아우터</a>
							<div class="dropdown-content c">
								<a href="productsListPage?pCategory_sub='자켓'">자켓</a>
								<a href="productsListPage?pCategory_sub='코트'">코트</a>
								<a href="productsListPage?pCategory_sub='롱패딩'">롱패딩</a>
								<a href="productsListPage?pCategory_sub='숏패딩'">숏패딩</a>
							</div>
						</li>
						<li class="dropdown d">
							<a class="dropbtn d" href="productsListPage">브랜드</a>
							<div class="dropdown-content d">
								<a href="productsListPage?pBrand='아디다스'">아디다스</a>
								<a href="productsListPage?pBrand='나이키'">나이키</a>
								<a href="productsListPage?pBrand='페이탈리즘'">페이탈리즘</a>
								<a href="productsListPage?pBrand='피스워커'">피스워커</a>
								<a href="productsListPage?pBrand='무신사'">무신사 스탠다드</a>
								<a href="productsListPage?pBrand='기능성'">기능성 티</a>
							</div>
						</li>						
						<li class="dropdown e">
							<a class="dropbtn e" href="boardListPage">게시판</a>
							<div class="dropdown-content e">
								<a href="boardListPage?bClass=0">공지사항</a>
								<a href="boardListPage?bClass=1">Q&amp;A</a>
								<a href="boardListPage?bClass=2">FAQ</a>
							</div>
						</li>
					</ul>
				</nav>	
			</div>
		</div>
			
	</header>