<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/include/tags.jspf" %>
<%@ page import = "java.util.*"%> 

<%
    String id       = (String)request.getAttribute("id");                            
    String srvNo    = (String)request.getAttribute("srvNo");                          
    String reqNum   = (String)request.getAttribute("reqNum");                         
	String exVar    = "0000000000000000";                                       
    String retUrl   = (String)request.getAttribute("retUrl");                   
	String certDate	= (String)request.getAttribute("certDate");                 
	String certGb	= (String)request.getAttribute("certGb");                   
	String addVar	= (String)request.getAttribute("addVar");                   

	
	Cookie c = new Cookie("reqNum", reqNum);
	c.setMaxAge(1800); 
	response.addCookie(c);


	com.sci.v2.pcc.secu.SciSecuManager seed  = new com.sci.v2.pcc.secu.SciSecuManager();

	String encStr = "";
	String reqInfo      = id+"^"+srvNo+"^"+reqNum+"^"+certDate+"^"+certGb+"^"+addVar+"^"+exVar;
	encStr              = seed.getEncPublic(reqInfo);

	com.sci.v2.pcc.secu.hmac.SciHmac hmac = new com.sci.v2.pcc.secu.hmac.SciHmac();
	String hmacMsg = hmac.HMacEncriptPublic(encStr);

	reqInfo  = seed.getEncPublic(encStr + "^" + hmacMsg + "^" + "0000000000000000");
%> 
		<div class="btn-wrap" style="display: none;">
			<button class="btn-act">본인인증</button>
		</div>
		
		<form id="reqPCCForm" name="reqPCCForm" method="post" action = "" onsubmit="return openPCCWindow()">
		    <input type="hidden" name="reqInfo"     value = "<%=reqInfo%>">
		    <input type="hidden" name="retUrl"      value = "<%=retUrl%>">
		    <input type="hidden" name="verSion"		value = "1">
		    <input type="hidden" name="reqNum"		value = "<%=reqNum%>">
		</form> 
		
<script>
$(function(){
	
	setCookie('reqNum', $('[name=reqNum]').val(), 1);
	$('#reqPCCForm').submit();  
	
	$('.btn-act').on('click', function() {
		location.href='pccTest';	
	});
	
});

var PCC_window; 

function openPCCWindow(){ 
    /* var PCC_window = window.open('', 'PCCV3Window', 'width=430, height=560, resizable=1, scrollbars=no, status=0, titlebar=0, toolbar=0, left=300, top=200' );

    if(PCC_window == null){ 
		 alert("본인인증 모듈 로딩 실패");
    } */

    document.reqPCCForm.action = 'https://pcc.siren24.com/pcc_V3/jsp/pcc_V3_j10.jsp';
    /* document.reqPCCForm.target = 'PCCV3Window'; */

	return true;
}	
</script>
