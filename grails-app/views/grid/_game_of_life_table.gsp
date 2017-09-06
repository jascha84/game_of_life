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
                     <td class="game-of-life-grid-cell <% if (cellList.findAll{it.x == col && it.y == row}) { out << 'hasCell' } %>" data-col="${col}" data-row="${row}" data-grid-id="${grid.id}" > </td>
                <%  } %>
            </tr>
        <%} %>

    </table>

