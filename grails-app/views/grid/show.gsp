<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <asset:javascript src="application.js"/>
        <asset:stylesheet src="application.css"/>
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

            <g:render template="game_of_life_table" />

            <g:link class="delete" action="delete" controller="grid" id="${grid.id}"><g:message code="default.button.delete.label" default="Del" /></g:link>

            <a href="#" id="start-game-of-life">START</a>
            <a href="#" id="stop-game-of-life" style="display:none;">STOP</a>
            <img id="spinner" style="display:none;" src="${createLinkTo(dir: 'images', file: 'spinner.gif')}" alt="Spinner"/>

            <g:javascript library="jquery" plugin="jquery">
                $(document).ready(function() {
                    $('.game-of-life-grid-cell').click(function () {
                        toggleCell($(this), $(this).attr('data-col'), $(this).attr('data-row'), $(this).attr('data-grid-id'))
                    });

                    var isRunning = false;

                    $('#start-game-of-life').click(function() {
                        isRunning = true;
                        $('#start-game-of-life').hide()
                        $('#stop-game-of-life').show()
                        $('#spinner').show()
                    })

                    $('#stop-game-of-life').click(function() {
                        isRunning = false;
                        $('#stop-game-of-life').hide()
                        $('#start-game-of-life').show()
                        $('#spinner').hide()
                    })
                    setInterval(function() {
                        if (isRunning){
                            isRunning = false;
                            $( "#game-of-life-grid" ).load( '/grid/evolute/' + ${grid.id} + ' #game-of-life-grid' );
                            isRunning = true;
                        }
                    }, 1000);
                });

                function toggleCell(td, col, row, gridId){

                    if (td.hasClass("hasCell")){
                        doThePost("/cell/delete", col, row, gridId)

                    } else {
                        doThePost("/cell/save", col, row, gridId)
                    }

                    td.toggleClass("hasCell")

                }

                function doThePost(endpoint, col, row ,gridId) {
                    var xhttp = new XMLHttpRequest();
                    xhttp.onreadystatechange = function() {
                        if (this.readyState == 4 && this.status == 200) {
//                                console.log(this.responseText)
                        }
                    };
                    xhttp.open("POST", endpoint, true);
                    xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
                    xhttp.send("x=" + col + "&y=" + row + "&grid=" + gridId );
                }

            </g:javascript>

        </div>
    </body>
</html>
