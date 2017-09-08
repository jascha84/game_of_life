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

            <table id="grid-info">
                <thead>
                <tr>
                    <th>id</th>
                    <th>name</th>
                    <th>x</th>
                    <th>y</th>
                    <th>generation</th>
                </tr>
                </thead>
                <tbody>
                <td><f:display property="id" bean="${grid}" /></td>
                <td><f:display property="name" bean="${grid}" /></td>
                <td><f:display property="x" bean="${grid}" /></td>
                <td><f:display property="y" bean="${grid}" /></td>
                <td><f:display property="gridGeneration" bean="${grid}" /></td>
                </tbody>
            </table>

            <g:render template="game_of_life_table" />

            <g:link class="delete" action="delete" controller="grid" id="${grid.id}"><g:message code="default.button.delete.label" default="Del" /></g:link>

            <a href="#" id="start-game-of-life">START</a>
            <a href="#" id="stop-game-of-life" style="display:none;">STOP</a>
            <img id="spinner" style="display:none;" src="${createLinkTo(dir: 'images', file: 'spinner.gif')}" alt="Spinner"/>
            <label>generation: </label><label id="generation">${grid.gridGeneration}</label>

            <g:javascript library="jquery" plugin="jquery">
                $(document).ready(function() {
                    var isRunning = false;
                    getCellData();

                     $('.game-of-life-grid-cell').click(function () {
                        if (!isRunning){
                            toggleCell($(this), $(this).attr('data-col'), $(this).attr('data-row'), $(this).attr('data-grid-id'))
                        }
                    });

                    $('#start-game-of-life').click(function() {
                        isRunning = true;
                        $('#start-game-of-life').hide()
                        $('#stop-game-of-life').show()
                        $('#spinner').show()
                        getCellData();
                    })

                    $('#stop-game-of-life').click(function() {
                        isRunning = false;
                        $('#stop-game-of-life').hide()
                        $('#start-game-of-life').show()
                        $('#spinner').hide()
                    })

                    function getCellData() {
                         $.getJSON('/grid/evolute/' + ${grid.id} + '?running='+isRunning, function(result){
                            if (result.cellList.length > 1){

                                $(".hasCell").each(function() {
                                  $(this).removeClass("hasCell")
                                })
                                $.each(result.cellList, function(i, cell){
                                    $('[data-col="'+ cell.x + '"][data-row="' + cell.y +'"]').addClass("hasCell")
                                })

                                $("#generation").text(result.gridGeneration)
                                if (isRunning){
                                    getCellData();
                                }
                            }
                        });
                    }
                });


                function toggleCell(td, col, row, gridId){

                    if (td.hasClass("hasCell")){
                        doThePost("/cell/deleteJson", col, row, gridId)

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
