<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="Grid"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>
<div class="nav" role="navigation">
    <ul>
        <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
        <li><g:link class="create" action="create"><g:message code="default.new.label"
                                                              args="[entityName]"/></g:link></li>
    </ul>
</div>

<div id="cell-list" class="content scaffold-list" role="main">
    <h1><g:message code="default.list.label" args="[entityName]"/></h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>

    <table>
        <thead>
        <tr>
            <th>id</th>
            <th>name</th>
            <th>x</th>
            <th>y</th>
            <th>generation</th>
            <th>action</th>
        </tr>
        </thead>
        <tbody>
        <g:each var="grid" in="${gridList}">
            <tr>
                <td><f:display property="id" bean="${grid}"/></td>
                <td><f:display property="name" bean="${grid}"/></td>
                <td><f:display property="x" bean="${grid}"/></td>
                <td><f:display property="y" bean="${grid}"/></td>
                <td><f:display property="gridGeneration" bean="${grid}"/></td>
                <td>
                    <g:link class="show" action="show" controller="grid" id="${grid.id}"><g:message code="default.show.label"
                                                                                                    default="Show"/></g:link>
                </td>
            </tr>
        </g:each>
        </tbody>
    </table>

</div>
</body>
</html>