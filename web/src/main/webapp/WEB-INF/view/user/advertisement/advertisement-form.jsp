<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>
<jsp:include page="/WEB-INF/view/user/component/sub-header-component.jsp"/>
<jsp:include page="/WEB-INF/view/user/component/form-input-component.jsp"/>
<jsp:include page="/WEB-INF/view/user/component/form-image-component.jsp"/>
<jsp:include page="/WEB-INF/view/user/component/term-component.jsp"/>

<div id="vue-app" class="sub advertisement container">
    <div class="common-header pb-3">
        <div class="text-center py-5">
            <span class="font-size-45 fw-bolder d-block mb-4">광고</span>
        </div>
    </div>
    <div class="advertisement-form-contents form-contents">
        <term-component :title="'개인정보 수집 및 이용 안내'" :term-contents="termContents" :term="term" @term="checkTerm"></term-component>
        <div class="border-top border-bottom border-1 border-dark px-4 py-4 mb-5">
            <form-input-component :title="'업체명'" :placeholder="''" :description="''" :length="0" :type="'input'" :data="formData.corpName" :field="'corpName'" @setdata="setData"></form-input-component>

            <div class="d-flex row">
                <label class="col-sm-2 col-form-label h-100 font-size-18">담당자</label>
                <div class="col-sm-4 form-input-div pb-3">
                    <input type="text" name="" v-model="formData.name" class="form-control" />
                </div>
                <label class="col-sm-2 col-form-label h-100 font-size-18 text-center">연락처</label>
                <div class="col-sm-4 form-input-div pb-3">
                    <input type="text" name="" v-model="formData.phone" class="form-control" />
                </div>
            </div>

            <div class="d-flex row">
                <label class="col-sm-2 col-form-label h-100 font-size-18">
                    광고 구분
                    <span class="font-size-16 d-block mt-2">1 개월 기준</span>
                </label>
                <div class="col-sm-4 form-input-div pb-3">
                    <select class="form-control">
                        <option value="">메인배너 100,000원</option>
                    </select>
                </div>
                <label class="col-sm-2 col-form-label h-100 font-size-18 text-center">광고 기간</label>
                <div class="col-sm-4 form-input-div pb-3">
                    <select class="form-control">
                        <option value="1">1개월</option>
                    </select>
                    <span class="color-border-gray d-block mt-2">* 광고 승인일 기준 해당 기간 동안 게재됩니다.</span>
                </div>
            </div>

            <div class="d-flex row">
                <label class="col-sm-2 col-form-label h-100 font-size-18">
                    광고이미지
                </label>
                <div class="col-sm-10 form-input-div pb-3">
                    <div class="advertisement-img-notice p-4 mb-4">
                        <span class="d-block fw-bolder">광고 이미지 규격 안내</span>
                        - 등록하신 광고는 웹, 모바일 앱에서 제공되며 광고 이미지는 각 규격에 맞춰 등록하여야 합니다.<br />
                        - 모서리 라운딩 또는 투명도 적용 이미지는 적용할 수 없습니다.
                    </div>
                    <table class="w-100">
                        <tr>
                            <th class="py-3 text-center border border-left-0">광고구분</th>
                            <th class="py-3 text-center border">웹</th>
                            <th class="py-3 text-center border border-right-0">모바일앱</th>
                        </tr>
                        <tr>
                            <th class="py-3 text-center border border-left-0">메인배너</th>
                            <td class="py-3 text-center border">1000*200</td>
                            <td class="py-3 text-center border border-right-0">320*100</td>
                        </tr>
                        <tr>
                            <th class="py-3 text-center border border-left-0">사이드배너</th>
                            <td class="py-3 text-center border">300*200</td>
                            <td class="py-3 text-center border border-right-0">500*100</td>
                        </tr>
                        <tr>
                            <th class="py-3 text-center border border-left-0">콘텐츠 하단</th>
                            <td class="py-3 text-center border">300*100</td>
                            <td class="py-3 text-center border border-right-0">300*100</td>
                        </tr>
                    </table>
                </div>
            </div>

            <form-image-component :data="formData.webImgList" :title="'웹 이미지'" :field="'webImgList'" @setdata="setData"></form-image-component>
            <form-image-component :data="formData.mobileImgList" :title="'모바일 이미지'" :field="'mobileImgList'" @setdata="setData"></form-image-component>
            <form-input-component :title="'링크'" :placeholder="'광고 클릭시 이동할 URL을 입력해 주세요'" :description="''" :length="0" :type="'input'" :data="formData.url" :field="'url'" @setdata="setData"></form-input-component>
        </div>
    </div>
    <div class="form-btn-wrapper text-center mt-3">
        <button type="button" class="submit bg-deep-blue font-size-22 py-3">
            등록하기
            <span class="amount d-block font-size-18">0원 결제</span>
        </button>
    </div>
</div>
<script>

    // Root
    var vm = new Vue({
        el: '#vue-app',
        components: {
            'sub-header-component': subHeaderComponent,
            'form-input-component': formInputComponent,
            'form-image-component': formImageComponent,
            'term-component': termComponent,
        },
        mounted: function () {
            AOS.init({
                easing: 'ease-in-out-sine'
            });
            this.init();
        },
        data: {
            formData:{
                corpName:'',
                name: '',
                phone: '',
                url:'',
                webImgList:[],
                mobileImgList:[],
            },
            termContents: '- 수집항목 : 업체명, 담당자(이름), 이메일, 전화번호, 팩스번호, 홈페이지<br/> - 수집목적 : 본인확인, 접수 및 결과 회신<br/> - 이용기간 : 원칙적으로 개인정보 수집 및 이용목적이 달성된 후에 해당정보를 지체없이 파기합니다.<br/>단, 관계법령의 규정에 의하여 보존할 필요가 있는 경우 일정기간 동안 개인정보를 보관할 수 있습니다.<br/>그 밖의 사항은 한라일보의 개인정보 취급방침을 준수합니다.',
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
            checkTerm: function(){
                this.term = !this.term;
            }
        }
    });

</script>
