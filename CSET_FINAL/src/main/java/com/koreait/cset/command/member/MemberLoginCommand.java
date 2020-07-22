package com.koreait.cset.command.member;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.koreait.cset.common.CsetCommand;
import com.koreait.cset.dao.MemberDAO;
import com.koreait.cset.dao.OrderDAO;
import com.koreait.cset.dto.MemberDTO;

public class MemberLoginCommand implements CsetCommand {

   @Override
   public void execute(SqlSession sqlSession, Model model)  {
      Map<String, Object> map = model.asMap();
      HttpServletRequest request = (HttpServletRequest)map.get("request");
      HttpServletResponse response = (HttpServletResponse)map.get("response");
      
   
      String mId = request.getParameter("mId");
      String mPw = request.getParameter("mPw");
      
      // MemberDTO
      MemberDTO mDTO = new MemberDTO();
      mDTO.setmId(mId);
      mDTO.setmPw(mPw);
      MemberDAO mDAO = sqlSession.getMapper(MemberDAO.class);
      OrderDAO oDAO = sqlSession.getMapper(OrderDAO.class);
      HttpSession session = null;
      
      
      MemberDTO loginDTO =mDAO.selectBymIdmPw(mDTO);
      //총주문금액
      int totalPrice = oDAO.orderSumMoney(mId);
      int gradeChangeLimit = 100000;
   
         
      
      if(loginDTO != null) { // 검색된 회원이 있으면
         char abc = loginDTO.getmGrade();
         String nowGrade =Character.toString(abc);
               
         char nextGrade;
         if(totalPrice<100000) {
            nextGrade ='C';
             gradeChangeLimit = 100000;
         }else if(totalPrice<400000) {
            nextGrade ='B';
            gradeChangeLimit = 400000;
         }else if(totalPrice<700000) {
            nextGrade ='A';
            gradeChangeLimit = 700000;
         }else {
            nextGrade ='A';
            gradeChangeLimit = 1000000;
         }
         
         if(nowGrade.equals("D")) {
            nextGrade ='C';
             gradeChangeLimit = 100000;
         }else if(nowGrade.equals("C")) {
            nextGrade ='B';
             gradeChangeLimit = 400000;
         }else if(nowGrade.equals("B")) {
            nextGrade ='A';
             gradeChangeLimit = 700000;
         }else if(nowGrade.equals("A")) {
            nextGrade ='A';
             gradeChangeLimit = 1000000;
         }
         
         
         // ** 세션에 회원정보 올리기 **
         session = request.getSession();
         session.setAttribute("loginDTO", loginDTO); // 로그인에 성공하면 회원정보가 session에 저장.
         session.setAttribute("totalPrice", totalPrice);
         session.setAttribute("nextGrade", nextGrade);
         session.setAttribute("gradeChangeLimit", gradeChangeLimit);
      
         
      }  else {
         PrintWriter out;
         try {
            response.setContentType("text/html; charset=utf-8");
            out = response.getWriter();
            out.println("<script type='text/javascript'>");
            out.println("alert('아이디와 비밀번호를확인해주세요');");
            out.println("history.back();");
            out.println("</script>");
            out.close();
         } catch (IOException e) {
            
            e.printStackTrace();
         }
      }
      
      
   
   }

}