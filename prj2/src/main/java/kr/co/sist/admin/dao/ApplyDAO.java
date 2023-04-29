package kr.co.sist.admin.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import kr.co.sist.admin.vo.ApplyVO;
import kr.co.sist.admin.vo.CertificateVO;
import kr.co.sist.admin.vo.EducationVO;
import kr.co.sist.admin.vo.LanguageVO;
import kr.co.sist.admin.vo.ResumeInfoVO;
import kr.co.sist.dao.DbConnection;

public class ApplyDAO {
	

	//Ư�� ������ ������ ��Ȳ �����ֱ�
	public List<ApplyVO> selectApplyAll(String userName, int jobNum) throws SQLException{
		List<ApplyVO> list = new ArrayList<ApplyVO>();
		
		
		DbConnection db=DbConnection.getInstance();
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		try {
			//db����
			con=db.getConn();
			
			
		if(userName.isEmpty()) { //�Էµ� �����ڸ��� ������ �����ڸ� ��� select
			
			//��� ������ ��Ȳ�� select�ϴ� ������
			StringBuilder selectApply = new StringBuilder();
						

			selectApply.append("SELECT a.apply_num, ja.job_num, ja.name AS corp_name, ja.title AS job_title, r.r_num, r.TITLE AS resume_title, u.name AS user_name, r.CAREER, a.read_state, ")
			.append("LISTAGG(e.SCHOOL_NAME || ' ' || e.MAJOR, ', ') WITHIN GROUP (ORDER BY a.inspec_date DESC) AS education, a.inspec_date, u.user_id ")
			.append("FROM job_ad ja ")
			.append("JOIN apply a ON ja.job_num = a.job_num ")
			.append("JOIN user_table u ON a.user_id = u.user_id ")
			.append("JOIN resume r ON a.r_num = r.r_num ")
			.append("JOIN education e ON e.r_num = r.r_num ")
			.append("WHERE ja.job_num = ? AND a.cancel != 'C' ")
			.append("GROUP BY a.apply_num, ja.job_num, ja.name, ja.title, r.r_num, r.TITLE, u.name, r.CAREER, a.read_state, a.inspec_date, u.user_id ")
			.append("order by trunc(inspec_date)"	);
			
			pstmt=con.prepareStatement(selectApply.toString());
			pstmt.setInt(1, jobNum);
			
			rs=pstmt.executeQuery();
		    
			
			// ResultSet�� �ݺ��Ͽ� ����� �о���̰� ApplyVO�� ����
			ApplyVO aVO=null;
			
			 while (rs.next()) {
				 	aVO = new ApplyVO();
				    aVO.setApplyNum(rs.getInt("apply_num"));
				    aVO.setJobNum(rs.getInt("job_num"));
				    aVO.setcName(rs.getString("corp_name"));
				    aVO.setAdTitle(rs.getString("job_title"));
				    aVO.setrNum(rs.getInt("r_num"));
				    aVO.setResumeTitle(rs.getString("resume_title"));
				    aVO.setName(rs.getString("user_name"));
				    aVO.setCareer(rs.getString("career"));
				    aVO.setReadState(rs.getString("read_state"));
				    aVO.setMajor(rs.getString("education"));
				    aVO.setApplyDate(rs.getDate("inspec_date"));
				    aVO.setId(rs.getString("user_id"));
		        
			        list.add(aVO);
			    }//end while
			
			
		    
		}else { //�Էµ� �����ڸ����� ������ ��Ȳ�� select
			
			StringBuilder selectApply = new StringBuilder();
			selectApply.append("SELECT a.apply_num, ja.job_num, ja.name AS corp_name, ja.title AS job_title, r.r_num, r.TITLE AS resume_title, u.name AS user_name, r.CAREER, a.read_state, ")
			.append("LISTAGG(e.SCHOOL_NAME || ' ' || e.MAJOR, ', ') WITHIN GROUP (ORDER BY a.inspec_date DESC) AS education, a.inspec_date, u.user_id  ")
			.append("FROM job_ad ja ")
			.append("JOIN apply a ON ja.job_num = a.job_num ")
			.append("JOIN user_table u ON a.user_id = u.user_id ")
			.append("JOIN resume r ON a.r_num = r.r_num ")
			.append("JOIN education e ON e.r_num = r.r_num ")
			.append("WHERE ja.job_num = ? AND u.name = ? AND a.cancel != 'C'  ")
			.append("GROUP BY a.apply_num, ja.job_num, ja.name, ja.title, r.r_num, r.TITLE, u.name, r.CAREER, a.read_state, a.inspec_date, u.user_id ")
			.append("order by trunc(inspec_date)"	);		
					
					pstmt=con.prepareStatement(selectApply.toString());
					pstmt.setInt(1, jobNum);
					pstmt.setString(2, userName);
					
					rs=pstmt.executeQuery();
			
			
			ApplyVO aVO=null;
			 // ResultSet�� �ݺ��Ͽ� ����� �о���̰� ApplyVO�� ����
			while (rs.next()) {
				 aVO = new ApplyVO();
				 aVO = new ApplyVO();
				 aVO = new ApplyVO();
				    aVO.setApplyNum(rs.getInt("apply_num"));
				    aVO.setJobNum(rs.getInt("job_num"));
				    aVO.setcName(rs.getString("corp_name"));
				    aVO.setAdTitle(rs.getString("job_title"));
				    aVO.setrNum(rs.getInt("r_num"));
				    aVO.setResumeTitle(rs.getString("resume_title"));
				    aVO.setName(rs.getString("user_name"));
				    aVO.setCareer(rs.getString("career"));
				    aVO.setReadState(rs.getString("read_state"));
				    aVO.setMajor(rs.getString("education"));
				    aVO.setApplyDate(rs.getDate("inspec_date"));
				    aVO.setId(rs.getString("user_id"));
				    
			        list.add(aVO);
			}//end while
	    
	}//end else
			
		
		}finally {
			db.dbClose(rs, pstmt, con);
		}//end finally
		
		return list;
		
	}//selectApplyAll
	
	
	
	
	//Ư�� ���� ������ �̷¼���
	//���� �� ī��Ʈ
	public int selectCountRead(int jobNum) throws SQLException{
		int cnt=0;
		
	
		DbConnection db=DbConnection.getInstance();
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		
		try {
			//db����
			con=db.getConn();
			
			
			StringBuilder selectCountR = new StringBuilder();
			selectCountR.append("select count(r_num) ")
				    .append("from apply ")
				    .append("where job_num = ? and read_state = 'RD'  ");
			
			
			pstmt=con.prepareStatement(selectCountR.toString());
			
			pstmt.setInt(1, jobNum);
			
			rs=pstmt.executeQuery();
			
			
			if (rs.next()) {
				
			      cnt = rs.getInt(1); //1��° ��
			    }//end if
			
			
			
		}finally {
			db.dbClose(rs, pstmt, con);
		}//end finally
		
		
		return cnt;
	}//selectCountRead
	
	
	
	
	//�̿��� �� ī��Ʈ
		public int selectCountUnRead(int jobNum) throws SQLException{
			int cnt=0;
			
		
			DbConnection db=DbConnection.getInstance();
			Connection con=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			
			
			try {
				//db����
				con=db.getConn();
				
				
				StringBuilder selectCountR = new StringBuilder();
				selectCountR.append("select count(r_num) ")
					    .append("from apply ")
					    .append("where job_num = ? and read_state = 'URD' ");
				
				
				pstmt=con.prepareStatement(selectCountR.toString());
				pstmt.setInt(1, jobNum);

				rs=pstmt.executeQuery();
				
				
				if (rs.next()) {
				      cnt = rs.getInt(1); //1��° ��
				    }//end if
				
			}finally {
				db.dbClose(rs, pstmt, con);
			}//end finally
			
			
			return cnt;
		}//selectCountUnRead
		
		

	//�� ������ ��
	public int selectCountApply(int jobNum) throws SQLException{
		int cnt=0;
		
		
		DbConnection db=DbConnection.getInstance();
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		
		try {
			//db����
			con=db.getConn();
			
			
			StringBuilder selectCountR = new StringBuilder();
			selectCountR.append("select count(apply_num) ")
				    .append("from apply ")
				    .append("where job_num = ?  ");
			
			
			pstmt=con.prepareStatement(selectCountR.toString());
			
			pstmt.setInt(1, jobNum);

			
			rs=pstmt.executeQuery();
			
			
			if (rs.next()) {
				
			      cnt = rs.getInt(1); //1��° ��
			    }//end if
			
			
			
		}finally {
			db.dbClose(rs, pstmt, con);
		}//end finally
		
		
		
		
		
		return cnt;
		
	}//selectCountApply
		
		
	public int updateReadState(int applyNum) throws SQLException{
		
		
		int cnt=0;
		
		
		DbConnection db=DbConnection.getInstance();
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		
		try {
			//db����
			con=db.getConn();
			
			
			StringBuilder updateRState = new StringBuilder();
			updateRState.append("update apply	")
						.append("set    read_state = 'RD'	")
						.append("where  apply_num = ?	");
			
			pstmt=con.prepareStatement(updateRState.toString());
			
			pstmt.setInt(1, applyNum);

			
			cnt=pstmt.executeUpdate();
			
			
		}finally {
			db.dbClose(rs, pstmt, con);
		}//end finally
		
		
		return cnt;
		
	}//updateReadState
	
	
		
		
//-----------------------------------------�̷¼�-----------------------------------------------------------	
	

	
	//��ų
	public String selectSkills(int applyNum) throws SQLException {
		
		String skills = "";
		
		DbConnection db=DbConnection.getInstance();
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		try {
			//db����
			con=db.getConn();
			
			StringBuilder selectSkills = new StringBuilder();
			selectSkills.append("SELECT LISTAGG(s.name, ', ') WITHIN GROUP (ORDER BY s.name) AS skills ")
			  .append("FROM apply a, resume r, skill s ")
			  .append("WHERE a.r_num = r.r_num AND a.user_id = r.user_id AND r.r_num = s.r_num ")
			  .append("AND apply_num = ? ")
			  .append("GROUP BY a.r_num, a.user_id, r.r_num	");
			  
			
			
			pstmt = con.prepareStatement(selectSkills.toString());
			pstmt.setInt(1, applyNum);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				skills = rs.getString("skills");
			}
			
			
		}finally {
			db.dbClose(rs, pstmt, con);
		}//end finally
		
		
		
		return skills;
		
	}//selectSkills
	
	
	
	
	
	//����
	public List<LanguageVO> selectLanguages(int applyNum) throws SQLException{
		List<LanguageVO> langList = new ArrayList<LanguageVO>();
		
		DbConnection db=DbConnection.getInstance();
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		try {
			//db����
			con=db.getConn();
			
			
			StringBuilder selectLang = new StringBuilder();
			selectLang.append("SELECT l.name, l.TEST_NAME, l.SCORE, l.get_date ")
			.append("FROM apply a, resume r, language l ")
			.append("WHERE a.r_num = r.r_num AND r.r_num = l.r_num ")
			.append("AND a.apply_num = ? ")
			.append("order by get_date desc ");
			
			
			pstmt = con.prepareStatement(selectLang.toString());
			pstmt.setInt(1, applyNum);
			
			rs = pstmt.executeQuery();
			
			LanguageVO lVO= null;
			
			while(rs.next()) {
				lVO = new LanguageVO();
				
				lVO.setName(rs.getString("name"));
			    lVO.setTestName(rs.getString("TEST_NAME"));
			    lVO.setScore(rs.getString("SCORE"));
			    lVO.setGetDate(rs.getString("get_date"));
				
			    langList.add(lVO);
				
			}//end while
			
			
			
			
		}finally {
			db.dbClose(rs, pstmt, con);
		}//end finally
		
		return langList;
	}//selectLanguages
	
	
	
	
	//�з�
	public List<EducationVO> selectEudcations(int applyNum) throws SQLException{
		List<EducationVO> listEduVO = new ArrayList<EducationVO>();
	
		DbConnection db=DbConnection.getInstance();
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		try {
			//db����
			con=db.getConn();
			
			
			StringBuilder selectEdu = new StringBuilder();
			selectEdu.append("SELECT e.SCHOOL_TYPE, e.school_name, e.major, e.PERIOD, e.GPA ")
			  .append("FROM apply a, resume r, education e ")
			  .append("WHERE a.r_num = r.r_num AND r.r_num = e.r_num ")
			  .append("AND a.apply_num = ?");
			  
			
			
			pstmt = con.prepareStatement(selectEdu.toString());
			pstmt.setInt(1, applyNum);
			
			rs = pstmt.executeQuery();
			
			EducationVO eVO = null;
			
			while(rs.next()) {
				eVO = new EducationVO();
				eVO.setSchoolType(rs.getString("SCHOOL_TYPE"));
				eVO.setSchoolName(rs.getString("school_name"));
				eVO.setMajor(rs.getString("major"));
				eVO.setPeriod(rs.getString("PERIOD"));
				eVO.setGpa(rs.getString("GPA"));
				
				listEduVO.add(eVO);
				
			}//end while
			
			
		}finally {
			db.dbClose(rs, pstmt, con);
		}//end finally
		
		return listEduVO;
	}//selectEudcations
	
	
	
	
	
	//�ڰ���
	public List<CertificateVO> selectCertificates(int applyNum) throws SQLException{
		List<CertificateVO> listCertVO = new ArrayList<CertificateVO>();
	
		DbConnection db=DbConnection.getInstance();
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		try {
			//db����
			con=db.getConn();
			
			StringBuilder selectCert = new StringBuilder();
			selectCert.append("SELECT c.name, c.issuer, c.get_date ")
	          .append("FROM apply a, resume r, certificate c ")
	          .append("WHERE a.r_num = r.r_num AND r.r_num = c.r_num ")
	          .append("AND a.apply_num = ?	")
	          .append("order by get_date desc");
			
			pstmt = con.prepareStatement(selectCert.toString());
			pstmt.setInt(1, applyNum);
			
			rs = pstmt.executeQuery();
			
			CertificateVO cVO = null;
			
			while(rs.next()) {
				cVO = new CertificateVO();
				cVO.setName(rs.getString("name"));
	            cVO.setIssuer(rs.getString("issuer"));
	            cVO.setGetDate(rs.getString("get_date"));
	            
	            listCertVO.add(cVO);
			}//end while
			
			
		}finally {
			db.dbClose(rs, pstmt, con);
		}//end finally
		
		return listCertVO;
	}//selectCertificates

	
	
	
	
	
	//ȸ��+�̷¼� ���� 
	public ResumeInfoVO selectInfo(int applyNum) throws SQLException {
		
		ResumeInfoVO rVO = null;
		
		DbConnection db=DbConnection.getInstance();
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		try {
			//db����
			con=db.getConn();
			
			
			StringBuilder selectInfo = new StringBuilder();
			selectInfo.append("SELECT r.TITLE, r.JOB, r.CAREER, r.EMPFORM, r.SAL, r.AREA, u.NAME, EMAIL, TEL, ADDR, BIRTH_DATE, IMG, GENDER ")
			  			.append("FROM apply a, resume r, user_table u ")
			  			.append("WHERE a.r_num = r.r_num AND r.user_id = u.user_id AND apply_num = ?");
			
			pstmt = con.prepareStatement(selectInfo.toString());
			pstmt.setInt(1, applyNum);
			
			rs = pstmt.executeQuery();
			
			
			
			if(rs.next()) {
				rVO = new ResumeInfoVO();
				rVO.setName(rs.getString("NAME"));
			    rVO.setEmail(rs.getString("EMAIL"));
			    rVO.setTel(rs.getString("TEL"));
			    rVO.setAddr(rs.getString("ADDR"));
			    rVO.setGender(rs.getString("GENDER"));
			    rVO.setImg(rs.getString("IMG"));
			    rVO.setTitle(rs.getString("TITLE"));
			    rVO.setJob(rs.getString("JOB"));
			    rVO.setCareer(rs.getString("CAREER"));
			    rVO.setEmpform(rs.getString("EMPFORM"));
			    rVO.setSal(rs.getString("SAL"));
			    rVO.setArea(rs.getString("AREA"));
			    rVO.setBirthDate(rs.getDate("BIRTH_DATE"));
			    
			}//end if
			
			
			
		}finally {
			db.dbClose(rs, pstmt, con);
		}//end finally
	
		return rVO;
		
	}//selectResumeInfo
	


}//class
