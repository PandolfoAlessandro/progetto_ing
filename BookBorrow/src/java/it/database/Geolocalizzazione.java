/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package it.database;

import it.elbuild.jcoord.LatLng;
import it.elbuild.jcoord.resolver.GeoCodeResolver;
import java.math.BigDecimal;

/**
 *
 * @author insan3
 */
public class Geolocalizzazione {

    public static String getCoordinate(String indirizzo) {
        LatLng coord = null;
        BigDecimal lat = null;
        BigDecimal lon = null;
        int count = 0;
        do {
            try {
                count++;
                
                coord = GeoCodeResolver.findCoordForAddress(indirizzo);

                lat = coord.getLat();
                lon = coord.getLng();

            } catch (NullPointerException e) {
                count++;
            }
        } while (!(coord instanceof LatLng) || count <= 10);
        return lat+" "+lon;
    }
}
