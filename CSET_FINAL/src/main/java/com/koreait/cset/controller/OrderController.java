package com.koreait.cset.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.koreait.cset.command.order.OrderCartQuickCommand;
import com.koreait.cset.command.order.OrderInsertCommand;
import com.koreait.cset.command.order.OrderListPageCommand;
import com.koreait.cset.command.order.OrderProductQuickCommand;
import com.koreait.cset.common.CsetCommand;

@Controller
public class OrderController {
	
	// Field
	@Autowired
	private SqlSession sqlSession;
		
	@RequestMapping("orderListPage")
	public String orderListPage(HttpServletRequest request
			, Model model) {
		model.addAttribute("request", request);
		CsetCommand csetCommand = new OrderListPageCommand();
		csetCommand.execute(sqlSession, model);
		return "order/orderListPage";
	}
	
	/* 장바구니에서 바로 주문 페이지로 하나만 넘기기 */
	@RequestMapping("cOrderQuick")
	public String cOrderQuickInsert(HttpServletRequest request,
									Model model) {
		model.addAttribute("request", request);
		CsetCommand csetCommand = new OrderCartQuickCommand();
		csetCommand.execute(sqlSession, model);
		return "order/orderListPage";
	}
	
	@RequestMapping("orderInsert")
	public String orderInsert(HttpServletRequest request, Model model) {
		model.addAttribute("request", request);
		CsetCommand csetCommand = new OrderInsertCommand();
		csetCommand.execute(sqlSession, model);
		return "order/orderResultPage";
	}
	
	
	@RequestMapping("pOrderQuick")
	public String pOrderQuick(HttpServletResponse response,
							  HttpServletRequest request,
							  Model model) {
		model.addAttribute("request", request);
		model.addAttribute("response", response);
		CsetCommand csetCommand = new OrderProductQuickCommand();
		csetCommand.execute(sqlSession, model);
		return "order/orderListPage";
	}
	
	

}
