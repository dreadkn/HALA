<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/include/tags.jspf" %>
<%@ page import = "java.util.*" %> 
    [본인인증 결과 Sample - JSP ] <br> <br>
<%
    // º¯¼ö --------------------------------------------------------------------------------
    String retInfo		= "";																// °á°úÁ¤º¸

	String name			= "";                                                               //¼º¸í
	String sex			= "";																//¼ºº°
	String birYMD		= "";																//»ý³â¿ùÀÏ
	String fgnGbn		= "";																//³»¿Ü±¹ÀÎ ±¸ºÐ°ª
	
    String di			= "";																//DI
    String ci1			= "";																//CI
    String ci2			= "";																//CI
    String civersion    = "";                                                               //CI Version
    
    String reqNum		= "";                                                               // º»ÀÎÈ®ÀÎ ¿äÃ»¹øÈ£
    String result		= "";                                                               // º»ÀÎÈ®ÀÎ°á°ú (Y/N)
    String certDate		= "";                                                               // °ËÁõ½Ã°£
    String certGb		= "";                                                               // ÀÎÁõ¼ö´Ü
	String cellNo		= "";																// ÇÚµåÆù ¹øÈ£
	String cellCorp		= "";																// ÀÌµ¿Åë½Å»ç
	String addVar		= "";


	//º¹È­È­¿ë º¯¼ö
	String encPara		= "";
	String encMsg		= "";
	String msgChk       = "N";  
	
    //-----------------------------------------------------------------------------------------------------------------
    
    //ÄíÅ°°ª °¡Á® ¿À±â
    /* Cookie[] cookies = request.getCookies();
    String cookiename = ""; */
    String cookiereqNum = (String)request.getAttribute("reqNum");
	/* if(cookies!=null){
		for (int i = 0; i < cookies.length; i++){
			Cookie c = cookies[i];
			cookiename = c.getName();
			cookiereqNum = c.getValue();
			if(cookiename.compareTo("reqNum")==0) break;
			
			cookiereqNum = null;
		}
	}

	System.out.println("111********************************\n********************************\n********************************\n********************************\n");
	/* cookiereqNum = "test1234"; */
	System.out.println(cookiereqNum);
	
	
    try{

        // Parameter ¼ö½Å --------------------------------------------------------------------
        retInfo  = request.getParameter("retInfo").trim();

%>
            [123123123123123123123123] <br>
            <br>
            retInfo : <%=retInfo%> <br>
            <br>
<%
        // 1. ¾ÏÈ£È­ ¸ðµâ (jar) Loading
        com.sci.v2.pcc.secu.SciSecuManager sciSecuMg = new com.sci.v2.pcc.secu.SciSecuManager();
        //ÄíÅ°¿¡¼­ »ý¼ºÇÑ °ªÀ» Key·Î »ý¼º ÇÑ´Ù.
        retInfo  = sciSecuMg.getDec(retInfo, cookiereqNum);

        // 2.1Â÷ ÆÄ½Ì---------------------------------------------------------------
        String[] aRetInfo1 = retInfo.split("\\^");

		encPara  = aRetInfo1[0];         //¾ÏÈ£È­µÈ ÅëÇÕ ÆÄ¶ó¹ÌÅÍ
        encMsg   = aRetInfo1[1];    //¾ÏÈ£È­µÈ ÅëÇÕ ÆÄ¶ó¹ÌÅÍÀÇ Hash°ª
		
		String  encMsg2   = sciSecuMg.getMsg(encPara);
			// 3.À§/º¯Á¶ °ËÁõ ---------------------------------------------------------------
        if(encMsg2.equals(encMsg)){
            msgChk="Y";
        }

		if(msgChk.equals("N")){
%>
		    <script language=javascript>
            alert("ºñÁ¤»óÀûÀÎ Á¢±ÙÀÔ´Ï´Ù.!!<%=msgChk%>");
		    </script>
<%
			return;
		}


        // º¹È£È­ ¹× À§/º¯Á¶ °ËÁõ ---------------------------------------------------------------
		retInfo  = sciSecuMg.getDec(encPara, cookiereqNum);

        String[] aRetInfo = retInfo.split("\\^");
		
        name		= aRetInfo[0];
		birYMD		= aRetInfo[1];
        sex			= aRetInfo[2];        
        fgnGbn		= aRetInfo[3];
        di			= aRetInfo[4];
        ci1			= aRetInfo[5];
        ci2			= aRetInfo[6];
        civersion	= aRetInfo[7];
        reqNum		= aRetInfo[8];
        result		= aRetInfo[9];
        certGb		= aRetInfo[10];
		cellNo		= aRetInfo[11];
		cellCorp	= aRetInfo[12];
        certDate	= aRetInfo[13];
		addVar		= aRetInfo[14];


%>
<html>
    <head>
        <title>요건 페이지 타이틀</title>
        <meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
		<meta name="robots" content="noindex,nofollow" />
        <style>
            <!--
            body,p,ol,ul,td
            {
                font-family: ±¼¸²;
                font-size: 12px;
            }

            a:link { size:9px;color:#000000;text-decoration: none; line-height: 12px}
            a:visited { size:9px;color:#555555;text-decoration: none; line-height: 12px}
            a:hover { color:#ff9900;text-decoration: none; line-height: 12px}

            .style1 {
                color: #6b902a;
                font-weight: bold;
            }
            .style2 {
                color: #666666
            }
            .style3 {
                color: #3b5d00;
                font-weight: bold;
            }
            -->
        </style>
    </head>
	<body>
		<form id="write-form">
			<input type="text" name="userNm" value="<%=name%>"/>
			<input type="text" name="userTel" value="<%=cellNo%>"/>
			<input type="text" name="result" value="<%=result%>"/>
		</form>
            [이건뭘까..] <br>
            <br>
            <table cellpadding="1" cellspacing="1" border="1">
				<tr>
					<td align="center" colspan="2">본인인증 정보</td>
				</tr>
				<tr>
                    <td align="left">name</td>
                    <td align="left"><%=name%></td>
                </tr>
				<tr>
                    <td align="left">sex</td>
                    <td align="left"><%=sex%></td>
                </tr>
				<tr>
                    <td align="left">birYMD</td>
                    <td align="left"><%=birYMD%></td>
                </tr>
				<tr>
                    <td align="left">fgnGbn</td>
                    <td align="left"><%=fgnGbn%></td>
                </tr>				
				<tr>
                    <td align="left">di</td>
                    <td align="left"><%=di%></td>
                </tr>
				<tr>
                    <td align="left">ci1</td>
                    <td align="left"><%=ci1%></td>
                </tr>
				<tr>
                    <td align="left">ci2</td>
                    <td align="left"><%=ci2%></td>
                </tr>
				<tr>
                    <td align="left">civersion</td>
                    <td align="left"><%=civersion%></td>
                </tr>
                <tr>
                    <td align="left">reqNum</td>
                    <td align="left"><%=reqNum%></td>
                </tr>
				<tr>
                    <td align="left">result</td>
                    <td align="left"><%=result%></td>
                </tr>
				<tr>
                    <td align="left">certGb</td>
                    <td align="left"><%=certGb%></td>
                </tr>
				<tr>
                    <td align="left">cellNo</td>
                    <td align="left"><%=cellNo%>&nbsp;</td>                
                </tr>
				<tr>
                    <td align="left">cellCorp</td>
                    <td align="left"><%=cellCorp%>&nbsp;</td>                
                </tr>
                <tr>
                    <td align="left">certDate</td>
                    <td align="left"><%=certDate%></td>
                </tr>				
				<tr>
                    <td align="left">addVar</td>
                    <td align="left"><%=addVar%>&nbsp;</td>
                </tr>
            </table>            
            <br>
            <br>
            <a href="http://.../pcc_V3_input_seed.jsp">[Back]</a>
</body>
<script>
	$(function(){
		if ($('[name=result]').val() == 'Y') {
			$("#write-form").attr("action", "/account/join/write");
			$("#write-form").prop("target", "_parent");
		    $('#write-form').submit();
		}
	});
</script>
</html>
<%
        // ----------------------------------------------------------------------------------

    }catch(Exception ex){
          System.out.println("[pcc] Receive Error -"+ex.getMessage());
    }
%>
