package com.koreait.cset.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.koreait.cset.dto.ProductsDTO;
import com.koreait.cset.dto.StockDTO;

public interface ProductsDAO {
	// 1.판매량 순
	public ArrayList<ProductsDTO> productsOrderByRank();
	// 2. 상품 목록 가져오기	
	public ArrayList<ProductsDTO> productsSelectList( @Param("pCategory") String pCategory
													, @Param("pCategory_sub") String pCategory_sub
													, @Param("pBrand") String pBrand);
	// 3. 동적 검색으로 상품 재검색
	public ArrayList<ProductsDTO> productsOrderByDynamic( @Param("pCategoryList") String[] pCategoryList													
														, @Param("pCategory_subList") String[] pCategory_subList
														, @Param("pBrandList") String[] pBrandList
														, @Param("searchBox") String searchBox
														, @Param("searchOrderBy") String searchOrderby);
	// 4. 상품 선택
	public ProductsDTO productsSelectBypNo( int pNo );
	
	// 5. 관리자 페이지 검색
	public ArrayList<ProductsDTO> productsSearch( @Param("searchBox") String searchBox );
	
	// 6. 상품 재고 조회
	public ArrayList<StockDTO> stockSelectBypNo( int pNo );
	
	// 7. 상품 사이즈별 재고 조회
	public int stockSelectBypNopSize(String pSize,int pNo);
	
	
}
