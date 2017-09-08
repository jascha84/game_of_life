<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="Cell"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>
<div class="nav" role="navigation">
    <ul>
        <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
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
                <th>x</th>
                <th>y</th>
                <th>action</th>
            </tr>
        </thead>
        <tbody>
            <g:each var="cell" in="${cellList}">
                <tr>
                    <td><f:display property="id" bean="${cell}"/></td>
                    <td><f:display property="x" bean="${cell}"/></td>
                    <td><f:display property="y" bean="${cell}"/></td>
                    <td>
                        <g:link class="show" action="show" controller="cell" id="${cell.id}"><g:message code="default.show.label"  args="['']" default="Show"/></g:link>
                        <g:link class="delete" action="delete" controller="cell" id="${cell.id}"><g:message
                        code="default.button.delete.label" default="Delete"/></g:link>
                    </td>
                </tr>
            </g:each>
        </tbody>
    </table>

    <div class="pagination">
        <g:paginate total="${cellCount ?: 0}"/>
    </div>

</div>
</body>
</html>