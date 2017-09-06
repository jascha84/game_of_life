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
                doThePost("/cell/delete", col, row, gridId)

            } else {
                doThePost("/cell/save", col, row, gridId)
            }

            td.classList.toggle("hasCell")

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

   </script>
