<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>

<footer id="footer-app" class="footer bg-light-gray">
    <div class="container position-relative">
        <div class="row">
            <div class="footer-logo col-lg-3 d-none d-lg-block">
                <img src="/resources/img/common/logo.png" class="img-fluid">
            </div>
            <div class="col-12 col-lg-9">
                <div class="footer-link row">
                    <div class="col-auto line-height-09 pr-3">
                        <a href="/community/about" class="font-weight-bold font-size-15">서비스 소개</a>
                    </div>
                    <div class="col-auto line-height-09 pr-3">
                        <a href="/term/private" class="color-deep-blue font-weight-bold font-size-15">개인정보 취급방침</a>
                    </div>
                    <div class="col-auto line-height-09">
                        <a href="/term/service" class="font-weight-bold font-size-15">서비스 이용약관</a>
                    </div>
                </div>
                <div class="row d-none d-lg-block pt-2">
                    <div class="col-12 pt-3">
                        <span class="color-light-gray float-start separator-right font-size-15">주소 : 제주특별자치도 제주시 서사로 154 (우)63185</span>
                        <span class="color-light-gray float-start separator-right font-size-15">대표전화 : 064-750-2114</span>
                        <span class="color-light-gray float-start separator-right font-size-15">대표메일 : hl@ihalla.com</span>
                        <span class="color-light-gray float-start font-size-15">광고메일 : pr@ihalla.com</span>
                    </div>
                    <div class="col-12 pt-3 d-flex">
                        <span class="color-light-gray separator-right font-size-15">등록번호 : 제주, 가00002</span>
                        <span class="color-light-gray separator-right font-size-15">인터넷신문등록번호 : 제주,아01131</span>
                        <span class="color-light-gray font-size-15">등록년월일 : 2021.07.02</span>
                    </div>
                </div>
                <div class="copyright-wrap row pt-5">
                    <div class="col-12 font-size-15">
                        Copyright ⓒ 1996. 한라일보(www.ihalla.com). All Rights Reserved
                    </div>
                </div>
            </div>
        </div>
        <button type="button" class="move-top position-fixed d-block bg-white rounded-circle border border-1 border-dark" @click="moveTop">
            <img src="/resources/img/common/ico_move_top.png" />
        </button>
    </div>
</footer>

<script>

    var vm = new Vue({
        el: '#footer-app',
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
            moveTop: function (){
                window.scrollTo({top: 0, left: 0, behavior: 'smooth'});
            }
        }
    });
</script>
