<%--
  Created by IntelliJ IDEA.
  User: jskim
  Date: 2022/09/19
  Time: 16:02 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>

<script type="text/x-template" id="form-input-component">
    <div class="row">
        <label class="col-sm-2 col-form-label h-100 font-size-18">
            <sup class="color-deep-blue" v-if="required">*</sup>
            {{title}}
        </label>
        <div class="col-sm-10">
            <div class="form-input-div pb-3">
                <input :type="textType" :name="field" :value="data" @input="setData" class="form-control" :placeholder="placeholder" :maxlength="length > 0 ? length : ''" v-if="type == 'input'" />
                <textarea :name="field" :value="data" @input="setData" class="form-control" :placeholder="placeholder" :maxlength="length" v-else></textarea>
                <span class="max-length d-block px-2 bg-white color-border-gray" v-if="length > 0">{{data.length.toLocaleString('ko-KR')}}/{{length.toLocaleString('ko-KR')}}자</span>
            </div>
            <div class="form-input-div pb-3" v-if="description">
                {{description}}
            </div>
            <div :id="field + 'Error'" class="invalid-feedback"></div>
        </div>
    </div>
</script>


<script>
    var formInputComponent = {
        template: '#form-input-component',
        mounted: function () {
            this.textType = 'text';
        },
        watch: {
        },
        computed: {},
        props: ["title", "length", "placeholder", "description", "type", "required", "data", "field", 'textType'],
        data: function () {
            return {
            }
        },
        methods: {
            setData: function($e){
                this.$emit("setdata", this.field, $e.target.value);
            },
        }
    }
</script>
