<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>
<%@ include file="/WEB-INF/view/common/dropzone.jsp" %>

<script type="text/x-template" id="event-info-component">
    <form>
        <div class="form-row">
            <div class="form-group col-md-12 ">
                <div class="row align-items-center">
                    <div class="col-12">
                        <label class="mw-2"><small class="text-danger">*</small>공개여부</label>
                    </div>
                    <div class="col-12">
                        <label class="radio-button-wrap mx-3">
                            <input type="radio" id="isPublicY" name="isPublic" :value="true" v-model="event.isPublic" disabled>
                            <span class="radio-button"></span>
                        </label>
                        <label for="isPublicY" class="mr-5">공개</label>
                        <label class="radio-button-wrap mx-3">
                            <input type="radio" id="isPublicN" name="isPublic" :value="false" v-model="event.isPublic" disabled>
                            <span class="radio-button"></span>
                        </label>
                        <label for="isPublicN">비공개</label>
                    </div>
                </div>
            </div>
        </div>

        <div class="form-row">
            <div class="form-group col-md-4">
                <label>제목</label>
                <input type="text" class="form-control" id="title" v-model="event.title"  disabled>
                <div id="titleError" class="invalid-feedback"></div>
            </div>
        </div>
        <div class="form-row">
            <div class="form-group col-md-8">
                <label>내용</label>
                <textarea name="content" class="w-100" rows="10" v-model="event.content" disabled></textarea>
                <div id="contentError" class="invalid-feedback"></div>
            </div>
        </div>

        <div class="form-row">
            <div class="form-group col-md-8">
                <label>홈페이지링크</label>
                <input type="text" class="form-control" id="homepageUrl" v-model="event.homepageUrl"  disabled >
                <div id="homepageUrlError" class="invalid-feedback"></div>
            </div>
            <div class="form-group col-md-8">
                <label>유튜브링크</label>
                <input type="text" class="form-control" id="youtubeUrl" v-model="event.youtubeUrl" disabled  >
                <div id="youtubeUrlError" class="invalid-feedback"></div>
            </div>
        </div>


        <div class="form-row">
            <div class="form-group col-md-12">
                <legend class="col-form-label pt-0 font-weight-bold">이미지</legend>
                <div class="input-group mb-3">
                    <dropzone-component ref="dropzone" :files="event.files" :delete="false" :max-files="10" :accepted-files="acceptedFiles" ></dropzone-component>
                </div>
            </div>
        </div>
    </form>
</script>

<script>


    var eventInfoComponent = {
        template: '#event-info-component',
        props : ['id'],
        mounted: function () {
            this.fetch();
        },
        watch: {
            event: function(){

            }
        },
        computed: {

        },
        data: function () {
            return {
                event: {
                    isPublic: true,
                    title: '',
                    content: '',
                    homepageUrl: '',
                    youtubeUrl: '',
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
                axios.get(contextPath + "/admin/event/detail/" + self.id, {data: {}}).then(function (data) {
                    self.event = data.data;
                }).catch(function (err) {
                });
            }

        }
    }
</script>
