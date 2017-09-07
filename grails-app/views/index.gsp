<!doctype html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Welcome to Grails</title>

    <asset:link rel="icon" href="favicon.ico" type="image/x-ico" />
</head>
<body>
    <content tag="nav">
        <li class="dropdown">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Controllers <span class="caret"></span></a>
            <ul class="dropdown-menu">
                <g:each var="c" in="${grailsApplication.controllerClasses.sort { it.name } }">
                    <li class="controller">
                        <g:link controller="${c.logicalPropertyName}">${c.name}</g:link>
                    </li>
                </g:each>
            </ul>
        </li>
    </content>

    <div id="content" role="main">
        <section class="row colset-2-its">
            <h1>Conway's Game of Life</h1>

            <p>
                see: <a href="https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life" target="_blank">https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life</a>
            </p>
            <p>
                gitHub: <a href="https://github.com/jascha84/game_of_life" target="_blank">https://github.com/jascha84/game_of_life</a>
            </p>

            <hr>
            <p>
                <g:link controller="grid">START</g:link>
            </p>
            <hr>

        </section>
    </div>

</body>
</html>
