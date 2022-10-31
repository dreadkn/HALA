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
                        로그아웃
                    </a>
                    </sec:authorize>
                </div>
            </div>

            <div class="row justify-content-end collapse navbar-collapse pt-4 mb-4">
                <div class="col-auto">
                    <ul class="navbar-nav">
                        <li class="nav-item separator-right d-flex align-items-center">
                            <sec:authorize access="isAuthenticated() and !hasAuthority('CHANGE_PASSWORD_PRIVILEGE')">
                            <a class="" href="javascript:void(0)" @click="logout()" >로그아웃</a>
                            </sec:authorize>
                            <sec:authorize access="!isAuthenticated() or hasAuthority('CHANGE_PASSWORD_PRIVILEGE')">
                            <a class="color-deep-blue" href="/member/login" >
                                <img src="/resources/img/common/ico_login.png" class="d-inline-block mx-2"> 로그인
                            </a>
                            </sec:authorize>
                        </li>
                        <sec:authorize access="!isAuthenticated() or hasAuthority('CHANGE_PASSWORD_PRIVILEGE')">
                        <li class="nav-item" ><a class="pr-0" href="/member/signup">회원가입</a></li>
                        </sec:authorize>
                        <sec:authorize access="isAuthenticated() and !hasAuthority('CHANGE_PASSWORD_PRIVILEGE')">
                        <li class="nav-item" ><a class="pr-0" href="/member/mypage">마이페이지</a>
                        </li>
                        </sec:authorize>
                    </ul>
                </div>
            </div>

            <div class="row collapse navbar-collapse" id="navbarNavAltMarkup">
                <div class="col-lg-4 d-none d-lg-block"><a href="/"><img src="/resources/img/common/logo.png" class="img-fluid" /></a></div>
                <div class="col-12 col-lg-8 d-flex justify-content-lg-end align-items-center">
                    <ul class="navbar-nav justify-content-between" >
                        <li class=" nav-item font-size-18 col-auto"><a class="nav-link fw-bold" href="/news">뉴스</a>
                        <li class=" nav-item font-size-18 col-auto"><a class="nav-link fw-bold" href="/event">행사</a>
                        <li class=" nav-item font-size-18 col-auto"><a class="nav-link fw-bold" href="/familyEvent">경조사</a>
                        <li class=" nav-item font-size-18 col-auto"><a class="nav-link fw-bold" href="/peopleDictionary">제주인명</a>
                        <li class=" nav-item font-size-18 dropdown col-auto" @mouseover="showSubMenu">
                            <a class="nav-link font-size-18 fw-bold" role="button" aria-expanded="false" aria-current="page" href="javascript:void(0)">
                                커뮤니티
                                <span class="nav-sub-icon d-block d-lg-none">+</span>
                            </a>
<%--                            <a class="nav-link font-size-18 fw-bold active d-block d-lg-none" aria-current="page" href="javascript:void(0)">커뮤니티</a>--%>
                            <ul class="nav-sub-wrap dropdown-menu" ref="subMenu">
                                <li><a class="dropdown-item font-size-14 fw-bolder" href="/community/about">굿모닝제주 안내</a></li>
                                <li><a class="dropdown-item font-size-14 fw-bolder" href="/boards/notice">공지사항</a></li>
                                <li><a class="dropdown-item font-size-14 fw-bolder" href="/boards/faq">FAQ</a></li>
                                <li><a class="dropdown-item font-size-14 fw-bolder" href="/community/report">불편신고</a></li>
                                <li><a class="dropdown-item font-size-14 fw-bolder" href="/community/question">광고신청</a></li>
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

                alertConfirm(callback, "로그아웃 하시겠습니까?", "", "확인", "취소", "red");
            }

        }
    });
</script>
