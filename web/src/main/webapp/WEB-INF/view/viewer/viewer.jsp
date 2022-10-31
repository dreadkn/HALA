<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>

<div id='viewerContainer'>
    <div id='pdfViewer' class='pdfViewer'></div>
    <div class='pdfFixedDiv'>

<%--        <button id='pdfRotatebutton'>rotate</button>--%>
        <input type='text' id='pdfInput' placeholder='숫자'></input>

        <label id="pagetotal">/# 페이지</label>
        <label style="padding-left: 20px;">|</label>
        <button id='pdfZoomOutbutton'>축소 -</button>
        <button id='pdfZoomClearButton'>기본</button>
        <button id='pdfZoominbutton'>확대 +</button>
    </div>
</div>

<script>
    // var DEFAULT_URL = '/pdf/pdf.pdf';

    <%--alert(${id});--%>
    var DEFAULT_URL = '/files/pdf/enc/' + ${id};

    var pdfjsLib = window['pdfjs-dist/build/pdf'];

    if (!pdfjsLib.getDocument || !pdfjsViewer.PDFViewer) {
        alert("Library not imported");
    }

    pdfjsLib.GlobalWorkerOptions.workerSrc = '/resources/js/pdfjs/pdf.worker.js';
    var zoominbutton = document.getElementById("pdfZoominbutton");
    var zoomoutbutton = document.getElementById("pdfZoomOutbutton");
    var zoomclearbutton = document.getElementById("pdfZoomClearButton");

    var rotatebutton = document.getElementById("pdfRotatebutton");
    var container = document.getElementById('viewerContainer');
    var viewer = document.getElementById('pdfViewer');
    var input = document.getElementById("pdfInput");
    var pagetotal = document.getElementById("pagetotal");


    var DEFAULT_SCALE_SIZE = .15;


    // (Optionally) enable hyperlinks within PDF files.
    var pdfLinkService = new pdfjsViewer.PDFLinkService();


    var pdfViewer = new pdfjsViewer.PDFViewer({
        container: container,
        viewer: viewer,
        linkService: pdfLinkService,
    });
    pdfLinkService.setViewer(pdfViewer);

    document.addEventListener('pagesinit', function () {
        // We can use pdfViewer now, e.g. let's change default scale.
        pdfViewer.currentScaleValue = 'auto';

        pagetotal.textContent = " /  " + pdfViewer.pagesCount + " 페이지";

    });

    document.addEventListener('scroll', function () {
        console.log('scroll');

    });

    // Loading document.
    var loadingTask = pdfjsLib.getDocument({
        url: DEFAULT_URL,
    });
    loadingTask.promise.then(function(pdfDocument) {
        // Document loaded, specifying document for the viewer and
        // the (optional) linkService.
        pdfViewer.setDocument(pdfDocument);


        pdfLinkService.setDocument(pdfDocument, null);
    });

    loadingTask.onPassword = function (updatePassword, reason) {
        // input password
        updatePassword("1234");
        // if (reason === 1) { // need a password
        //     var new_password= prompt('Please enter a password:');
        //     updatePassword(new_password);
        // } else { // Invalid password
        //     var new_password= prompt('Invalid! Please enter a password:');
        //     updatePassword(new_password);
        // }
    };

    zoomclearbutton.onclick = function() {
        pdfViewer.currentScaleValue = 1;
    }

    zoominbutton.onclick = function() {
        var newScale = pdfViewer.currentScale + DEFAULT_SCALE_SIZE;
        if (newScale > 3) {
            return;
        }
        pdfViewer.currentScaleValue = newScale;
    }


    zoomoutbutton.onclick = function() {
        var newScale = pdfViewer.currentScale - DEFAULT_SCALE_SIZE ;

        if (newScale < 0.5) {
            return;
        }
        pdfViewer.currentScaleValue = newScale;
    }

    // rotatebutton.onclick = function() {
    //     var rotateVal = ((pdfViewer.pagesRotation+90) >= 360) ? 0 : pdfViewer.pagesRotation+90 ;
    //     console.log(rotateVal);
    //     pdfViewer.pagesRotation = rotateVal;
    // }

    input.addEventListener("keyup", function(event) {
        var val = Number(input.value);
        if (event.keyCode === 13 && val) {
            // Cancel the default action, if needed
            event.preventDefault();
            if(val > pdfViewer.pagesCount)
            {
                val = pdfViewer.pagesCount;
            }
            console.log(val);
            pdfViewer.currentPageNumber = val;
        }
    });

    container.onscroll = function() {
        input.value = pdfViewer.currentPageNumber;
    }
</script>
<%--<script data-ad-client="ca-pub-3329553162349654" async src="https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"></script>--%>