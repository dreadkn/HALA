<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>

<div id="vue-app" class="sub member login container">
    <form name="f" action="" method="post">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
        <div class="login-contents mb-5 mx-auto text-center">
            <div class="login-wrapper bg-white p-5 mx-auto w-100">
                <span class="d-block font-size-40 fw-bolder mb-5 pb-3">로그인</span>
                <div class="mb-5">
                    <input type="text" class="d-block w-100 p-3 border mb-3 border-c8" placeholder="아이디" name="username"/>
                    <input type="password" class="d-block w-100 p-3 border mb-3 border-c8" placeholder="비밀번호" name="password" />
                    <button type="submit" class="d-block w-100 p-3 border mb-3 bg-deep-blue" >로그인</button>
                </div>
                <c:if test="${param.message != null}">
                    <div class="alert alert-info">${param.message}</div></c:if>

                <c:if test="${param.error != null}">
                    <div class="alert alert-danger">${sessionScope["SPRING_SECURITY_LAST_EXCEPTION"]}</div>
                </c:if>
                <ul class="d-flex justify-content-center align-items-center">
                    <li><a href="/member/find/id" class="font-size-14">아이디 찾기</a></li>
                    <li class="separator-left separator-right d-flex align-items-center"><a href="/member/find/pw" class="font-size-14">비밀번호 찾기</a></li>
                    <li><a href="/member/signup" class="font-size-14">회원가입</a></li>
                </ul>
            </div>
        </div>
    </form>
</div>
<script>

    // Root
    var vm = new Vue({
        el: '#vue-app',
        components: {
        },
        mounted: function () {
            AOS.init({
                easing: 'ease-in-out-sine'
            });
            this.init();
        },
        data: {
            formData:{
            },
            term: false
        },
        computed: {

        },
        watch: {

        },
        updated: function(){

        },
        methods: {
            init: function(){
            },

        }
    });

</script>
