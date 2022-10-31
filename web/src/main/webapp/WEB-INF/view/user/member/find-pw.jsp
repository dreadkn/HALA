<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>

<div id="vue-app" class="sub member find container">
    <div class="find-contents mb-5 mx-auto text-center">
        <div class="find-wrapper bg-white p-5 mx-auto w-100">
            <span class="d-block font-size-40 fw-bolder mb-5 pb-3">아이디/비밀번호 찾기</span>
            <div class="contents-list">
                <ul class="nav nav-tabs border-bottom-0" role="tablist">
                    <li class="nav-item" role="presentation">
                        <button class="nav-link w-100" id="findId-tab" data-bs-toggle="tab" data-bs-target="#findId" type="button" role="tab" aria-controls="findId" aria-selected="true" @click="openFindId">아이디 찾기</button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link w-100 active" id="findPw-tab" data-bs-toggle="tab" data-bs-target="#findPw" type="button" role="tab" aria-controls="findPw" aria-selected="false" >비밀번호 찾기</button>
                    </li>
                </ul>
                <div class="tab-content">
                    <div class="tab-findPw tab-pane fade show active" id="findPw" role="tabpanel" aria-labelledby="findPw-tab">
                        <div class="mb-5 mx-auto">
                            <input type="text" v-model="userId" class="d-block w-100 p-3 border mb-3 border-c8" placeholder="아이디"/>
                            <input type="text" v-model="phone" class="d-block w-100 p-3 border mb-3 border-c8" placeholder="휴대폰 번호"/>
                            <div v-if="invalid" class="alert alert-danger">가입정보를 찾을 수 없습니다. 아이디 및 휴대폰 번호를 확인해주세요.</div>
                            <button type="button" class="d-block w-100 p-3 border mb-3 bg-deep-blue" @click="search">비밀번호 찾기</button>
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
            userId: '',
            phone: ''
        },
        computed: {

        },
        watch: {
            phone: function (val) {
                this.phone = val.replace(/[^0-9]/g,"");
            }
        },
        updated: function(){

        },
        methods: {
            init: function(){

            },
            openFindId : function(){
                location.href = '/member/find/id';
            },
            search : function(){
                var self = this;
                this.invalid = false;

                if (this.userId == '') {
                    alertWarning("아이디를 입력해주세요.");
                    return;
                }

                if (this.phone == '') {
                    alertWarning("휴대폰 번호를 입력해주세요.");
                    return;
                }

                let query = 'userId=' + self.userId + '&phone=' + self.phone;

                axios.post('/user/resetPasswords', query, {headers: {'Content-Type': 'application/x-www-form-urlencoded'}}).then(function (res) {
                    alertSuccess("가입하신 이메일로 비밀번호 변경 링크롤 전송하였습니다. 이메일을 확인해 주세요.");
                    setTimeout(function(){
                        location.href = contextPath + '/member/login';
                    },1500)
                }).catch(function (err) {
                    self.invalid = true;
                });
            }

        }
    });

</script>
