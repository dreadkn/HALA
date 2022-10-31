<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>

<!DOCTYPE html>
<html lang="ko" dir="ltr" mozdisallowselectionprint>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="google" content="notranslate">

    <title>PDF.js viewer using built components</title>

    <style>
        body {
            background-color: #808080;
            margin: 0;
            padding: 0;
        }
        #viewerContainer {
            overflow: auto;
            position: absolute;
            width: 100%;
            height: 100%;
        }
        .pdfFixedDiv{
            position: fixed;
            bottom: 10px;
            left: 40%;
            padding: 10px 20px;
            background: #000000cc;
            border-radius: 5px;
            width: 390px;
        }
        button {
            background-color: transparent;
            border: none;
            color: white;
            padding: 8px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 15px;
            padding: 5px 20px;
        }
        input {
            padding: 7px;
            text-align: center;
            text-decoration: none;
            font-size: 15px;
            width: 8%;
        }
        button:hover {
            background-color: #ffffff55;
            cursor: pointer;
        }
        label {
            font-size: 15px;
            color: #fff;
        }
    </style>
<%--    <script src="//mozilla.github.io/pdf.js/build/pdf.js"></script>--%>
<%--    <script src="https://www.jsdelivr.com/package/npm/pdfjs-dist"></script>--%>

    <link rel="stylesheet" href="/resources/css/pdfjs/pdf_viewer.css">

    <script src="/resources/js/pdfjs/pdf.js"></script>
    <script src="/resources/js/pdfjs/pdf_viewer.js"></script>
</head>

<body tabindex='1'>
    <tiles:insertAttribute name="content"/>
</body>
<script>
    // alert(111);
</script>
</html>
