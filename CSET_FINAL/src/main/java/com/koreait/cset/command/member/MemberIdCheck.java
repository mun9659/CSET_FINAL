package com.koreait.cset.command.member;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONObject;
import org.springframework.ui.Model;

import com.koreait.cset.common.CsetCommand;
import com.koreait.cset.dao.MemberDAO;
import com.koreait.cset.dto.MemberDTO;

public class MemberIdCheck implements CsetCommand {

	@Override
	public void execute(SqlSession sqlSession, Model model) {
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest)map.get("request");
		HttpServletResponse response = (HttpServletResponse)map.get("response");
		
		String mId = request.getParameter("mId");
		
		MemberDTO mDTO = new MemberDTO();
		
		MemberDAO mDAO = sqlSession.getMapper(MemberDAO.class);
		mDTO = mDAO.memberselectBymId(mId);
				//응답할 JSONObject 객체 생성
				JSONObject obj = new JSONObject();
						
				// mId 를 가진 회원이 있으면 obj 에 result 변수에 "EXIST" 저장
				//    mId 를 가진 회원이 없으면 obj 에 result 변수에 "" 저장
				if ( mDTO != null ) {
					obj.put("result", "EXIST");
				} else {
					obj.put("result", "");
				}
						
						//  obj 를 응답
						response.setContentType("application/json; charset=utf-8");
						PrintWriter out;
						try {
							out = response.getWriter();
							out.println(obj);
							out.close();
						} catch (IOException e) {						 
							e.printStackTrace();
						}
			}


}
