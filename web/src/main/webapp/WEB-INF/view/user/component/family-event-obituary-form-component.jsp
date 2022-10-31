<%--
  Created by IntelliJ IDEA.
  User: jskim
  Date: 2022/09/19
  Time: 16:02 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>
<jsp:include page="/WEB-INF/view/user/component/form-input-component.jsp"/>
<jsp:include page="/WEB-INF/view/user/component/form-link-component.jsp"/>
<jsp:include page="/WEB-INF/view/user/component/form-image-component.jsp"/>
<jsp:include page="/WEB-INF/view/user/component/form-input-list-component.jsp"/>
<jsp:include page="/WEB-INF/view/common/user-dropzone.jsp"/>

<script type="text/x-template" id="family-event-obituary-form-component">
    <div>
        <form-input-component :title="'제목'" :placeholder="''" :description="''" :length="0" :type="'input'" :data="formData.title" :field="'title'" @setdata="setData"></form-input-component>
        <form-input-component :title="'이름'" :placeholder="''" :description="''" :length="0" :type="'input'" :data="formData.deceased" :field="'deceased'" @setdata="setData"></form-input-component>
        <form-input-component :title="'직업'" :placeholder="''" :description="''" :length="0" :type="'input'" :data="formData.deceasedJob" :field="'deceasedJob'" @setdata="setData"></form-input-component>
        <form-input-component :title="'일포'" :placeholder="''" :description="''" :length="0" :type="'input'" :data="formData.illpho" :field="'illpho'" @setdata="setData"></form-input-component>
        <form-input-component :title="'발인일시'" :placeholder="''" :description="''" :length="0" :type="'input'" :data="formData.outDate" :field="'outDate'" @setdata="setData"></form-input-component>
        <form-input-component :title="'발인장소'" :placeholder="''" :description="''" :length="0" :type="'input'" :data="formData.place" :field="'place'" @setdata="setData"></form-input-component>
        <form-input-component :title="'장지'" :placeholder="''" :description="''" :length="0" :type="'input'" :data="formData.cemetery" :field="'cemetery'" @setdata="setData"></form-input-component>
        <form-input-component :title="'가족'" :placeholder="'이름을 입력해 주세요'" :description="''" :length="0" :type="'textarea'" :data="formData.content" :field="'content'" @setdata="setData"></form-input-component>

        <dropzone-component ref="dropzone" :files="formData.files" :delete="false" :max-files="10" :accepted-files="acceptedFiles"></dropzone-component>
        <form-link-component :type="'homepage'" :url-data="formData.homepageUrl" :url-field="'homepageUrl'" :title-data="formData.homepageTitle" :title-field="'homepageTitle'" @setdata="setData"></form-link-component>
        <form-link-component :type="'youtube'" :url-data="formData.youtubeUrl" :url-field="'youtubeUrl'" @setdata="setData"></form-link-component>

    </div>
</script>


<script>
    var familyEventObituaryFormComponent = {
        template: '#family-event-obituary-form-component',
        components: {
            'form-input-component': formInputComponent,
            'form-link-component': formLinkComponent,
            'form-image-component': formImageComponent,
            'form-input-list-component': formInputListComponent,
        },
        mounted: function () {
            this.init();
        },
        watch: {
            formData:{
                deep: true,
                handler : function(prev, next){
                    this.$emit("setformdata", this.formData);
                }
            }
        },
        computed: {},
        props: [],
        data: function () {
            return {
                formData:{
                    isPublic: false,
                    title: '',
                    dtype: 'DEATH',
                    content: '',
                    homepageUrl: '',
                    youtubeUrl: '',
                    readCount: 0,
                    files: [],
                    illpho: '',
                    outDate: '',
                    cemetery: '',
                    groom: '',
                    groomJob: '',
                    groomFather: '',
                    groomMother: '',
                    bride: '',
                    brideJob: '',
                    brideFather: '',
                    brideMother: '',
                    weddingDate: '',
                    place: '',
                    partyDate: '',
                    partyPlace: '',
                },
                acceptedFiles : 'image/*',
            }
        },
        methods: {
            init:function(){
                this.$emit("setformdata", this.formData);
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
        }
    }
</script>
