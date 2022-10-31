<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>

<div id="vue-app" class="sub advertisement container">
    <div class="advertisement-list">
        <div class="common-header pb-3">
            <div class="text-center py-5">
                <span class="font-size-45 fw-bolder d-block mb-4">광고</span>
            </div>
        </div>
        <div class="contents-list my-5 mx-auto text-center">
            <div class="text-end mt-5">
                <a href="/advertisement/form" class="btn-outline-circle-common px-3 py-2 align-self-end">광고 등록하기 <span class="color-deep-blue">+</span></a>
            </div>
            <ul class="pb-1">
                <li class="d-flex flex-column flex-sm-row border-top border-bottom my-3" v-for="(advertisement, idx) in advertisementList">
                    <div class="advertisement-contents-info text-start">
                        <div class="w-100 d-grid py-3">
                            <div class="text-end mb-3">
                                <span class="btn-outline-circle-danger mr-2" v-if="advertisement.status == 'reject'">반려</span>
                                <span class="btn-outline-circle-primary mr-2" v-if="advertisement.status == 'processing'">검수중</span>
                                <span class="btn-outline-circle-warning mr-2" v-if="advertisement.status == 'waiting'">검수대기</span>
                                <span class="btn-outline-circle-success mr-2" v-if="advertisement.status == 'pass'">승인</span>
                            </div>
                            <div class="advertisement-contents-img-wrapper pl-3">
                                <img :src="advertisement.file.src" class="img-fluid"/>
                            </div>
                            <span class="fw-bolder align-self-end color-border-gray font-size-15 pt-3 pl-3">광고기간 <span class="font-size-20 color-border-gray">{{advertisement.range}}</span>개월</span>
                        </div>
                        <div class="reject-reason border-top py-3 pl-3" v-html="advertisement.answer" v-if="advertisement.status == 'reject'">
                        </div>
                    </div>
                    <div class="advertisement-contents-btn-wrapper d-flex flex-sm-column justify-content-center align-items-sm-end p-3">
                        <template v-if="advertisement.status == 'reject'">
                            <button type="button" class="bg-light-gray d-block border py-3 mb-sm-3 mr-3 mr-sm-0">삭제</button>
                            <button type="button" class="bg-light-gray d-block border py-3">수정</button>
                        </template>

                        <template v-if="advertisement.status == 'processing'">
                            <button type="button" class="bg-light-gray d-block border py-3">콘텐츠확인</button>
                        </template>

                        <template v-if="advertisement.status == 'waiting'">
                            <button type="button" class="bg-light-gray d-block border py-3 mb-sm-3 mr-3 mr-sm-0">등록취소</button>
                            <button type="button" class="bg-light-gray d-block border py-3">수정</button>
                        </template>

                        <template v-if="advertisement.status == 'pass'">
                            <button type="button" class="bg-light-gray d-block border py-3">콘텐츠확인</button>
                        </template>
                    </div>
                </li>
            </ul>
            <button type="button" class="advertisement-contents-more font-size-22 border px-5 py-3 d-block mx-auto mt-5">더보기 <span class="pl-3">+</span></button>
        </div>
    </div>
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
            advertisementList:[
                {
                    id: 1,
                    answer: '검토의견을 알려드립니다. 정확성을 확인하기어려운 내용은 등록할 수 없습니다.<br />수정 후 등록해주세요.',
                    status: 'reject',
                    range: 1,
                    file:{
                        id: 1,
                        src: '/resources/img/sub/adver_list_sample.png'
                    }
                },
                {
                    id: 2,
                    answer: '검토의견을 알려드립니다. 정확성을 확인하기어려운 내용은 등록할 수 없습니다.<br />수정 후 등록해주세요.',
                    status: 'processing',
                    range: 2,
                    file:{
                        id: 2,
                        src: '/resources/img/sub/adver_list_sample.png'
                    }
                },
                {
                    id: 3,
                    answer: '검토의견을 알려드립니다. 정확성을 확인하기어려운 내용은 등록할 수 없습니다.<br />수정 후 등록해주세요.',
                    status: 'pass',
                    range: 3,
                    file:{
                        id: 3,
                        src: '/resources/img/sub/adver_list_sample.png'
                    }
                },
                {
                    id: 4,
                    answer: '검토의견을 알려드립니다. 정확성을 확인하기어려운 내용은 등록할 수 없습니다.<br />수정 후 등록해주세요.',
                    status: 'waiting',
                    range: 4,
                    file:{
                        id: 4,
                        src: '/resources/img/sub/adver_list_sample.png'
                    }
                },
            ],
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