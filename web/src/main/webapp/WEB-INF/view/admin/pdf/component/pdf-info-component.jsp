<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>
<script src="//mozilla.github.io/pdf.js/build/pdf.js"></script>
<style>
    .overlay {
        width:98.9%;
    height:900px;
        position:absolute;
        top:0; left:0;
        -ms-filter:"progid:DXImageTransform.Microsoft.Alpha(Opacity=20)";
        filter:alpha(opacity=20);
        opacity:0.5;
        zoom: 1;
        overflow: scroll;
    }
    .overlay_btn {
        width:100px;
        height:63px;
        position:absolute;
        top:0; left:241px;
        -ms-filter:"progid:DXImageTransform.Microsoft.Alpha(Opacity=20)";
        filter:alpha(opacity=20);
        opacity:0.8;
        background: #f00;
        zoom: 1;
        overflow: scroll;
    }
    #the-canvas {
        border: 1px solid black;
        direction: ltr;
        width: 100%;
        height: 500px;
    }
</style>
<script type="text/x-template" id="pdf-info-component">
    <div class="card card-light">
        <div class="card-header card-header-tab py-3">
            <div class="d-flex justify-content-between">
                <h3 class="card-title text-bold">관리자 정보</h3>
            </div>
        </div>

        <div class="card-body">
            <form>
                <div class="form-row">
                    <div class="form-group col-md-12 ">
                        <div class="row align-items-center">
                            <div class="col-auto">
                                <label class="mw-1">PDF 명</label>
                            </div>
                            <div class="col-auto">
                                <div class="input-group-append">
                                    {{pdf.name}}
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="form-row" oncontextmenu="return false;">
                    <div class="form-group col-md-12 " >
                        크롬뷰어 설정
                        <br>
                        - 툴바제거 : 링크 뒤 #toolbar=0 설정

                        <br>
                        - 설정 옵션 참고 : https://tinytip.co/tips/html-pdf-params/
                        - 크롬에서만 정상 동작
                        <br>
                        - toolbar = 1, 0
                        - view = FitV, FitH, Fit
                        - zoom = number
                        - page = number
                        - nameddest = string
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group col-md-12 ">
                        iFrame 보기(브라우저 뷰어)
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group col-md-12 ">
                        <div class="col-auto">
                            <iframe width="100%" height="900" :src="'/files/pdf/' + pdf.fileId"></iframe>
                        </div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group col-md-12 ">
                        iFrame 보기(브라우저 뷰어) : 파일 로딩시 암호파일 생성
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group col-md-12 ">
                        <div class="col-auto">
                            <iframe width="100%" height="900" :src="'/files/pdf/enc/' + pdf.fileId"></iframe>
                        </div>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group col-md-12 ">
                        pdf.js 보기 : 파일 로딩시 암호파일 생성, 문서 비밀번호 자동 입력
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group col-md-12 ">
                        <div class="col-auto">
                            <iframe width="100%" height="900" :src="'/viewer/pdf/' + pdf.fileId"></iframe>
                        </div>
                    </div>
                </div>


            </form>
        </div>
        <div class="card-footer" v-show="currentTab == 0">
            <div class="row ">
                <div class="col-auto"><button type="button" class="btn btn-secondary" @click="back">목록</button></div>
                <div class="col-auto"><button type="button" class="btn btn-danger" @click="deleteAdmin">삭제</button></div>
            </div>
        </div>
    </div>
</script>

<script>

    var pdfInfoComponent = {
        template: '#pdf-info-component',
        mounted: function () {
        },
        watch: {

        },
        computed: {
            isNew: function () {
                return this.$parent.id == null || this.$parent.id == '';
            },
            isUpdate: function () {
                return this.$parent.id != null && this.$parent.id != '';
            }
        },
        data: function () {
            return {
                pdf: {
                    name: '',
                    file: ''
                },
                isOverlap: true,
                currentTab : 0,
                tabs : ['기본정보']
            }
        },
        methods: {

            save: function () {
                var self = this;
                self.update();
            },
            update : function(){
                var self = this;

                axios.put("/admin/mng/pdf/" + id, this.admin).then(function (res) {
                    alertUpdated();
                }).catch(function (err) {
                    errorToastr('저장중 오류가 발생하였습니다.');
                });
            },
            deleteAdmin : function(){
                var self = this;

                deleteConfirm(function(result)
                {
                    if (result)
                    {
                        axios.delete("/admin/mng/pdf/" + id, {data: {}}).then(function (res) {
                            alertDeleted();
                            setTimeout(function () {
                                location.href = contextPath + '/admin/mng/pdf';
                            }, 1500);
                        }).catch(function (err) {
                            errorToastr('삭제중 오류가 발생하였습니다.');
                        });
                    }
                });
            },
            back: function () {
                var backUrl = "/admin/mng/pdf";
                back(backUrl);
            }

        }
    }
</script>

<script>
    $(function () {


    });
</script>
