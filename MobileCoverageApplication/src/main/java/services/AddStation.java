package services;

import Helpers.BaseStation;
import Helpers.BaseStationResource;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/addStation")
public class AddStation extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        BaseStationResource baseStationResource = new BaseStationResource();
        BaseStation neew = new BaseStation("El Fayoum","Egypt","eg","30.8418 29.30995","122","602","02","vodafone","90","El Fayoum","Huawei");
        baseStationResource.createBaseStation(neew);
    }

}
