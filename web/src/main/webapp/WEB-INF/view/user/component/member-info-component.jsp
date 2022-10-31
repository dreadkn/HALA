<%--
  Created by IntelliJ IDEA.
  User: jskim
  Date: 2022/09/19
  Time: 16:02 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>

<script type="text/x-template" id="member-info-component">
    <div v-if="!changePwFlag">
        <ul class="mt-5">
            <li class="d-flex flex-column flex-sm-row align-items-baseline p-4 border-top border-bottom">
                <div class="myInfo-title d-flex align-items-baseline mr-4 w-100 fw-lighter">
                    <span class="font-size-18 fw-bolder">아이디</span>
                </div>
                <input type="text" value="email-123@nerver.com" class="bg-light-gray border border-c8 w-100 " readonly v-model="member.userId"/>
            </li>
            <li class="d-flex flex-column flex-sm-row align-items-baseline p-4 border-bottom">
                <div class="myInfo-title d-flex align-items-baseline mr-4 w-100 fw-lighter">
                    <span class="font-size-18 fw-bolder">이름</span>
                </div>
                <input type="text" value="홍길동" class="bg-light-gray border border-c8 w-100 " readonly v-model="member.name"/>
            </li>
            <li class="d-flex flex-column flex-sm-row align-items-baseline p-4 border-bottom">
                <div class="myInfo-title d-flex align-items-baseline mr-4 w-100 fw-lighter">
                    <span class="font-size-18 fw-bolder">전화번호</span>
                </div>
                <input type="text" value="010-1234-5678" class="border border-c8 w-100 " v-model="member.phone"/>
            </li>
            <li class="d-flex flex-column flex-sm-row align-items-baseline p-4 border-bottom">
                <div class="myInfo-title d-flex align-items-baseline mr-4 w-100 fw-lighter">
                    <span class="font-size-18 fw-bolder">이메일</span>
                </div>
                <input type="text" value="010-1234-5678" class="border border-c8 w-100 " v-model="member.email"/>
            </li>
        </ul>
        <div class="text-center d-flex flex-column flex-sm-row justify-content-center mt-5 pt-4">
            <button type="button" class="submit bg-deep-blue font-size-22 fw-bolder py-3 mr-sm-4 mb-3 w-100" @click="update">변경사항 저장</button>
            <button type="button" class="bg-border-gray font-size-22 fw-bolder py-3 mb-3 w-100" @click="changePwFlag = !changePwFlag">비밀번호 변경</button>
        </div>
    </div>
    <div v-else>
        <div class="member-change-pwd-wrapper text-center mx-auto">
            <span class="font-size-20 d-block mt-5">회원님의 비밀번호를 변경합니다.</span>
            <ul class="mt-5 text-left">
                <li class="d-flex flex-column flex-sm-row align-items-baseline p-2">
                    <input type="password" name="oldPassword" v-model="pw.oldPassword" placeholder="현재 비밀번호를 입력하세요" class="border border-c8 w-100 " />
                    <div id="oldPasswordError" class="invalid-feedback"></div>
                </li>
                <li class="d-flex flex-column flex-sm-row align-items-baseline p-2">
                    <input type="password" name="newPassword" v-model="pw.newPassword" placeholder="변경 비밀번호를 입력하세요" class="border border-c8 w-100 " />
                    <div id="newPasswordError" class="invalid-feedback"></div>
                </li>
                <li class="d-flex flex-column flex-sm-row align-items-baseline p-2">
                    <input type="password" name="matchingPassword" v-model="pw.matchingPassword" placeholder="변경 비밀번호를 다시한번 입력하세요" class="border border-c8 w-100 " />
                    <div id="matchingPasswordError" class="invalid-feedback"></div>
                </li>
                <li class="font-size-15 color-border-gray text-start p-2">
                    *8~20자의 영문 대/소문자,숫자,특수문자 한개 이상을 사용해주세요<br/>
                    *연속된 숫자 문자(4개 이상)은 제한합니다.
                </li>
            </ul>
        </div>
        <div class="text-center d-flex flex-column flex-sm-row justify-content-center mt-5 pt-4">
            <button type="button" class="submit bg-deep-blue font-size-22 fw-bolder py-3 mr-sm-4 mb-3 w-100" @click="chagePw">비밀번호 변경</button>
            <button type="button" class="bg-border-gray font-size-22 fw-bolder py-3 mb-3 w-100" @click="changePwFlag = !changePwFlag">변경취소</button>
        </div>
    </div>
</script>


<script>
    var memberInfoComponent = {
        template: '#member-info-component',
        mounted: function () {
            this.fetch();
        },
        watch: {
            member : function(){
                this.member.adminType = this.member.adminType.code;
            }
        },
        computed: {},
        props: [],
        data: function () {
            return {
                changePwFlag : false,
                member : {},
                pw : {
                    oldPassword: '',
                    newPassword: '',
                    matchingPassword: ''
                }
            }
        },
        methods: {
            fetch: function () {
                var self = this;
                axios.get("/member/info", {data: {}}).then(function (data) {
                    self.member = data.data;
                }).catch(function (err) {
                    errorToastr("조회중 오류가 발생하였습니다.");
                });
            },
            update : function(){
                var self = this;
                axios.put("/member/update", this.member).then(function (res) {
                    alertUpdated();
                }).catch(function (err) {
                    displayErrors(err);
                });
            },
            chagePw : function(){
                var self = this;

                alertConfirm(function(result){
                    if (result)
                    {
                        axios.post('/user/updatePassword', self.pw).then(function (res) {
                            alertSuccess("비밀번호가 변경 되었습니다. 다시 로그인 해주세요.");
                            setTimeout(function(){
                                $('#logout').submit();
                            },1500);

                        });
                    }
                }, "비밀번호를 변경 하시겠습니까?")
            }
        }
    }
</script>
