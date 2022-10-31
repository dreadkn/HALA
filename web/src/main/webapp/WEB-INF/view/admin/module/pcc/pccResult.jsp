<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/include/tags.jspf" %>
<%@ page import = "java.util.*" %> 
    [본인인증 결과 ] <br> <br>
<%
	request.setCharacterEncoding("UTF-8");
	response.setContentType("text/html;charset=UTF-8");

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
	System.out.println("[pcc] cookie start ");
    //ÄíÅ°°ª °¡Á® ¿À±â
    Cookie[] cookies = request.getCookies();
    String cookiename = "";
    String cookiereqNum = "";
    /* String cookiereqNum = (String)request.getAttribute("reqNum"); */
	if(cookies!=null){
		for (int i = 0; i < cookies.length; i++){
			Cookie c = cookies[i];
			cookiename = c.getName();
			cookiereqNum = c.getValue();
			if(cookiename.compareTo("reqNum")==0) break;
			
			cookiereqNum = null;
		}
	}

    try{

        retInfo  = request.getParameter("retInfo").trim();

		System.out.println("[pcc] reqnum result: " + cookiereqNum);

        com.sci.v2.pcc.secu.SciSecuManager sciSecuMg = new com.sci.v2.pcc.secu.SciSecuManager();
        retInfo  = sciSecuMg.getDec(retInfo, cookiereqNum);

        String[] aRetInfo1 = retInfo.split("\\^");

		encPara  = aRetInfo1[0];
        encMsg   = aRetInfo1[1];
		
		String  encMsg2   = sciSecuMg.getMsg(encPara);
        if(encMsg2.equals(encMsg)){
            msgChk="Y";
        }

		if(msgChk.equals("N")){
%>
		    <script language=javascript>
            alert("fail");
		    </script>
<%
			return;
		}


		System.out.println("[pcc] refInfo : pacing");
		retInfo  = sciSecuMg.getDec(encPara, cookiereqNum);
		System.out.println("[pcc] refInfo : complete");

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
    
	<body>
		<form id="write-form">
			<input type="hidden" name="userName" value="<%=name%>"/>
			<input type="hidden" name="userTel" value="<%=cellNo%>"/>
			<input type="hidden" name="result" value="<%=result%>"/>
		</form>

</body>
<script>
	$(function(){
		opener.vm.responseAuth($('[name=userName]').val(), $('[name=userTel]').val());
		self.close(); 
		
		/* window.opener.location.href = '/popup/pccEnd?userNm=' + $('[name=userNm]').val() + '&userTel=' + $('[name=userTel]').val();	
		self.close(); */
		/* if ($('[name=result]').val() == 'Y') {
			$("#write-form").attr("action", "/account/join/write");
			$("#write-form").prop("target",  opener.document);
		    $('#write-form').submit();
		} */
	});
</script>
</html>
<%
        // ----------------------------------------------------------------------------------

    }catch(Exception ex){
          System.out.println("[pcc] Receive Error -"+ex.getMessage());
    }
%>
