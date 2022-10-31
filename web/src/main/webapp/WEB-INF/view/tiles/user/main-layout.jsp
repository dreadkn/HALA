<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>

<!doctype html>
<html lang="ko" class="h-100">
<tiles:insertAttribute name="head"/>

<div id="loading-container">
    <div class="title">processing...</div>
    <div class="animation">
        <div class="loading"></div>
    </div>
</div>

<body >

    <nav class="border-0">
        <div class="container">
            <tiles:insertAttribute name="navbar"/>
        </div>
    </nav>
    <main role="main" >
        <tiles:insertAttribute name="content"/>
    </main>
    <tiles:insertAttribute name="footer"/>
</body>
</html>
