<%--
  Created by IntelliJ IDEA.
  User: jskim
  Date: 2022/09/19
  Time: 16:02 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>

<script type="text/x-template" id="form-link-component">
    <div class="row" v-if="type == 'homepage'">
        <label class="col-sm-2 col-form-label">홈페이지 링크</label>
        <div class="col-sm-10">
            <div class="form-input-div pb-3" v-if="false">
                <input type="text" :name="titleField" placeholder="링크 제목을 입력하세요" class="form-control" :value="titleData" @input="setData" :data-field="titleField" />
            </div>
            <div class="form-input-div pb-3">
                <input type="text" :name="urlField" placeholder="URL을 입력하세요" class="form-control" :value="urlData" @input="setData" :data-field="urlField"  />
            </div>
            <div class="form-input-div pb-3">
                홈페이지 링크 등록시 입력하신 제목으로 게시글에 바로가기 버튼이 생성됩니다.
            </div>
            <div :id="urlField + 'Error'" class="invalid-feedback"></div>
        </div>
    </div>
    <div class="row" v-else>
        <label class="col-sm-2 col-form-label">유튜브 링크</label>
        <div class="col-sm-10">
            <div class="form-input-div pb-3">
                <input type="text" :name="urlField" placeholder="URL을 입력하세요" class="form-control" :value="urlData" @input="setData" :data-field="urlField" />
            </div>
            <div class="form-input-div pb-3">
                유튜브 링크 등록시 게시글에 바로가기 버튼이 생성됩니다.
            </div>
            <div :id="urlField + 'Error'" class="invalid-feedback"></div>
        </div>
    </div>
</script>


<script>
    var formLinkComponent = {
        template: '#form-link-component',
        mounted: function () {
        },
        watch: {},
        computed: {},
        props: ["type", "urlData", "urlField", "titleData", "titleField"],
        data: function () {
            return {
            }
        },
        methods: {
            setData: function($e){
                var field = $e.target.getAttribute("data-field");
                this.$emit("setdata", field, $e.target.value);
            },
        }
    }
</script>
