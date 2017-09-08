<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'cell.label', default: 'Cell')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <a href="#show-cell" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
        <div class="nav" role="navigation">
            <ul>
                <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
                <li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
            </ul>
        </div>
        <div id="show-cell" class="content scaffold-show" role="main">
            <h1><g:message code="default.show.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>

            <table>
                <thead>
                <tr>
                    <th>id</th>
                    <th>x</th>
                    <th>y</th>
                </tr>
                </thead>
                <tbody>
                    <td><f:display property="id" bean="${cell}" /></td>
                    <td><f:display property="x" bean="${cell}" /></td>
                    <td><f:display property="y" bean="${cell}" /></td>
                </tbody>
            </table>

            <g:link class="delete" action="delete" controller="cell" id="${cell.id}"><g:message code="default.button.delete.label" default="Del" /></g:link>
        </div>
    </body>
</html>
