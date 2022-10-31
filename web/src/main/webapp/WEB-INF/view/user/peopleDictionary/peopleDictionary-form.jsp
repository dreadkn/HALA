<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>
<jsp:include page="/WEB-INF/view/user/component/sub-header-component.jsp"/>
<jsp:include page="/WEB-INF/view/user/component/form-input-component.jsp"/>
<jsp:include page="/WEB-INF/view/user/component/form-image-component.jsp"/>
<jsp:include page="/WEB-INF/view/user/component/term-component.jsp"/>
<jsp:include page="/WEB-INF/view/user/component/form-input-list-component.jsp"/>
<jsp:include page="/WEB-INF/view/common/user-dropzone.jsp"/>


<div id="vue-app" class="sub peopleDictionary container">
    <sub-header-component :sub-header-info="subHeaderInfo"></sub-header-component>
    <div class="form-contents">
        <span class="form-title d-block fw-bolder font-size-30">제주인명사전에 등록하고 싶으신가요? 등록하신 콘텐츠는 검수 후 등록됩니다.</span>
        <span class="form-sub-title d-block font-size-18 my-3">내용을 입력하신 후 등록하기 버튼을 클릭하세요.</span>
        <div class="border-top border-bottom border-1 border-dark px-4 py-4 mb-5">
            <form-input-component :title="'이름'" :placeholder="'이름을 입력해 주세요'" :description="''" :length="20" :type="'input'" :data="formData.krName" :field="'krName'" @setdata="setData"></form-input-component>
            <form-input-component :title="'이름(한문)'" :placeholder="'한문이름을 입력해 주세요'" :description="''" :length="20" :type="'input'" :data="formData.cnName" :field="'cnName'" @setdata="setData"></form-input-component>
            <form-input-component :title="'이름(영문)'" :placeholder="'영문이름을 입력해 주세요'" :description="''" :length="20" :type="'input'" :data="formData.enName" :field="'enName'" @setdata="setData"></form-input-component>
            <form-input-component :title="'직위'" :placeholder="'직위을 입력해 주세요'" :description="''" :length="100" :type="'input'" :data="formData.position" :field="'position'" @setdata="setData"></form-input-component>
            <form-input-component :title="'생년'" :placeholder="'생년을 입력해 주세요'" :description="''" :length="100" :type="'input'" :data="formData.birthYear" :field="'birthYear'" @setdata="setData"></form-input-component>
            <form-input-component :title="'주소'" :placeholder="'주소을 입력해 주세요'" :description="''" :length="500" :type="'input'" :data="formData.address" :field="'address'" @setdata="setData"></form-input-component>
            <form-input-component :title="'이메일'" :placeholder="'이메일을 입력해 주세요'" :description="''" :length="100" :type="'input'" :data="formData.email" :field="'email'" @setdata="setData"></form-input-component>
            <form-input-list-component :title="'학력'" :placeholder="'학력을 입력해 주세요'" :description="''" :length="100" :list-data="formData.schoolList" :field="'schoolList'" @addrow="addRow" @setdata="setListData" @deleterow="deleteRow" ></form-input-list-component>
            <div class="row">
                <label class="col-sm-2 col-form-label h-100"></label>
                <div class="col-sm-10">
                    <div :id="'educationError'" class="invalid-feedback"></div>
                </div>
            </div>
            <form-input-list-component :title="'경력사항'" :placeholder="'경력사항을 입력해 주세요'" :description="''" :length="100" :list-data="formData.careerList" :field="'careerList'" @addrow="addRow" @setdata="setListData" @deleterow="deleteRow" ></form-input-list-component>
            <div class="row">
                <label class="col-sm-2 col-form-label h-100"></label>
                <div class="col-sm-10">
                    <div :id="'careerError'" class="invalid-feedback"></div>
                </div>
            </div>
            <form-input-list-component :title="'저작'" :placeholder="'저작을 입력해 주세요'" :description="''" :length="100" :list-data="formData.copyrightList" :field="'copyrightList'" @addrow="addRow" @setdata="setListData" @deleterow="deleteRow" ></form-input-list-component>
            <form-input-list-component :title="'논문'" :placeholder="'논문을 입력해 주세요'" :description="''" :length="100" :list-data="formData.thesisList" :field="'thesisList'" @addrow="addRow" @setdata="setListData" @deleterow="deleteRow" ></form-input-list-component>
            <form-input-list-component :title="'수상경력'" :placeholder="'논문을 입력해 주세요'" :description="''" :length="100" :list-data="formData.awardsList" :field="'awardsList'" @addrow="addRow" @setdata="setListData" @deleterow="deleteRow" ></form-input-list-component>
            <form-input-list-component :title="'기타1'" :placeholder="'기타1을 입력해 주세요'" :description="''" :length="100" :list-data="formData.etcList1" :field="'etcList1'" @addrow="addRow" @setdata="setListData" @deleterow="deleteRow" ></form-input-list-component>
            <form-input-list-component :title="'기타2'" :placeholder="'기타2을 입력해 주세요'" :description="''" :length="100" :list-data="formData.etcList2" :field="'etcList2'" @addrow="addRow" @setdata="setListData" @deleterow="deleteRow" ></form-input-list-component>
            <dropzone-component ref="dropzone" :files="formData.files" :delete="false" :max-files="10" :accepted-files="acceptedFiles"></dropzone-component>

        </div>
    </div>
    <term-component :title="'콘텐츠 수집 및 이용 안내'" :term-contents="termContents" :term="term" @term="checkTerm"></term-component>
    <div class="form-btn-wrapper text-center mt-3">
        <button type="button" class="submit bg-deep-blue font-size-22 py-3" @click="submit">
            등록하기
            <span class="amount d-block font-size-18">{{contentPolicy.price}}원 결제</span>
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
            'form-input-list-component': formInputListComponent,

        },
        mounted: function () {
            AOS.init({
                easing: 'ease-in-out-sine'
            });
            this.init();
        },
        data: {
            formData:{
                isPublic: false,
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
                schoolList: [],
                careerList:[],
                copyrightList: [],
                thesisList: [],
                awardsList: [],
                etcList1: [],
                etcList2: [],
            },
            temp:'',
            subHeaderInfo:{
                title:"제주인명사전",
                category: '제주인명',
                formYn: true,
                writeFormUrl: '/peopleDictionary/form'
            },
            acceptedFiles : 'image/*',
            term: false,
            termContents:'',
            contentPolicy:{},
        },
        computed: {
            schoolList : function(){
                return this.formData.schoolList;
            },
            careerList : function(){
                return this.formData.careerList;
            },
            copyrightList : function(){
                return this.formData.copyrightList;
            },
            thesisList : function(){
                return this.formData.thesisList;
            },
            awardsList : function(){
                return this.formData.awardsList;
            },
            etcList1 : function(){
                return this.formData.etcList1;
            },
            etcList2 : function(){
                return this.formData.etcList2;
            },
        },
        watch: {
            schoolList : function(){
                this.formData.education = this.formData.schoolList.join();
            },
            careerList : function(){
                this.formData.career = this.formData.careerList.join();
            },
            copyrightList : function(){
                this.formData.writing = this.formData.copyrightList.join();
            },
            thesisList : function(){
                this.formData.paper = this.formData.thesisList.join();
            },
            awardsList : function(){
                this.formData.awards = this.formData.awardsList.join();
            },
            etcList1 : function(){
                this.formData.etc1 = this.formData.etcList1.join();
            },
            etcList2 : function(){
                this.formData.etc2 = this.formData.etcList2.join();
            },
        },
        updated: function(){

        },
        methods: {
            init: function(){
                this.fetchByContent();
                this.fetchByPrice();
            },
            fetchByPrice: function () {
                var self = this;
                axios.get("/peopleDictionary/price" , {data: {}}).then(function (data) {
                    self.contentPolicy = data.data;
                }).catch(function (err) {
                    errorToastr("조회중 오류가 발생하였습니다.");
                });
            },
            setData: function(field, data){
                this.formData[field] = data;
            },
            setListData: function(field, index, data){
                this.$set(this.formData[field], index, data);
            },
            addRow: function (field, data){
                this.formData[field].push(data);
            },
            deleteRow:function(field, index){
                var targetArr = this.formData[field];
                this.formData[field] = targetArr.filter(function(data, i) {
                    return index !=i;
                });
            },
            checkTerm: function(){
                var self = this;
                self.term = !self.term;
            },
            fetchByContent: function () {
                var self = this;
                axios.get("/term/policy/POLICY_CONTENT" , {data: {}}).then(function (data) {
                    self.termContents = data.data.contents;
                }).catch(function (err) {
                    errorToastr("조회중 오류가 발생하였습니다.");
                });
            },
            submit : function(){

                if (this.$refs.dropzone != null) {
                    this.formData.files = this.$refs.dropzone.getUploadFileIds();
                }

                var self = this;
                axios.post("/peopleDictionary", this.formData).then(function (res) {
                    alertSuccess('등록 요청되었습니다.');
                    setTimeout(function(){
                        location.href = contextPath + '/peopleDictionary';
                    },1500)
                }).catch(function (err) {
                    displayErrors(err);
                });
            },
        }
    });

</script>
