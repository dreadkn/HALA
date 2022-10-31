<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>
<%@ include file="/WEB-INF/view/common/dropzone.jsp" %>

<script type="text/x-template" id="human-info-component">
    <form>

        <div class="form-row">
            <div class="form-group col-md-12 ">
                <div class="row align-items-center">
                    <div class="col-12">
                        <label class="mw-2"><small class="text-danger">*</small>공개여부</label>
                    </div>
                    <div class="col-12">
                        <label class="radio-button-wrap mx-3">
                            <input type="radio" id="isPublicY" name="isPublic" :value="true" v-model="human.isPublic" disabled>
                            <span class="radio-button"></span>
                        </label>
                        <label for="isPublicY" class="mr-5">공개</label>
                        <label class="radio-button-wrap mx-3">
                            <input type="radio" id="isPublicN" name="isPublic" :value="false" v-model="human.isPublic" disabled>
                            <span class="radio-button"></span>
                        </label>
                        <label for="isPublicN">비공개</label>
                    </div>
                </div>
            </div>
        </div>

        <div class="form-row">
            <div class="form-group col-md-4">
                <label>이름(국문)</label>
                <input type="text" class="form-control" id="krName" v-model="human.krName"  disabled >
                <div id="krNameError" class="invalid-feedback"></div>
            </div>
            <div class="form-group col-md-4">
                <label>이름(한문)</label>
                <input type="text" class="form-control" id="cnName" v-model="human.cnName"  disabled >
                <div id="cnNameError" class="invalid-feedback"></div>
            </div>
            <div class="form-group col-md-4">
                <label>이름(영문)</label>
                <input type="text" class="form-control" id="enName" v-model="human.enName"  disabled >
                <div id="enNameError" class="invalid-feedback"></div>
            </div>
        </div>
        <div class="form-row">
            <div class="form-group col-md-4">
                <label>직위</label>
                <input type="text" class="form-control" id="position" v-model="human.position"  disabled >
                <div id="positionError" class="invalid-feedback"></div>
            </div>
            <div class="form-group col-md-4">
                <label>생년</label>
                <input type="text" class="form-control" id="birthYear" v-model="human.birthYear"  disabled >
                <div id="birthYearError" class="invalid-feedback"></div>
            </div>
            <div class="form-group col-md-4">
                <label>이메일</label>
                <input type="text" class="form-control" id="email" v-model="human.email"  disabled >
                <div id="emailError" class="invalid-feedback"></div>
            </div>
        </div>
        <div class="form-row">
            <div class="form-group col-md-4">
                <label>주소</label>
                <input type="text" class="form-control" id="address" v-model="human.address"  disabled >
                <div id="addressError" class="invalid-feedback"></div>
            </div>
        </div>

        <div class="form-row">
            <div class="form-group col-md-8">
                <label>학력</label>
                <textarea name="education" class="w-100" rows="10" v-model="human.education" disabled></textarea>
                <div id="educationError" class="invalid-feedback"></div>
            </div>
        </div>
        <div class="form-row">
            <div class="form-group col-md-8">
                <label>경력사항</label>
                <textarea name="career" class="w-100" rows="10" v-model="human.career" disabled></textarea>
                <div id="careerError" class="invalid-feedback"></div>
            </div>
        </div>

        <div class="form-row">
            <div class="form-group col-md-8">
                <label>저작</label>
                <textarea name="writing" class="w-100" rows="10" v-model="human.writing" disabled></textarea>
                <div id="writingError" class="invalid-feedback"></div>
            </div>
        </div>

        <div class="form-row">
            <div class="form-group col-md-8">
                <label>논문</label>
                <textarea name="paper" class="w-100" rows="10" v-model="human.paper" disabled></textarea>
                <div id="paperError" class="invalid-feedback"></div>
            </div>
        </div>
        <div class="form-row">
            <div class="form-group col-md-8">
                <label>수상</label>
                <textarea name="awards" class="w-100" rows="10" v-model="human.awards" disabled></textarea>
                <div id="awardsError" class="invalid-feedback"></div>
            </div>
        </div>

        <div class="form-row">
            <div class="form-group col-md-8">
                <label>기타1</label>
                <textarea name="etc1" class="w-100" rows="10" v-model="human.etc1" disabled></textarea>
                <div id="etc1Error" class="invalid-feedback"></div>
            </div>
        </div>

        <div class="form-row">
            <div class="form-group col-md-8">
                <label>기타2</label>
                <textarea name="etc2" class="w-100" rows="10" v-model="human.etc2" disabled></textarea>
                <div id="etc2Error" class="invalid-feedback"></div>
            </div>
        </div>

        <div class="form-row">
            <div class="form-group col-md-12">
                <legend class="col-form-label pt-0 font-weight-bold">이미지</legend>
                <div class="input-group mb-3">
                    <dropzone-component ref="dropzone" :files="human.files" :delete="false" :max-files="1" :accepted-files="acceptedFiles"></dropzone-component>
                </div>
            </div>
        </div>
    </form>
</script>

<script>


    var humanInfoComponent = {
        template: '#human-info-component',
        props : ['id'],
        mounted: function () {
            this.fetch();
        },
        watch: {
            human: function(){

            }
        },
        computed: {

        },
        data: function () {
            return {
                human: {
                    isPublic: true,
                    krName: '',
                    cnName: '',
                    enName: '',
                    position: '',
                    birthYear: '',
                    address: '',
                    email: '',
                    education: '',
                    career: '',
                    writing: '',
                    paper: '',
                    awards: '',
                    etc1: '',
                    etc2: '',
                    readCount: 0,
                    files: [],
                },
                acceptedFiles : 'image/*',
                isFirst : true,
                currentTab : 0,
                tabs : ['기본정보']
            }
        },
        methods: {
            fetch: function () {
                var self = this;
                axios.get(contextPath + "/admin/human/detail/" + self.id, {data: {}}).then(function (data) {
                    self.human = data.data;
                }).catch(function (err) {
                });
            }

        }
    }
</script>
