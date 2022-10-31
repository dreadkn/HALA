<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>
<jsp:include page="/WEB-INF/view/common/vue-datatable-pagination.jsp"/>
<jsp:include page="./component/user-new-search-component.jsp"/>
<jsp:include page="./component/group-component.jsp"/>
<jsp:include page="./component/preview-component.jsp"/>

<style>
    .dataTable th.sorting, .dataTable th.sorting_asc, .dataTable th.sorting_desc {
        padding-right: 20px !important;
    }

    .dataTable th.sorting_disabled {
        padding-right: .3rem;
    !important;
    }

    .dataTable th::before, .dataTable th::after {
        /*bottom: auto !important;*/
        /*display: inline !important;*/
    }

    .modal-lg-dialog {
        max-width: 60vw;
    }

    .hm-min {
        min-height: 50vh;
    }

    .address-wrap > .row {
        min-height: 50vh;
    }

    .address-wrap .list-group {
        border: 1px solid rgba(0, 0, 0, .125);
        height: 100%;
        max-height: 600px;
        overflow-y: auto;
    }

    .address-wrap .list-group:nth-child(2) {
        height: 92%;
    }

    .address-wrap .list-group-item {
        border: 0;
    }

    .address-group-wrap > .row {
        min-height: 50vh;
    }

    .address-group-wrap .list-group {
        border: 1px solid rgba(0, 0, 0, .125);
        height: 100%;
        max-height: 600px;
        overflow-y: auto;
    }

    .address-group-wrap .list-group:nth-child(2) {
        height: 92%;
    }

    .address-group-wrap .list-group-item {
        border: 0;
    }
</style>

<div id="vue-app" class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
        <div class="container-fluid">
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h4 class="m-0 text-dark">문자 발송</h4>
                </div>
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item active">회원 관리</li>
                        <li class="breadcrumb-item active">문자 발송</li>
                    </ol>
                </div>
            </div>
        </div>
    </div>
    <!-- /.content-header -->

    <!-- Main content -->
    <div class="content">
        <div class="container-fluid">
            <div class="row">
                <div class="col-12">
                    <div class="row">
                        <div class="col-4">
                            <div class="card card-light">
                                <div class="card-body p-3">
                                    <form>
                                        <div class="row align-items-center">
                                            <div class="col">
                                                <div class="form-group">
                                                    <textarea class="form-control" placeholder="메시지를 입력해주세요." rows="5" name="message" id="message"></textarea>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col">
                                                <div class="form-group">
                                                    <label>발신번호</label>
                                                    <select class="custom-select" id="senderNum">
                                                        <c:forEach items="${senderList}" var="item">
                                                            <option>${item.number}</option>
                                                        </c:forEach>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col">
                                                <div class="form-group">
                                                    <label>수신번호</label>
                                                    <button @click="searchUser" type="button" class="btn btn-sm btn-outline-primary row-detail ml-1 text-nowrap">검색</button>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col">
                                                <div class="form-group d-flex">
                                                    <input type="tel" class="form-control w-75" name="tel" id="tel" @keydown="addUserKey" onsubmit="return false;">
                                                    <button @click="addUser" type="button" class="btn btn-sm btn-outline-primary row-detail text-nowrap ml-1">추가</button>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row mb-3">
                                            <div class="col">
                                                <ul class="list-group">
                                                    <li class="list-group-item" v-for="(item, idx) in selectedMembers">
                                                        <i class="far fa-times-circle" @click="deleteUser(item.phone)"></i>
                                                        <span>{{item.name}}</span>
                                                        <span>{{item.phone}}</span>
                                                    </li>
                                                </ul>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col text-left">
                                                <button @click="openGroup" type="button" class="btn btn-sm btn-outline-primary row-detail text-nowrap ">그룹관리</button>
                                                <button @click="isAll = !isAll" type="button" class="btn btn-sm btn-outline-danger row-detail text-nowrap " :class="{'active' : isAll}">전체보내기</button>
                                            </div>
                                            <div class="col text-right">
                                                <button @click="openPreview" type="button" class="btn btn-sm btn-outline-primary row-detail text-nowrap ">전송</button>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                        <div class="col-8">
                            <div class="row">
                                <div class="col-4">
                                    <div class="card card-light">
                                        <div class="card-body p-0">
                                            <div>
                                                <div class="row">
                                                    <div class="col">
                                                        <div class="input-group">
                                                            <textarea class="form-control" rows="5" name="message" id="templateMessage" placeholder="템플릿 내용을 입력해주세요."></textarea>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="card-footer">
                                            <div class="row">
                                                <div class="col"></div>
                                                <div class="col text-right">
                                                    <button type="button" class="btn btn-sm btn-outline-primary row-detail mr-1 text-nowrap" @click="saveTemplate">저장</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <c:forEach items="${templateList}" var="item" varStatus="i">
                                    <div class="col-4" data-id="${item.id}">
                                        <div class="card card-light">
                                            <div class="card-body p-0">
                                                <div>
                                                    <div class="row">
                                                        <div class="col p-3">
                                                            <div class="input-group">
                                                                <h6>${item.templateName} (${item.templateCode})</h6>
                                                                <input type="hidden" class="form-control templateCode${item.templateCode}" value="${item.templateCode}">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col">
                                                            <div class="input-group">
                                                                <textarea class="form-control template${item.templateCode}" readonly rows="5"
                                                                          @click="selectionTemplate('${item.templateCode}')">${item.message}</textarea>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col p-3">
                                                            <div class="input-group">
                                                                <input type="text" class="form-control " placeholder="치환문자열" value="${item.templateValues}" readonly>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                                <c:forEach items="${page.content}" var="item" varStatus="i">
                                    <div class="col-4" data-id="${item.id}">
                                        <div class="card card-light">
                                            <div class="card-body p-0">
                                                <div>
                                                    <div class="row">
                                                        <div class="col">
                                                            <div class="input-group">
                                                                <textarea class="form-control template${item.id}" readonly rows="5" @change="udpateTemplate('${item.id}')"
                                                                          @click="selectionTemplate('${item.id}')">${item.message}</textarea>
                                                                <input type="hidden" class="form-control templateCode${item.id}" placeholder="템플릿코드" value="${item.templateCode}">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col p-3">
                                                            <div class="input-group">
                                                                <input type="text" class="form-control " placeholder="치환문자열" value="${item.templateValues}" readonly>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="card-footer">
                                                <div class="row">
                                                    <div class="col"></div>
                                                    <div class="col text-right h5 mb-0">
                                                        <i class="fas fa-edit mr-1" @click="editMode('${item.id}')"></i>
                                                        <i class="far fa-times-circle" @click="deleteTemplate('${item.id}')"></i>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <user-new-search-component ref="userSearchModal"></user-new-search-component>
    <group-component ref="groupModal"></group-component>
    <preview-component ref="previewModal"></preview-component>
</div>

<script>

    // Root
    var vm = new Vue({
        el: '#vue-app',
        mounted: function () {
            if ('${member}' != '')
                this.addUserByItem(JSON.parse('${member}'));
        },
        components: {
            'user-new-search-component': userNewSearchComponent,
            'group-component': groupComponent,
            'preview-component': previewComponent
        },
        data: {
            selectedMembers: [],
            templateCode: '',
            isAll: false,
            data: {
                message: "",
                templateCode: ""
            },
        },
        methods: {
            editMode: function (templateId) {
                $('.template' + templateId).prop('readonly', !$('.template' + templateId).is('[readonly]'));
            },
            saveTemplate: function () {
                var self = this;
                var url = "/admin/module/sms/template";

                self.data.message = $('#templateMessage').val();

                if (this.data.message != '') {
                    jQuery.ajax(url, {
                        method: 'POST',
                        contentType: 'application/json',
                        data: JSON.stringify(this.data),
                        dataType: 'json'
                    }).done(function (data) {
                        var callback = function (isConfirm) {
                            location.reload();
                        }
                        alertSuccessAfterCallback(callback, "등록되었습니다!");
                    }).fail(function (data) {
                        displayErrors(data);
                    });
                }
            },
            udpateTemplate: function (templateId) {
                var self = this;
                var url = "/admin/module/sms/template/" + templateId;

                this.data.message = $('.template' + templateId).val();
                this.data.templateCode = $('.templateCode' + templateId).val();

                jQuery.ajax(url, {
                    method: 'PUT',
                    contentType: 'application/json',
                    data: JSON.stringify(this.data),
                    dataType: 'json'
                }).done(function (data) {
                    var callback = function (isConfirm) {
                        $('.template' + templateId).prop('readonly', true);
                    }
                    alertUpdatedAfterCallback(callback);
                }).fail(function (data) {
                    displayErrors(data);
                    $('.template' + templateId).prop('readonly', true);
                });
            },
            deleteTemplate: function (templateId) {

                var callback = function (isConfirm) {
                    if (isConfirm) {
                        var url = "/admin/module/sms/template/" + templateId;
                        jQuery.ajax(url, {
                            method: 'DELETE',
                            contentType: 'application/json',
                            dataType: 'json'
                        }).done(function (data) {
                            var callback = function (isConfirm) {
                                location.reload();
                            }
                            alertDeletedAfterCallback(callback);
                        }).fail(function (data) {
                            displayErrors(data);
                        });
                    }
                }
                deleteConfirm(callback);
            },
            selectionTemplate: function (templateId) {
                if ($('.template' + templateId).is('[readonly]')) {
                    this.templateCode = $('.templateCode' + templateId).val();
                    $('#message').val($('.template' + templateId).val());
                }


            },
            searchUser: function () {
                this.$refs.userSearchModal.open(this.selectedMembers);
            },
            addUserKey: function (e) {
                if (e.keyCode == 13) {
                    e.preventDefault();
                    this.addUser();
                    return false;
                }
            },
            addUserByItem: function (user) {
                var self = this;
                if (user.phone != '') {
                    var item = {
                        id: user.id,
                        name: user.name,
                        phone: user.phone
                    }

                    self.selectedMembers.push(item);
                }
            },
            addUser: function () {
                var val = $('#tel').val();
                if (val != '') {
                    var item = {
                        phone: val
                    }
                    var filter = this.selectedMembers.filter(function (receiver) {
                        console.log(123);
                        return receiver.phone == val;
                    });

                    if (filter.length == 0) {
                        console.log(123);
                        this.selectedMembers.push(item);
                    }

                    $('#tel').val('');
                }
            },
            addUserList: function (list) {
                var self = this;
                self.selectedMembers = list;
            },
            deleteUser: function (phone) {
                var filter = this.selectedMembers.filter(function (receiver) {
                    return receiver.phone != phone;
                });
                this.selectedMembers = filter;
            },
            openGroup: function () {
                this.$refs.groupModal.open();
            },
            openPreview: function () {
                var self = this;
                var message = $('#message').val();
                if (message == '') {
                    alertWarning("메시지를 입력하세요.");
                    return false;
                }
                if (this.selectedMembers.length == 0) {
                    alertWarning("수신번호를 입력하세요.");
                    return false;
                }

                if (self.isAll) {
                    var callback = function (isConfirm) {
                        if (isConfirm) {
                            self.$refs.previewModal.open(message);
                        }
                    }
                    alertConfirm(callback, "전체 메시지를 보내시겠습니까?", "전체보내기가 활성화 되었습니다. 모든 회원에게 메시지가 발송됩니다.", "전송");
                } else {
                    this.$refs.previewModal.open(message);
                }
            },
            send: function () {
                var self = this;
                var message = $('#message').val();

                var request = {
                    templateCode: this.templateCode,
                    senderNum: $('#senderNum').val(),
                    receivers: []
                };

                $(this.selectedMembers).each(function () {
                    var item = {
                        receiverName: this.name,
                        receiverNum: this.phone,
                        userId: this.id,
                        message: message,
                        altMessage: message
                    }
                    request.receivers.push(item);
                });

                var callback = function () {
                    var url = self.isAll ? "/admin/module/sms/send/all" : "/admin/sms/send";
                    axios.post(url, request).then(function (res) {
                        if (res.data.isError)
                            alertWarning(res.data.errorMessage);
                        else {
                            var callback = function () {
                                location.reload();
                            };
                            alertSuccessAfterCallback(callback, "전송되었습니다.");
                        }
                    }).catch(function (err){
                        displayErrors(err);
                    })
                }
                callback();
            }
        }
    });

</script>

