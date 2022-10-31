<%--
  Created by IntelliJ IDEA.
  User: jskim
  Date: 2022/09/19
  Time: 16:02 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>

<script type="text/x-template" id="form-input-list-component">
    <div class="row">
        <label class="col-sm-2 col-form-label h-100">{{title}}</label>
        <div class="col-sm-10">
            <div class="form-input-div input-group pb-3" v-for="(row, idx) in listData">
                <input type="text" :name="field" :value="row" class="form-control" @input="setData" :data-idx="idx" :placeholder="placeholder" :maxlength="length > 0 ? length : ''" />
                <button class="btn btn-outline-secondary" type="button"  @click="deleteRow" :data-idx="idx">-</button>
            </div>
            <div class="form-input-div input-group pb-3">
                <input type="text" :name="field" class="form-control" ref="inputData" @keyup="addRowInput" :data-idx="rows" :placeholder="placeholder" :maxlength="length > 0 ? length : ''" />
                <button class="btn btn-outline-secondary" type="button"  @click="addRowBtn">+</button>
            </div>
            <div class="form-input-div pb-3" v-if="description">
                {{description}}
            </div>
            <div :id="field + 'Error'" class="invalid-feedback"></div>
        </div>
    </div>
</script>


<script>
    var formInputListComponent = {
        template: '#form-input-list-component',
        mounted: function () {
        },
        watch: {},
        computed: {},
        props: ["title", "length", "placeholder", "description", "listData", "field"],
        data: function () {
            return {
                rows: 0
            }
        },
        methods: {
            addRowInput: function($e){
                if($e.keyCode == 13){
                    this.addRow(this.$refs.inputData.value);
                }
            },
            addRowBtn: function(){
                this.addRow(this.$refs.inputData.value);
            },
            setData: function($e){
                var idx = $e.target.getAttribute("data-idx");
                this.$emit("setdata", this.field, idx, $e.target.value);
            },
            deleteRow: function($e){
                var idx = $e.target.getAttribute("data-idx");
                this.$emit("deleterow", this.field, idx);
            },
            addRow: function(val){
                if(val.length > 0){
                    this.rows = this.rows + 1;
                    this.$emit("addrow", this.field, val);
                    this.$refs.inputData.value="";
                }
            }
        }
    }
</script>
