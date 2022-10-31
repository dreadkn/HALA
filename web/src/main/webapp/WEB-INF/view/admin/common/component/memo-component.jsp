<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>

<script type="text/x-template" id="memo-component">
    <div class="card card-light">
        <div class="card-header">
            <div class="d-flex justify-content-between">
                <h3 class="card-title">메모</h3>
            </div>
        </div>

        <div class="card-body">
            <form>
                <div class="form-row">
                    <div class="form-group col-md-12">
                        <div class="d-flex justify-content-between mb-1">
                            <label for="etcInfo">기타정보</label>
                            <sec:authorize url="/admin/chargers/*/etc" var="hasPermissionByEtc" />
                            <c:if test="${hasPermissionByEtc}">
                                <button type="button" class="btn btn-sm btn-primary" @click="saveEtc">저장</button>
                            </c:if>
                        </div>
                        <div class="input-group">
                            <c:choose>
                                <c:when test="${hasPermissionByEtc}">
                                    <textarea rows="4" class="form-control" id="etcInfo" name="etcInfo" v-model="memoInfo.etcInfo" aria-label="기타정보"></textarea>
                                </c:when>
                                <c:otherwise>
                                    <textarea rows="4" class="form-control" id="etcInfo" name="etcInfo" v-model="memoInfo.etcInfo" aria-label="기타정보" readonly></textarea>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    <div class="form-group col-md-12 mb-0">
                        <div class="d-flex justify-content-between mb-1">
                            <label for="etcInfo">메모</label>
                            <sec:authorize url="/admin/chargers/*/memo" var="hasPermissionByMemo" />
                            <c:if test="${hasPermissionByMemo}">
                                <button type="button" class="btn btn-sm btn-primary" @click="saveMemo">저장</button>
                            </c:if>
                        </div>
                        <div class="input-group">
                            <c:choose>
                                <c:when test="${hasPermissionByMemo}">
                                    <textarea rows="4" class="form-control" id="memo" name="memo" v-model="memoInfo.memo" aria-label="메모"></textarea>
                                </c:when>
                                <c:otherwise>
                                    <textarea rows="4" class="form-control" id="memo" name="memo" v-model="memoInfo.memo" aria-label="메모" readonly></textarea>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </form>
        </div>
        <%--<div class="card-footer">
            <div class="row justify-content-end">
                <div class="col-auto"><button type="button" class="btn btn-primary" @click="save">메모 저장</button></div>
            </div>
        </div>--%>
    </div>
</script>

<script>
    var memoComponent = {
        template: '#memo-component',
        data: function () {
            return {
                memoInfo: {
                    etcInfo: '',
                    memo: ''
                }
            }
        },
        methods: {
            setMemo: function(etcInfo, memo) {
                this.memoInfo.etcInfo = etcInfo;
                this.memoInfo.memo = memo;
            },
            saveEtc: function () {
                this.$emit('save-etc', this.memoInfo.etcInfo);
            },
            saveMemo: function () {
                this.$emit('save-memo', this.memoInfo.memo);
            }
        }
    }
</script>
