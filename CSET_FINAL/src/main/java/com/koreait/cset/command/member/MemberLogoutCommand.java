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
import com.koreait.cset.dto.MemberDTO;

public class MemberLogoutCommand implements CsetCommand {

	@Override
	public void execute(SqlSession sqlSession, Model model) {
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest)map.get("request");
		HttpServletResponse response = (HttpServletResponse)map.get("response");
		
		// session 에 저장된 로그인 유저의 정보를 삭제.
				HttpSession session = request.getSession();
				MemberDTO loginDTO = (MemberDTO) session.getAttribute("loginDTO");
				if(loginDTO != null) { // 정상적인 로그아웃을 했다면
					// session의 회원정보 초기화
					session.invalidate();
				
				}else { // 비정상적
					response.setContentType("text/html; charset=utf-8");
					PrintWriter out;
					try {
						out = response.getWriter();
						out.println("<script type='text/javascript'>");
						out.println("alert('로그인 된 회원이 정보가 없습니다.');");
						out.println("history.back();");
						out.println("</script>");
						out.close();
					} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
	}

}
