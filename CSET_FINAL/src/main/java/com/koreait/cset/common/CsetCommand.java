package com.koreait.cset.common;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

public interface CsetCommand {
	
	public void execute( SqlSession sqlSession, Model model );

}
