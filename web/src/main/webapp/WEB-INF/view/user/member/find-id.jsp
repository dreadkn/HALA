<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>

<div id="vue-app" class="sub member find container">
    <div class="find-contents mb-5 mx-auto text-center">
        <div class="find-wrapper bg-white p-5 mx-auto w-100">
            <span class="d-block font-size-40 fw-bolder mb-5 pb-3">아이디/비밀번호 찾기</span>
            <div class="contents-list">
                <ul class="nav nav-tabs border-bottom-0" role="tablist">
                    <li class="nav-item" role="presentation">
                        <button class="nav-link w-100 active" id="findId-tab" data-bs-toggle="tab" data-bs-target="#findId" type="button" role="tab" aria-controls="findId" aria-selected="true">아이디 찾기</button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link w-100" id="findPw-tab" data-bs-toggle="tab" data-bs-target="#findPw" type="button" role="tab" aria-controls="findPw" aria-selected="false" @click="openFindPw">비밀번호 찾기</button>
                    </li>
                </ul>
                <div class="tab-content">
                    <div class="tab-findId tab-pane fade show active" id="findId" role="tabpanel" aria-labelledby="findId-tab">
                        <div class="mb-5 mx-auto">
                            <input type="text" v-model="name" class="d-block w-100 p-3 border mb-3 border-c8" placeholder="이름"/>
                            <input type="text" v-model="phone" class="d-block w-100 p-3 border mb-3 border-c8" placeholder="연락처"/>
                            <div v-if="invalid" class="alert alert-danger">가입정보를 찾을 수 없습니다. 이름 및 휴대폰 번호를 확인해주세요.</div>
                            <div v-if="isLogin" class="alert alert-warning text-center">가입하신 ID는 <strong>{{userId}}</strong> 입니다. </div>
                            <button type="button" class="d-block w-100 p-3 border mb-3 bg-deep-blue" @click="search">아이디 찾기</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>

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
            term: false,
            invalid: false,
            isLogin: false,
            phone: '',
            name: '',
        },
        computed: {

        },
        watch: {
            phone: function (val) {
                this.phone = val.replace(/[^0-9]/g,"");
            },
        },
        updated: function(){

        },
        methods: {
            init: function(){

            },
            openFindPw : function(){
                location.href = '/member/find/pw';
            },
            search: function () {
                var self = this;
                this.invalid = false;

                axios.post('/member/find/id', self._data).then(function (res) {
                    self.userId = res.data.userId;
                    self.isLogin = true;
                }).catch(function (err) {
                    self.invalid = true;
                });
            },

        }
    });

</script>
