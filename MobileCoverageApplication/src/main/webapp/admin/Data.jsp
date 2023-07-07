<%@ page import="Helpers.PostgreConnection" %>
<%@ page import="org.jboss.logging.annotations.Pos" %>
<%@ page import="Helpers.BaseStation" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<!-- Created by CodingLab |www.youtube.com/CodingLabYT-->
<html lang="en" dir="ltr">

<head>
    <title>Mobile Coverage Insights</title>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.4/css/dataTables.bootstrap5.min.css">
    <link rel="stylesheet" href="css/side.css">
    <link href='https://unpkg.com/boxicons@2.0.7/css/boxicons.min.css' rel='stylesheet'>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href='https://fonts.googleapis.com/css?family=Dancing Script' rel='stylesheet'>

    <style>
        #map {
            height: 100%;
            width: 100%;
            /* border-radius: 30px; */
        }
    </style>

</head>

<body>
<div class="sidebar">
    <div class="logo-details">
        <i class='bx bxl-c-plus-plus icon'></i>
        <!-- <i class="bi bi-bag-heart-fill"></i> -->
        <div class="logo_name">INSIGHTS</div>
        <i class='bx bx-menu' id="btn"></i>
    </div>
    <ul class="nav-list">
        <li>
            <i class='bx bx-search'></i>
            <input type="text" placeholder="Search...">
            <span class="tooltip">Search</span>
        </li>
        <li>
            <a href="Admin.jsp">
                <i class='bx bx-grid-alt'></i>
                <span class="links_name">Dashboard</span>
            </a>
            <span class="tooltip">Dashboard</span>
        </li>
        <li>
            <a href="Data.jsp">
                <i class='bx bx-user'></i>
                <span class="links_name">Data</span>
            </a>
            <span class="tooltip">Data</span>
        </li>
        <li>
            <a href="Vodafone.jsp">
                <i class='bx bx-station'></i>
                <span class="links_name">Vodafone</span>
            </a>
            <span class="tooltip">Vodafone</span>
        </li>
        <li>
            <a href="Etisalat.jsp">
                <i class='bx bx-station'></i>
                <span class="links_name">Etisalat</span>
            </a>
            <span class="tooltip">Etisalat</span>
        </li>
        <li>
            <a href="Orange.jsp">
                <i class='bx bx-station'></i>
                <span class="links_name">Orange</span>
            </a>
            <span class="tooltip">Orange</span>
        </li>
        <li>
            <a href="We.jsp">
                <i class='bx bx-station'></i>
                <span class="links_name">WE</span>
            </a>
            <span class="tooltip">WE</span>
        </li>

        <li>
            <a href="#">
                <i class='bx bx-log-out' id="log_out"></i>
                <span class="links_name">Sign Out</span>
            </a>
            <span class="tooltip">Sign Out</span>
        </li>
    </ul>
</div>

<div class="middleData">
    <table id="example" class="table table-striped">
        <thead>
        <tr>
            <th>ID</th>
            <th>Country</th>
            <th>City</th>
            <th>Operator</th>
            <th>MCC</th>
            <th>MNC</th>
            <th>SignalStrength</th>
            <th>Latitude</th>
            <th>Longitude</th>
        </tr>
        </thead>
        <tbody>
        <%
            PostgreConnection conn = new PostgreConnection();
            List<BaseStation> cells = conn.getAllData();
            for (BaseStation cell : cells) {
        %>
        <tr>
            <td>
                <%=cell.getId()%>
            </td>
            <td>
                <%=cell.getCountry()%>
            </td>
            <td>
                <%=cell.getCity()%>
            </td>
            <td>
                <%=cell.getOperatorName()%>
            </td>
            <td>
                <%=cell.getMcc()%>
            </td>
            <td><%=cell.getMnc()%>
            </td>
            <td>
                <%=cell.getSignalStrengthInfo()%>
            </td>
            <td>
                <%=cell.getLatitude()%>
            </td>
            <td>
                <%=cell.getLongitude()%>
            </td>
        </tr>
        <% } %>
        </tbody>
        <tfoot>
        <tr>
            <th>ID</th>
            <th>Country</th>
            <th>City</th>
            <th>Operator</th>
            <th>MCC</th>
            <th>MNC</th>
            <th>SignalStrength</th>
            <th>Latitude</th>
            <th>Longitude</th>
        </tr>
        </tfoot>
    </table>
</div>



<!-- <script src="vendor/chart.js/Chart.bundle.min.js"></script> -->
<!-- <script src="js/plugins-init/chartjs-init.js"></script> -->

<script>
    let sidebar = document.querySelector(".sidebar");
    let closeBtn = document.querySelector("#btn");
    let searchBtn = document.querySelector(".bx-search");
    sidebar.classList.toggle("open");
    closeBtn.addEventListener("click", () => {
        sidebar.classList.toggle("open");
        menuBtnChange();//calling the function(optional)
    });

    searchBtn.addEventListener("click", () => { // Sidebar open when you click on the search iocn
        sidebar.classList.toggle("open");
        menuBtnChange(); //calling the function(optional)
    });

</script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.13.4/js/dataTables.bootstrap5.min.js"></script>
<script type="text/javascript" class="init">$(document).ready(function () {
    $('#example').DataTable();
});</script>
</body>

</html>