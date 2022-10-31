<%--
  Created by IntelliJ IDEA.
  User: jskim
  Date: 2022/09/20
  Time: 15:20 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/include/tags.jspf" %>

<script type="text/x-template" id="people-dictionary-article-component">
    <a :href="'/peopleDictionary/' + peopleDictionary.id" class="peopleDictionary-article-container d-block">
        <div class="peopleDictionary-info">
            <span class="fw-bold">{{peopleDictionary.krName}}</span>
            <div class="d-inline-flex justify-content-center align-items-center">
                <span class="separator-right">{{peopleDictionary.cnName}}</span>
                {{peopleDictionary.enName}}
            </div>
            <div class="d-flex flex-column flex-sm-row justify-content-start align-items-start mt-4">
                <div class="peopleDictionary-image-wrapper mx-auto mb-4 ml-sm-0 mr-sm-4 mb-sm-0 text-center">
                    <img :src="getImage(peopleDictionary.fileId)" class="img-fluid" />
                </div>
                <div>
                    <table>
                        <tr>
                            <th class="align-top pr-3 pb-2 fw-bolder">년생</th>
                            <td class="pb-2">
                                {{peopleDictionary.birthYear}}
                            </td>
                        </tr>
                        <tr>
                            <th class="align-top pr-3 pb-2 fw-bolder">직위</th>
                            <td class="pb-2">
                                {{peopleDictionary.position}}
                            </td>
                        </tr>
                        <tr>
                            <th class="align-top pr-3 pb-2 fw-bolder">학력</th>
                            <td class="pb-2">
                                <ul>
                                    <li v-for="(school, idx) in getStringToArray(peopleDictionary.education)">
                                        {{school}}
                                    </li>
                                </ul>
                            </td>
                        </tr>
                        <tr>
                            <th class="align-top pr-3 fw-bolder">경력</th>
                            <td>
                                <ul>
                                    <li v-for="(career, idx) in getStringToArray(peopleDictionary.career)">
                                        {{career}}
                                    </li>
                                </ul>
                            </td>
                        </tr>

                    </table>
                </div>
            </div>
        </div>
    </a>
</script>


<script>
    var peopleDictionaryArticleComponent = {
        template: '#people-dictionary-article-component',
        mounted: function () {
        },
        watch: {},
        computed: {},
        props: ["peopleDictionary"],
        data: function () {
            return {
            }
        },
        methods: {
            getStringToArray : function(str){
                str = this.lineToComma(str);
                return str.split(',');
            },
            lineToComma : function(html){
                html = html.replace(/\r\n/gi, ',');
                html = html.replace(/\\n/gi, ',');
                html = html.replace(/\n/gi, ',');
                return html
            },
            getImage : function(id){
                return id == null ? '/resources/img/common/no-image.png' : '/files/' + id;
            },
        }
    }
</script>
