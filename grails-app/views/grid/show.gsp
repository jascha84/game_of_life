<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'grid.label', default: 'Grid')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
        <a href="#show-grid" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
        <div class="nav" role="navigation">
            <ul>
                <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
                <li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
                <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
            </ul>
        </div>
        <div id="show-grid" class="content scaffold-show" role="main">
            <h1><g:message code="default.show.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
                <div class="message" role="status">${flash.message}</div>
            </g:if>

            <table id="grid-info">
                <thead>
                <tr>
                    <th>id</th>
                    <th>name</th>
                    <th>x</th>
                    <th>y</th>
                </tr>
                </thead>
                <tbody>
                    <td><f:display property="id" bean="${grid}" /></td>
                    <td><f:display property="name" bean="${grid}" /></td>
                    <td><f:display property="x" bean="${grid}" /></td>
                    <td><f:display property="y" bean="${grid}" /></td>
                </tbody>
            </table>

            <style>
                #game-of-life-grid {width: 0}
                #game-of-life-grid tr:hover {background: none}
                #game-of-life-grid tr>td:last-child, tr>th:last-child {padding-right: 0.6em;}
                #game-of-life-grid tr>td:first-child, tr>th:first-child  {padding-left: 0.6em;}
                #game-of-life-grid tr td {border: 1px solid;}
                #game-of-life-grid tr td:hover {background: lightgreen}
                .hasCell {background: red}
            </style>

            <table id="game-of-life-grid" >
                <% (1..grid.x).each { col -> %>
                    <tr>
                        <% (1..grid.y).each { row -> %>
                            <td onclick="toggleCell(this, ${col}, ${row}, ${grid.id})"
                                <% if (cellList.findAll{it.x == col && it.y == row}) { %>
                                 <% out << 'class="hasCell"' %>
                                <% } %>
                            > </td>
                        <%  } %>
                    </tr>
                <%} %>

            </table>
            <script>
                function toggleCell(td, col, row, gridId){

                    if (td.classList.contains("hasCell")){
                        var xhttp = new XMLHttpRequest();
                        xhttp.onreadystatechange = function() {
                            if (this.readyState == 4 && this.status == 200) {
//                                console.log(this.responseText)
                            }
                        };
                        xhttp.open("POST", "/cell/delete", true);
                        xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
                        xhttp.send("x=" + col + "&y=" + row + "&grid=" + gridId );

                    } else {
                        var xhttp = new XMLHttpRequest();
                        xhttp.onreadystatechange = function() {
                            if (this.readyState == 4 && this.status == 200) {
//                                console.log(this.responseText)
                            }
                        };
                        xhttp.open("POST", "/cell/save", true);
                        xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
                        xhttp.send("age=1&x=" + col + "&y=" + row + "&grid=" + gridId );
                    }

                    td.classList.toggle("hasCell")

                }
            </script>
            <g:link class="delete" action="delete" controller="grid" id="${grid.id}"><g:message code="default.button.delete.label" default="Del" /></g:link>
            <g:link class="evolute" action="evolute" controller="grid" id="${grid.id}">EVOLUTE</g:link>
        </div>
    </body>
</html>
