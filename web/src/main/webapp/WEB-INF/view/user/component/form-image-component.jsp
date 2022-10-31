<%--
  Created by IntelliJ IDEA.
  User: jskim
  Date: 2022/09/19
  Time: 16:02 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>

<script type="text/x-template" id="form-image-component">
    <div class="row">
        <label class="col-sm-2 col-form-label">{{label}}</label>
        <div class="col-sm-10">
            <div class="pb-3">
                <button type="button" class="bg-border-gray py-3 px-5" @click="btnFileUpload">이미지 등록</button>
                <input type="file" ref="inputFile" class="d-none" accept="image/*" @change="setData" multiple />
            </div>
            <div class="upload-thumbnail d-grid pb-3">
                <div class="upload-thumbnail-wrapper position-relative" v-for="n in 4">
                    <img src="/resources/img/sub/article_thumbnail_sample.png" class="img-fluid w-100" />
                    <button class="delete-img d-flex justify-content-center align-items-center position-absolute rounded-circle"></button>
                </div>
            </div>
        </div>
    </div>
</script>


<script>
    var formImageComponent = {
        template: '#form-image-component',
        mounted: function () {
        },
        watch: {},
        computed: {},
        props: ["title", "data", "field"],
        data: function () {
            return {
                prevData: this.data,
                label: this.title ? this.title : '이미지'
            }
        },
        methods: {
            btnFileUpload:function(){
                var self = this;
                self.$refs.inputFile.click();
            },
            setData: function($e){
                var files = $e.target.files;
                for(var i=0; i < files.length; i++){
                    this.prevData.push(files[i]);
                }
                this.$emit("setdata", this.field, this.prevData);
            }
        }
    }
</script>
