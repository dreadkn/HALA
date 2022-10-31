<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>
<jsp:include page="/WEB-INF/view/common/vue-datatable-pagination.jsp"/>



<div id="vue-app" class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h4 class="m-0 text-dark">제이스 상세</h4>
                </div>
                <div class="col-sm-6 d-none d-md-block">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item active">제이스 관리</li>
                        <li class="breadcrumb-item active">제이스 관리</li>
                        <li class="breadcrumb-item active">제이스 상세</li>
                    </ol>
                </div>
            </div>
        </div>
    </div>
    <!-- /.content-header -->

    <!-- Main content -->
    <div class="content">
        <div class="container-fluid">
            <div class="row">

                <div class="col-md-12">
                    <div class="card card-light">
                        <div class="card-header card-header-tab py-3">
                            <div class="d-flex justify-content-between">
                                <h3 class="card-title text-bold">제이스 정보</h3>
                            </div>
                            <div class="tab-wrap">
                                <ul class="nav nav-tabs">
                                    <li class="nav-item" v-for="(tab, index) in tabs " >
                                        <a class="nav-link " :class="{active:currentTab === index}" href="#" @click="currentTab = index" v-if="index == 0 || (index != 0)">{{tab}}</a>
                                    </li>
                                </ul>
                            </div>
                        </div>

                        <div class="card-body" v-show="currentTab == 0">
                            <form>
                                <div class="form-row">
                                    <div class="busi_view center_area">
                                        <div class="gry_box">
                                            <span class="ttl"><strong >[{{htmlDecode(item.anno.business_div_name)}}] </strong>{{htmlDecode(item.anno.anno_name)}}</span>
                                        </div>
                                        <h4>사업명</h4>
                                        <p>{{htmlDecode(item.anno.business_name)}}</p>
                                        <h4>세부사업명</h4>
                                        <p>{{htmlDecode(item.anno.business_name)}}</p>
                                        <table width="100%" class="center_table">
                                            <caption>사업내용</caption>
                                            <thead>
                                            <tr>
                                                <th>사업기간</th>
                                                <th>접수기간</th>
                                                <th>공고일시</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <tr>
                                                <td>{{item.anno.all_business_s_date}} ~ {{item.anno.all_business_e_date}}</td>
                                                <td>{{item.anno.receipt_s_date}} ~ {{item.anno.receipt_e_date + ' ' + zeroToStr(item.anno.receipt_e_hour) + ':' + zeroToStr(item.anno.receipt_e_minute)}}</td>
                                                <td>{{dateFormat(item.anno.anno_s_date)}}</td>
                                            </tr>
                                            </tbody>

                                        </table>

                                        <div class="dep_info">
                                            <span>담당부서 : {{item.anno.subject_dep}}</span>
                                            <span>담당자 : {{item.anno.manager_name}}<template v-if="item.anno.manager_cp">({{item.anno.manager_contact_phone}})</template></span>
                                        </div>
                                        <div class="bs_btn clearfix ">
                                            <a href="#" @click="back" >리스트</a>
                                            <a :href="'https://jeis.or.kr/suppbis/suppbisdtl.do?anno_id=' + item.anno.anno_id" target="_blank" title="새창 열림" >공고 바로가기</a>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                        <div class="card-footer" v-show="currentTab == 0">
                            <div class="row ">
                                <div class="col-auto"><button type="button" class="btn btn-secondary" @click="back">목록</button></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>

    var id = '${id}';
    // Root
    var vm = new Vue({
        el: '#vue-app',
        components: {
        },
        mounted: function () {
            this.fetch();
        },
        data: {
            item : {
                anno: {
                    fileList: []
                },
                imgfileList: [],
            },
            currentTab : 0,
            tabs : ['기본정보'],
            prevItem : {},
            nextItem : {},
        },
        computed: {
        },
        watch: {
            item : function(){
                this.item.anno.anno_contents = this.htmlDecode(this.item.anno.anno_contents);
            }
        },
        updated: function(){

        },
        methods: {
            fetch : function(){
                var self = this;
                axios.get(contextPath + "/admin/module/jeis/detail/json/" + id, {data:{}}).then(function (data) {
                    self.item = data.data;
                }).catch(function (err) {
                    errorToastr("조회중 오류가 발생하였습니다.");
                });
            },
            dateFormat: function(date){
                return dateFormat(date, 'YYYY.MM.DD');
            },
            htmlDecode : function (input) {
                var doc = new DOMParser().parseFromString(input, "text/html");
                return doc.documentElement.textContent;
            },
            nullToBlank : function(content){
                return content == 'null' ? '' : content;
            },
            zeroToStr : function(num){
                return Number(num) < 10 ? '0' + num : num;
            },
            back:function(){
                location.href = '/admin/module/jeis';
            }
        }
    });

</script>
