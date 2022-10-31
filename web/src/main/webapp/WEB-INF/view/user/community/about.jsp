<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>

<div id="vue-app" class="sub community about container">
    <div class="common-header pb-3">
        <div class="text-center py-5">
            <span class="font-size-55 fw-bold d-block mb-4">굿모닝 제주를 소개합니다</span>
            굿모닝제주는 디지털 시대에 걸맞는 앱 기반 플랫폼으로 제주도민과 도외 거주 제주도민에게<br class="d-none d-sm-block" />지역정보를 제공하기 위한 서비스입니다.
        </div>
    </div>
    <div class="community-contents my-5 mx-auto text-center">
        <div class="my-5">
            <img src="/resources/img/sub/sub_logo.png" class="logo w-100" />
        </div>
        <div class="mb-5 text-start">
            <span class="d-block font-size-25 color-deep-blue mb-2">제주 정보를 보다</span>
            생활뉴스정보와 섬 문화 특징인 경조사 정보 제공을 통한 지역 공동체 유지에 이바지하고 문화소외현상을<br class="d-none d-md-block" /> 타개하기 위한 문화예술의 공연 전시 정보를 제공합니다.
        </div>
        <div class="text-start">
            <span class="d-block font-size-25 color-deep-blue mb-2">제주인을 알다</span>
            디지털 제주인명록 서비스를 이용하여 지역주민 동향 검색기능과<br class="d-none d-md-block" /> 독자가 직접 참여하는 축하와 위로 등 정보전달을 위한 공간을 제공합니다.
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
            formData:{
                title:'',
                contents:'',
                email:'',
                fileList: []
            },
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
            setData: function(field, data){
                this.formData[field] = data;
            },
            setFile: function($e){
                var files = $e.target.files;
                for(var i=0; i < files.length; i++){
                    this.formData.fileList.push(files[i]);
                }
            },
            btnFileUpload:function(){
                var self = this;
                self.$refs.inputFile.click();
            },
            checkTerm: function(){
                var self = this;
                self.term = !self.term;
            }
        }
    });

</script>
