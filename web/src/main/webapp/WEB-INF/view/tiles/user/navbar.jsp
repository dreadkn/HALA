<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>

<!-- Fixed navbar -->
<div id="nav-app" class="">
    <div class="nav-wrap nav-sub-wrap navbar-expand-lg" @mouseleave="hideSubMenu">
        <div class="navbar-light pb-lg-4">
            <div class="d-lg-none row py-3 align-items-center justify-content-between">
                <div class="col-auto">
                    <button class="navbar-toggler border-0" type="button"  data-bs-toggle="collapse" data-bs-target="#navbarNavAltMarkup" aria-bs-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
                        <img src="/resources/img/common/ico_menu.png" />
                    </button>
                </div>
                <div class="col-4">
                    <a href="/"><img src="/resources/img/common/logo.png" class="img-fluid"></a>
                </div>
                <div class="col-auto">
                    <a href="/search" class="navbar-toggler border-0">
                        <img src="/resources/img/common/ico_search.png" />
                    </a>
                    <sec:authorize access="!isAuthenticated() or hasAuthority('CHANGE_PASSWORD_PRIVILEGE')">
                    <a href="/member/login" class="navbar-toggler border-0" >
                        <img src="/resources/img/common/ico_mobile_login.png" class="">
                    </a>
                    </sec:authorize>
                    <sec:authorize access="isAuthenticated() and !hasAuthority('CHANGE_PASSWORD_PRIVILEGE')">
                    <a class="" href="javascript:void(0)" @click="logout()" >
                        ๋ก๊ทธ์์
                    </a>
                    </sec:authorize>
                </div>
            </div>

            <div class="row justify-content-end collapse navbar-collapse pt-4 mb-4">
                <div class="col-auto">
                    <ul class="navbar-nav">
                        <li class="nav-item separator-right d-flex align-items-center">
                            <sec:authorize access="isAuthenticated() and !hasAuthority('CHANGE_PASSWORD_PRIVILEGE')">
                            <a class="" href="javascript:void(0)" @click="logout()" >๋ก๊ทธ์์</a>
                            </sec:authorize>
                            <sec:authorize access="!isAuthenticated() or hasAuthority('CHANGE_PASSWORD_PRIVILEGE')">
                            <a class="color-deep-blue" href="/member/login" >
                                <img src="/resources/img/common/ico_login.png" class="d-inline-block mx-2"> ๋ก๊ทธ์ธ
                            </a>
                            </sec:authorize>
                        </li>
                        <sec:authorize access="!isAuthenticated() or hasAuthority('CHANGE_PASSWORD_PRIVILEGE')">
                        <li class="nav-item" ><a class="pr-0" href="/member/signup">ํ์๊ฐ์</a></li>
                        </sec:authorize>
                        <sec:authorize access="isAuthenticated() and !hasAuthority('CHANGE_PASSWORD_PRIVILEGE')">
                        <li class="nav-item" ><a class="pr-0" href="/member/mypage">๋ง์ดํ์ด์ง</a>
                        </li>
                        </sec:authorize>
                    </ul>
                </div>
            </div>

            <div class="row collapse navbar-collapse" id="navbarNavAltMarkup">
                <div class="col-lg-4 d-none d-lg-block"><a href="/"><img src="/resources/img/common/logo.png" class="img-fluid" /></a></div>
                <div class="col-12 col-lg-8 d-flex justify-content-lg-end align-items-center">
                    <ul class="navbar-nav justify-content-between" >
                        <li class=" nav-item font-size-18 col-auto"><a class="nav-link fw-bold" href="/news">๋ด์ค</a>
                        <li class=" nav-item font-size-18 col-auto"><a class="nav-link fw-bold" href="/event">ํ์ฌ</a>
                        <li class=" nav-item font-size-18 col-auto"><a class="nav-link fw-bold" href="/familyEvent">๊ฒฝ์กฐ์ฌ</a>
                        <li class=" nav-item font-size-18 col-auto"><a class="nav-link fw-bold" href="/peopleDictionary">์?์ฃผ์ธ๋ช</a>
                        <li class=" nav-item font-size-18 dropdown col-auto" @mouseover="showSubMenu">
                            <a class="nav-link font-size-18 fw-bold" role="button" aria-expanded="false" aria-current="page" href="javascript:void(0)">
                                ์ปค๋ฎค๋ํฐ
                                <span class="nav-sub-icon d-block d-lg-none">+</span>
                            </a>
<%--                            <a class="nav-link font-size-18 fw-bold active d-block d-lg-none" aria-current="page" href="javascript:void(0)">์ปค๋ฎค๋ํฐ</a>--%>
                            <ul class="nav-sub-wrap dropdown-menu" ref="subMenu">
                                <li><a class="dropdown-item font-size-14 fw-bolder" href="/community/about">๊ตฟ๋ชจ๋์?์ฃผ ์๋ด</a></li>
                                <li><a class="dropdown-item font-size-14 fw-bolder" href="/boards/notice">๊ณต์ง์ฌํญ</a></li>
                                <li><a class="dropdown-item font-size-14 fw-bolder" href="/boards/faq">FAQ</a></li>
                                <li><a class="dropdown-item font-size-14 fw-bolder" href="/community/report">๋ถํธ์?๊ณ?</a></li>
                                <li><a class="dropdown-item font-size-14 fw-bolder" href="/community/question">๊ด๊ณ?์?์ฒญ</a></li>
                            </ul>
                        </li>
                    </ul>
                    <a href="/search" class="d-none d-lg-block">
                        <img src="/resources/img/common/ico_search_circle.png" />
                    </a>
                </div>
            </div>
        </div>
        <form id="logout" action="<c:url value="/member/logout"/>" method="post">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
        </form>
    </div>
</div>

<script>

    var vm = new Vue({
        el: '#nav-app',
        components: {
        },
        mounted: function () {
        },
        data: {
        },
        computed: {
            isLogin : function(){
                return false;
            }
        },
        watch: {
        },
        updated: function(){

        },
        methods: {
            showSubMenu: function(){
                this.$refs.subMenu.style.display = 'flex';
            },
            hideSubMenu: function(){
                this.$refs.subMenu.style.display = 'none';
            },
            logout: function(){
                let callback = function(isConfirm){
                    if (isConfirm)
                    {
                        $('#logout').submit();
                    }
                }

                alertConfirm(callback, "๋ก๊ทธ์์ ํ์๊ฒ?์ต๋๊น?", "", "ํ์ธ", "์ทจ์", "red");
            }

        }
    });
</script>
