package com.koreait.cset.command.board;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;

import com.koreait.cset.common.CsetCommand;

public class BoardDownloadCommand implements CsetCommand {

	@Override
	public void execute(SqlSession sqlSession, Model model) {
		
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		HttpServletResponse response = (HttpServletResponse) map.get("response");
		
		// 서버에 파일이 저장된 위치 알아내기
		String realPath = request.getSession().getServletContext().getRealPath("/resources/boardStorage");
		
		// 다운로드 받을 파일 이름은 request에 저장되어있음
		String bFilename = request.getParameter("bFilename");
		
		// 다운로드 될 파일 이름은 서버에 저장된 이름이 아닌 원래 업로드 시 파일 이름으로 한다
		String ext = bFilename.substring( bFilename.lastIndexOf(".") + 1);
		String downloadFilename = bFilename.substring( 0, bFilename.lastIndexOf("_") ) + "." + ext;
			
		// 다운로드할 파일을 연결
		File file = new File( realPath, bFilename ); // 경로, 파일명
		
		// 다운로드(=복사)에 필요한 스트림 생성
		BufferedInputStream bis = null;
		BufferedOutputStream bos = null;
		
		try {
			
			// 다운로드가 되는 response 생성
			response.setHeader( "Content-Type", "application/x-msdownload" );
			response.setHeader( "Content-Disposition", "attachment; filename="
								+ new String( URLEncoder.encode( downloadFilename, "utf-8") ).replaceAll("//+", " ") );
			response.setHeader( "Content-length", file.length()+"" );
			
			// 스트림 생성
			bis = new BufferedInputStream( new FileInputStream(file) );
			bos = new BufferedOutputStream( response.getOutputStream() );
			
			// 입력스트림 => 출려스트림: 파일복사
			FileCopyUtils.copy( bis, bos );
			
			// 출력스트림에 남은 데이터 비우기
			bos.flush();
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if ( bos != null ) { bos.close(); }
				if ( bis != null ) { bis.close(); }
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

	}

}
