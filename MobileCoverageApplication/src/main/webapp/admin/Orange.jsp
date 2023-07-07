<%@ page import="Helpers.PostgreConnection" %>
<%@ page import="Helpers.Point" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: DEWIDAR
  Date: 6/29/2023
  Time: 3:34 PM
  To change this template use File | Settings | File Templates.
--%>
<% PostgreConnection conn = new PostgreConnection();%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<!-- Created by CodingLab |www.youtube.com/CodingLabYT-->
<html lang="en" dir="ltr">

<head>
    <title>Mobile Coverage Insights</title>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/chart.js">

    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" />

    <!--<title> Responsive Sidebar Menu  | CodingLab </title>-->
    <link rel="stylesheet" href="css/side.css">
    <!-- Boxicons CDN Link -->
    <link href='https://unpkg.com/boxicons@2.0.7/css/boxicons.min.css' rel='stylesheet'>
    <link rel="shortcut icon" type="image/png" href="images/favicon.png">

    <link href="vendor/jquery-nice-select/css/nice-select.css" rel="stylesheet">
    <link rel="stylesheet" href="vendor/nouislider/nouislider.min.css">

    <!-- Style css -->
    <!-- <link href="css/style.css" rel="stylesheet">  -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href='https://fonts.googleapis.com/css?family=Dancing Script' rel='stylesheet'>
    <!-- <link rel="stylesheet" href="css/style1.css" /> -->

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

<div class="vodafone" style="width: 23%; ">
    <img src="images/Screenshot 2023-06-30 001858.png" width="50" height="50" style="border-radius: 15px;">
    <h1
            style="font-family:  'Dancing Script','Poppins'; font-size: 47px;font-weight:600; color: #fc780b; padding-left: 10px;">
        Orange Egypt</h1>
</div>


<div class="middleOperator">
    <div id="map"></div>

</div>
<div class="socialOperator">
    <a class="btn btn-primary" style="background-color: #3b5998;" href="#!" role="button"><i
            class="fab fa-facebook-f"></i></a>


    <a class="btn btn-primary" style="background-color: #55acee;" href="#!" role="button"><i
            class="fab fa-twitter"></i></a>


    <a class="btn btn-primary" style="background-color: #dd4b39;" href="#!" role="button"><i
            class="fab fa-google"></i></a>
    <a class="btn btn-primary" style="background-color: #0082ca;" href="#!" role="button"><i
            class="fab fa-linkedin-in"></i></a>
</div>
<div class="handset">
    <h1 id="title">Handsets</h1>
    <div class="handsetInfo">
        <h3 class="info" style="color: rgb(4, 92, 164);">SAMSUNG: <%= conn.noOfPhoneType("orange","samsung") %></h3>
        <h3 class="info" style="color: rgb(3, 105, 3); ">OPPO: <%= conn.noOfPhoneType("orange","oppo") %></h3>
        <h3 class="info" style="color: rgb(154, 4, 4);">HUAWEI: <%= conn.noOfPhoneType("orange","huawei") %></h3>
        <h3 class="info" style="color: rgb(229, 151, 6);">REALME: <%= conn.noOfPhoneType("orange","realme") %></h3>
        <h3 class="info" style="color: rgb(183, 164, 0);">XIAOMI: <%= conn.noOfPhoneType("orange","xiaomi") %></h3>
        <h3 class="info" style="color: rgb(9, 9, 9);">OTHERs: 0</h3>
    </div>
</div>

<div class="signalStrength">
    <h1 id="titlee">Signal</h1>
    <div style="height: 220px;">
        <canvas id="doughnut_chart"></canvas>
    </div>
</div>
<div class="analyticsOperator">
    <div class="row invoice-card-row">
        <div class="col-xl-3 col-xxl-3 col-sm-4">
            <div class="card bg-warning invoice-card">
                <div class="card-body d-flex">
                    <div class="icon me-3">
                        <svg width="33px" height="32px">
                            <path fill-rule="evenodd" fill="rgb(255, 255, 255)"
                                  d="M31.963,30.931 C31.818,31.160 31.609,31.342 31.363,31.455 C31.175,31.538 30.972,31.582 30.767,31.583 C30.429,31.583 30.102,31.463 29.845,31.243 L25.802,27.786 L21.758,31.243 C21.502,31.463 21.175,31.583 20.837,31.583 C20.498,31.583 20.172,31.463 19.915,31.243 L15.872,27.786 L11.829,31.243 C11.622,31.420 11.370,31.534 11.101,31.572 C10.832,31.609 10.558,31.569 10.311,31.455 C10.065,31.342 9.857,31.160 9.710,30.931 C9.565,30.703 9.488,30.437 9.488,30.167 L9.488,17.416 L2.395,17.416 C2.019,17.416 1.658,17.267 1.392,17.001 C1.126,16.736 0.976,16.375 0.976,16.000 L0.976,6.083 C0.976,4.580 1.574,3.139 2.639,2.076 C3.703,1.014 5.146,0.417 6.651,0.417 L26.511,0.417 C28.016,0.417 29.459,1.014 30.524,2.076 C31.588,3.139 32.186,4.580 32.186,6.083 L32.186,30.167 C32.186,30.437 32.109,30.703 31.963,30.931 ZM9.488,6.083 C9.488,5.332 9.189,4.611 8.657,4.080 C8.125,3.548 7.403,3.250 6.651,3.250 C5.898,3.250 5.177,3.548 4.645,4.080 C4.113,4.611 3.814,5.332 3.814,6.083 L3.814,14.583 L9.488,14.583 L9.488,6.083 ZM29.348,6.083 C29.348,5.332 29.050,4.611 28.517,4.080 C27.985,3.548 27.263,3.250 26.511,3.250 L11.559,3.250 C12.059,4.111 12.324,5.088 12.325,6.083 L12.325,27.092 L14.950,24.840 C15.207,24.620 15.534,24.500 15.872,24.500 C16.210,24.500 16.537,24.620 16.794,24.840 L20.837,28.296 L24.880,24.840 C25.137,24.620 25.463,24.500 25.802,24.500 C26.140,24.500 26.467,24.620 26.724,24.840 L29.348,27.092 L29.348,6.083 ZM25.092,20.250 L16.581,20.250 C16.205,20.250 15.844,20.101 15.578,19.835 C15.312,19.569 15.162,19.209 15.162,18.833 C15.162,18.457 15.312,18.097 15.578,17.831 C15.844,17.566 16.205,17.416 16.581,17.416 L25.092,17.416 C25.469,17.416 25.829,17.566 26.096,17.831 C26.362,18.097 26.511,18.457 26.511,18.833 C26.511,19.209 26.362,19.569 26.096,19.835 C25.829,20.101 25.469,20.250 25.092,20.250 ZM25.092,14.583 L16.581,14.583 C16.205,14.583 15.844,14.434 15.578,14.168 C15.312,13.903 15.162,13.542 15.162,13.167 C15.162,12.791 15.312,12.430 15.578,12.165 C15.844,11.899 16.205,11.750 16.581,11.750 L25.092,11.750 C25.469,11.750 25.829,11.899 26.096,12.165 C26.362,12.430 26.511,12.791 26.511,13.167 C26.511,13.542 26.362,13.903 26.096,14.168 C25.829,14.434 25.469,14.583 25.092,14.583 ZM25.092,8.916 L16.581,8.916 C16.205,8.916 15.844,8.767 15.578,8.501 C15.312,8.236 15.162,7.875 15.162,7.500 C15.162,7.124 15.312,6.764 15.578,6.498 C15.844,6.232 16.205,6.083 16.581,6.083 L25.092,6.083 C25.469,6.083 25.829,6.232 26.096,6.498 C26.362,6.764 26.511,7.124 26.511,7.500 C26.511,7.875 26.362,8.236 26.096,8.501 C25.829,8.767 25.469,8.916 25.092,8.916 Z">
                            </path>
                        </svg>

                    </div>
                    <div>
                        <h2 class="text-white invoice-num"><%=conn.noOfCitiesByOperator("orange")%></h2>
                        <span class="text-white fs-18">Total Cites</span>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-xl-3 col-xxl-3 col-sm-6">
            <div class="card bg-success invoice-card">
                <div class="card-body d-flex">
                    <div class="icon me-3">
                        <svg width="35px" height="34px">
                            <path fill-rule="evenodd" fill="rgb(255, 255, 255)"
                                  d="M32.482,9.730 C31.092,6.789 28.892,4.319 26.120,2.586 C22.265,0.183 17.698,-0.580 13.271,0.442 C8.843,1.458 5.074,4.140 2.668,7.990 C0.255,11.840 -0.509,16.394 0.514,20.822 C1.538,25.244 4.224,29.008 8.072,31.411 C10.785,33.104 13.896,34.000 17.080,34.000 L17.286,34.000 C20.456,33.960 23.541,33.044 26.213,31.358 C26.991,30.866 27.217,29.844 26.725,29.067 C26.234,28.291 25.210,28.065 24.432,28.556 C22.285,29.917 19.799,30.654 17.246,30.687 C14.627,30.720 12.067,29.997 9.834,28.609 C6.730,26.671 4.569,23.644 3.752,20.085 C2.934,16.527 3.546,12.863 5.486,9.763 C9.488,3.370 17.957,1.418 24.359,5.414 C26.592,6.808 28.360,8.793 29.477,11.157 C30.568,13.460 30.993,16.016 30.707,18.539 C30.607,19.448 31.259,20.271 32.177,20.371 C33.087,20.470 33.911,19.820 34.011,18.904 C34.363,15.764 33.832,12.591 32.482,9.730 L32.482,9.730 Z">
                            </path>
                            <path fill-rule="evenodd" fill="rgb(255, 255, 255)"
                                  d="M22.593,11.237 L14.575,19.244 L11.604,16.277 C10.952,15.626 9.902,15.626 9.250,16.277 C8.599,16.927 8.599,17.976 9.250,18.627 L13.399,22.770 C13.725,23.095 14.150,23.254 14.575,23.254 C15.001,23.254 15.427,23.095 15.753,22.770 L24.940,13.588 C25.592,12.937 25.592,11.888 24.940,11.237 C24.289,10.593 23.238,10.593 22.593,11.237 L22.593,11.237 Z">
                            </path>
                        </svg>

                    </div>
                    <div>
                        <h2 class="text-white invoice-num"><%=conn.noOfCellsByOperator("orange")%></h2>
                        <span class="text-white fs-18">Total Cells</span>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-xl-3 col-xxl-3 col-sm-6">
            <div class="card bg-secondary invoice-card">
                <div class="card-body d-flex">
                    <div class="icon me-3">
                        <svg width="33px" height="32px">
                            <path fill-rule="evenodd" fill="rgb(255, 255, 255)"
                                  d="M31.963,30.931 C31.818,31.160 31.609,31.342 31.363,31.455 C31.175,31.538 30.972,31.582 30.767,31.583 C30.429,31.583 30.102,31.463 29.845,31.243 L25.802,27.786 L21.758,31.243 C21.502,31.463 21.175,31.583 20.837,31.583 C20.498,31.583 20.172,31.463 19.915,31.243 L15.872,27.786 L11.829,31.243 C11.622,31.420 11.370,31.534 11.101,31.572 C10.832,31.609 10.558,31.569 10.311,31.455 C10.065,31.342 9.857,31.160 9.710,30.931 C9.565,30.703 9.488,30.437 9.488,30.167 L9.488,17.416 L2.395,17.416 C2.019,17.416 1.658,17.267 1.392,17.001 C1.126,16.736 0.976,16.375 0.976,16.000 L0.976,6.083 C0.976,4.580 1.574,3.139 2.639,2.076 C3.703,1.014 5.146,0.417 6.651,0.417 L26.511,0.417 C28.016,0.417 29.459,1.014 30.524,2.076 C31.588,3.139 32.186,4.580 32.186,6.083 L32.186,30.167 C32.186,30.437 32.109,30.703 31.963,30.931 ZM9.488,6.083 C9.488,5.332 9.189,4.611 8.657,4.080 C8.125,3.548 7.403,3.250 6.651,3.250 C5.898,3.250 5.177,3.548 4.645,4.080 C4.113,4.611 3.814,5.332 3.814,6.083 L3.814,14.583 L9.488,14.583 L9.488,6.083 ZM29.348,6.083 C29.348,5.332 29.050,4.611 28.517,4.080 C27.985,3.548 27.263,3.250 26.511,3.250 L11.559,3.250 C12.059,4.111 12.324,5.088 12.325,6.083 L12.325,27.092 L14.950,24.840 C15.207,24.620 15.534,24.500 15.872,24.500 C16.210,24.500 16.537,24.620 16.794,24.840 L20.837,28.296 L24.880,24.840 C25.137,24.620 25.463,24.500 25.802,24.500 C26.140,24.500 26.467,24.620 26.724,24.840 L29.348,27.092 L29.348,6.083 ZM25.092,20.250 L16.581,20.250 C16.205,20.250 15.844,20.101 15.578,19.835 C15.312,19.569 15.162,19.209 15.162,18.833 C15.162,18.457 15.312,18.097 15.578,17.831 C15.844,17.566 16.205,17.416 16.581,17.416 L25.092,17.416 C25.469,17.416 25.829,17.566 26.096,17.831 C26.362,18.097 26.511,18.457 26.511,18.833 C26.511,19.209 26.362,19.569 26.096,19.835 C25.829,20.101 25.469,20.250 25.092,20.250 ZM25.092,14.583 L16.581,14.583 C16.205,14.583 15.844,14.434 15.578,14.168 C15.312,13.903 15.162,13.542 15.162,13.167 C15.162,12.791 15.312,12.430 15.578,12.165 C15.844,11.899 16.205,11.750 16.581,11.750 L25.092,11.750 C25.469,11.750 25.829,11.899 26.096,12.165 C26.362,12.430 26.511,12.791 26.511,13.167 C26.511,13.542 26.362,13.903 26.096,14.168 C25.829,14.434 25.469,14.583 25.092,14.583 ZM25.092,8.916 L16.581,8.916 C16.205,8.916 15.844,8.767 15.578,8.501 C15.312,8.236 15.162,7.875 15.162,7.500 C15.162,7.124 15.312,6.764 15.578,6.498 C15.844,6.232 16.205,6.083 16.581,6.083 L25.092,6.083 C25.469,6.083 25.829,6.232 26.096,6.498 C26.362,6.764 26.511,7.124 26.511,7.500 C26.511,7.875 26.362,8.236 26.096,8.501 C25.829,8.767 25.469,8.916 25.092,8.916 Z">
                            </path>
                        </svg>

                    </div>
                    <div>
                        <h2 class="text-white invoice-num"><%=conn.noOfCellsByOperator("orange")%></h2>
                        <span class="text-white fs-18">Total Measurements</span>
                    </div>
                </div>
            </div>
        </div>
    </div>



</div>

<script src="vendor/chart.js/Chart.bundle.min.js"></script>
<script src="js/plugins-init/chartjs-init.js"></script>
<script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>

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
<!-- <div id="map"></div> -->
<script>
    function initMap() {
        var map = L.map('map').setView([30.8, 31.2357], 8);

        L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
            attribution: 'Map data &copy; <a href="https://www.openstreetmap.org/">OpenStreetMap</a> contributors',
        }).addTo(map);

        // Sample point data
        var points = [];

        <% List<Point> pointsList = conn.getPointsByOperator("orange");
        String lat;
        String lon;
        double signalStrength;
        String city;
        if (pointsList != null) {
            for (Point point : pointsList) {
               if(point.getLatitude() != null && point.getLatitude() != null && point.getSignalStrength() != null && point.getCity() != null){
                 lat = point.getLatitude();
                 lon = point.getLongitude();
                 signalStrength = point.getSignalStrength();
                 city = point.getCity();
                }
                                else{
                                    continue;
                                }
        %>
        points.push({lat: <%= lat %>, lon: <%= lon %>, signalStrength: <%= signalStrength %>, city: "<%= city %>"});
        <% } } %>

        var orangeIcon = new L.Icon({
            iconUrl: 'https://raw.githubusercontent.com/pointhi/leaflet-color-markers/master/img/marker-icon-2x-gold.png',
            shadowUrl: 'https://cdnjs.cloudflare.com/ajax/libs/leaflet/0.7.7/images/marker-shadow.png',
            iconSize: [25, 41],
            iconAnchor: [12, 41],
            popupAnchor: [1, -34],
            shadowSize: [41, 41]
        });

        // Add markers and circles for the points
        points.forEach(function (point) {
            // Create the marker
            var marker = L.marker([point.lon, point.lat],{ icon: orangeIcon }).addTo(map);

            var tooltipContent = "<strong>City:</strong> " + point.city + "<br>" +
                "<strong>Signal Strength:</strong> " + point.signalStrength * 100 + " dBm" + "<br>" +
                "<strong>Latitude:</strong> " + point.lat + "<br>" + "<strong>Longitude:</strong> " + point.lon;

            // Add the tooltip to the marker
            marker.bindTooltip(tooltipContent);

            // Determine the circle color based on signal strength
            var circleColor;
            if (point.signalStrength >= 0.7) {
                circleColor = '#00FF00'; // Green
            } else if (point.signalStrength >= 0.4) {
                circleColor = '#FFFF00'; // Yellow
            } else {
                circleColor = '#FF0000'; // Red
            }

            // Create the circle
            var circle = L.circle([point.lon, point.lat], {
                color: circleColor,
                opacity: 0.8,
                weight: 2,
                fillColor: circleColor,
                fillOpacity: 0.35,
                radius: 100 // Radius in meters
            }).addTo(map);
        });
    }

    // Call the function to initialize the map
    initMap();
</script>

<script>
    var ctxx = document.getElementById('doughnut_chart').getContext('2d');
    var chart = new Chart(ctxx, {
        type: 'doughnut',
        data: {
            labels: ['Excellent', 'Good', 'Poor'],
            datasets: [{
                data: [<%=conn.getPowerPercentage("orange","100","70")%>, <%=conn.getPowerPercentage("orange","70","40")%>, <%=conn.getPowerPercentage("orange","40","0")%>],
                backgroundColor: ['#28a745', '#ffc107', '#ff0000']
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            legend: {
                position: 'bottom',
                labels: {
                    fontColor: 'black',
                    fontSize: 14
                }
            },
            animation: {
                animateRotate: true,
                animateScale: true
            },
            tooltips: {
                callbacks: {
                    label: function (tooltipItem, data) {
                        var dataset = data.datasets[tooltipItem.datasetIndex];
                        var total = dataset.data.reduce(function (previousValue, currentValue, currentIndex, array) {
                            return previousValue + currentValue;
                        });
                        var currentValue = dataset.data[tooltipItem.index];
                        var percentage = Math.floor(((currentValue / total) * 100) + 0.5);
                        return percentage + "%";
                    }
                }
            }
        }
    });
</script>
</body>

</html>
