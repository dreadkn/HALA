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
<jsp:include page="/WEB-INF/view/user/component/form-image-component.jsp"/>
<jsp:include page="/WEB-INF/view/user/component/form-link-component.jsp"/>
<jsp:include page="/WEB-INF/view/common/user-dropzone.jsp"/>

<script type="text/x-template" id="family-event-wedding-form-component">
    <div>
        <form-input-component :title="'제목'" :placeholder="''" :description="''" :length="0" :type="'input'" :data="formData.title" :field="'title'" @setdata="setData"></form-input-component>
        <form-input-component :title="'신랑'" :placeholder="''" :description="''" :length="0" :type="'input'" :data="formData.groom" :field="'groom'" @setdata="setData"></form-input-component>
        <form-input-component :title="'신랑 직업'" :placeholder="''" :description="''" :length="0" :type="'input'" :data="formData.groomJob" :field="'groomJob'" @setdata="setData"></form-input-component>
        <form-input-component :title="'신랑 아버지'" :placeholder="''" :description="''" :length="0" :type="'input'" :data="formData.groomFather" :field="'groomFather'" @setdata="setData"></form-input-component>
        <form-input-component :title="'신랑 어머니'" :placeholder="''" :description="''" :length="0" :type="'input'" :data="formData.groomMother" :field="'groomMother'" @setdata="setData"></form-input-component>


        <form-input-component :title="'신부'" :placeholder="''" :description="''" :length="0" :type="'input'" :data="formData.bride" :field="'bride'" @setdata="setData"></form-input-component>
        <form-input-component :title="'신부 직업'" :placeholder="''" :description="''" :length="0" :type="'input'" :data="formData.brideJob" :field="'brideJob'" @setdata="setData"></form-input-component>
        <form-input-component :title="'신부 아버지'" :placeholder="''" :description="''" :length="0" :type="'input'" :data="formData.brideFather" :field="'brideFather'" @setdata="setData"></form-input-component>
        <form-input-component :title="'신부 어머니'" :placeholder="''" :description="''" :length="0" :type="'input'" :data="formData.brideMother" :field="'brideMother'" @setdata="setData"></form-input-component>


        <form-input-component :title="'일시'" :placeholder="''" :description="''" :length="0" :type="'input'" :data="formData.weddingDate" :field="'weddingDate'" @setdata="setData"></form-input-component>
        <form-input-component :title="'장소'" :placeholder="''" :description="''" :length="0" :type="'input'" :data="formData.place" :field="'place'" @setdata="setData"></form-input-component>

        <form-input-component :title="'피로연 일시'" :placeholder="''" :description="''" :length="0" :type="'input'" :data="formData.partyDate" :field="'partyDate'" @setdata="setData"></form-input-component>
        <form-input-component :title="'피로연 장소'" :placeholder="''" :description="''" :length="0" :type="'input'" :data="formData.partyPlace" :field="'partyPlace'" @setdata="setData"></form-input-component>


        <dropzone-component ref="dropzone" :files="formData.files" :delete="false" :max-files="10" :accepted-files="acceptedFiles"></dropzone-component>
        <form-link-component :type="'homepage'" :url-data="formData.homepageUrl" :url-field="'homepageUrl'" :title-data="formData.homepageTitle" :title-field="'homepageTitle'" @setdata="setData"></form-link-component>
        <form-link-component :type="'youtube'" :url-data="formData.youtubeUrl" :url-field="'youtubeUrl'" @setdata="setData"></form-link-component>

    </div>
</script>


<script>
    var familyEventWeddingFormComponent = {
        template: '#family-event-wedding-form-component',
        components: {
            'form-input-component': formInputComponent,
            'form-image-component': formImageComponent,
            'form-link-component': formLinkComponent,
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
                    dtype: 'WEDDING',
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
        }
    }
</script>
