<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'cell.label', default: 'Cell')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <a href="#edit-cell" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
        <div class="nav" role="navigation">
            <ul>
                <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
                <li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
                <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
            </ul>
        </div>
        <div id="edit-cell" class="content scaffold-edit" role="main">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message" role="status">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${this.cell}">
            <ul class="errors" role="alert">
                <g:eachError bean="${this.cell}" var="error">
                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                </g:eachError>
            </ul>
            </g:hasErrors>
            <g:form action="update" method="PUT">
                <g:hiddenField name="id" bean="${cellCommand}" />
                <g:hiddenField name="x" bean="${cellCommand}" />
                <g:hiddenField name="y" bean="${cellCommand}" />

                <fieldset class="form">
                    <f:field property="age" bean="${cellCommand}" />
                    <g:renderErrors bean="${cellCommand}" field="age" />

                    <div class="fieldcontain">
                        <label for="x">X</label>
                    <f:display property="x" bean="${cellCommand}" />
                    </div>

                    <div class="fieldcontain">
                        <label for="y">Y</label>
                        <f:display property="y" bean="${cellCommand}" />
                    </div>

                    <div class="fieldcontain">
                        <label for="neighbourList">Neigbours</label>
                        <g:select name="neighbourList" from="${cellCommand.neighbourList}" value="${cellCommand.neighbourList.id}" optionKey="id" multiple="true"/>
                    </div>


                </fieldset>
                <fieldset class="buttons">
                    <input class="save" type="submit" value="${message(code: 'default.button.update.label', default: 'Update')}" />
                </fieldset>
            </g:form>
        </div>
    </body>
</html>
