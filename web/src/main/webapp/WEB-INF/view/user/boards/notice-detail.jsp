<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>

<div id="vue-app" class="sub boards notice container">
    <div class="board-header pb-3">
        <div class="text-center py-5">
            <span class="font-size-45 fw-bold d-block mb-4">공지사항</span>
            굿모닝제주의 새로운 소식과 공지를 확인해보세요!
        </div>
    </div>
    <div class="board-contents">
        <div class="board-title border-bottom px-2 py-3">
            <span class="d-block fw-bolder font-size-35 mb-3">{{notice.title}}</span>
            <span class="font-size-18 color-border-gray">{{dateFormat(notice.createdDate)}}</span>
        </div>
        <div class="board-main px-3 py-5 border-bottom color-gray">
            <div v-html="notice.content"></div>
        </div>
        <template v-for="(file,idx) in notice.files">
            <div class="board-file px-3 py-4 border-bottom">
                <a :href="'/files/' + file.id" target="_blank" class="">첨부파일 {{idx + 1}}. {{file.fileName}} ({{file.size}}KB) <img src="/resources/img/sub/ico_download.png"/></a>
            </div>
        </template>
        <div class="text-end px-1 py-3 mb-5 d-flex justify-content-between align-items-center">
            <div>
                <button type="button" v-if="prevItem.id != null" @click="openDetail(prevItem.id)"><img src="/resources/img/sub/ico_board_view_prev.png"/></button>
                <button type="button" v-if="nextItem.id != null" @click="openDetail(nextItem.id)"><img src="/resources/img/sub/ico_board_view_next.png"/></button>
            </div>
            <a href="javascript:void(0)" @click="back" class="btn-outline-circle-common">목록으로</a>
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
            this.fetch();
            this.fetchByPrev();
            this.fetchByNext();
        },
        data: {
            id : '${id}',
            notice : {},
            prevItem : {id : ''},
            nextItem : {id : ''},
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
            fetch: function () {
                var self = this;
                axios.get(contextPath + "/boards/notice/detail/" + self.id, {data: {}}).then(function (data) {
                    self.notice = data.data;
                }).catch(function (err) {
                    errorToastr("조회중 오류가 발생하였습니다.");
                });
            },
            fetchByPrev: function(){
                var self = this;
                axios.get(contextPath + "/boards/notice/prev/" + this.id, {data:{}}).then(function (data) {
                    self.prevItem = data.data;
                }).catch(function (err) {
                    errorToastr("조회중 오류가 발생하였습니다.");
                });
            },
            fetchByNext: function(){
                var self = this;
                axios.get(contextPath + "/boards/notice/next/" + this.id, {data:{}}).then(function (data) {
                    self.nextItem = data.data;
                }).catch(function (err) {
                    errorToastr("조회중 오류가 발생하였습니다.");
                });
            },
            openDetail : function(id){
                location.href = '/boards/notice/' + id;
            },
            back: function () {
                var backUrl = "/boards/notice";
                back(backUrl);
            },
            dateFormat : function(date){
                return dateFormat(date, 'YYYY.MM.DD');
            }
        }
    });

</script>
