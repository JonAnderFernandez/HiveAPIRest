/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this templatitudee file, choose Tools | Templatitudees
 * and open the templatitudee in the editor.
 */
package com.bigdata.model;

/**
 *
 * @author jafernandez
 */
public class IpGeolocation {

    private String ip_start;
    private String ip_end;
    private String country;
    private String stateProv;
    private String district;
    private String city;
    private String zip_code;
    private float latitude;
    private float longitude;
    private int geoname_id;
    private float timezone_offset;
    private String timezone_type;
    private String isp_name;
    private String connection_type;
    private String organization_name;

    public IpGeolocation() {
    }

    public IpGeolocation(String ip_start, String ip_end, String country, String stateProv, String district, String city, String zip_code, float latitude, float longitude, int geoname_id, float timezone_offset, String timezone_type, String isp_name, String connection_type, String organization_name) {
        this.ip_start = ip_start;
        this.ip_end = ip_end;
        this.country = country;
        this.stateProv = stateProv;
        this.district = district;
        this.city = city;
        this.zip_code = zip_code;
        this.latitude = latitude;
        this.longitude = longitude;
        this.geoname_id = geoname_id;
        this.timezone_offset = timezone_offset;
        this.timezone_type = timezone_type;
        this.isp_name = isp_name;
        this.connection_type = connection_type;
        this.organization_name = organization_name;
    }

    public String getIpStart() {
        return ip_start;
    }

    public void setIpStart(String ip_start) {
        this.ip_start = ip_start;
    }

    public String getIpEnd() {
        return ip_end;
    }

    public void setIpEnd(String ip_end) {
        this.ip_end = ip_end;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public String getStateprov() {
        return stateProv;
    }

    public void setStateprov(String stateProv) {
        this.stateProv = stateProv;
    }

    public String getDistrict() {
        return district;
    }

    public void setDistrict(String district) {
        this.district = district;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getZipcode() {
        return zip_code;
    }

    public void setZipcode(String zip_code) {
        this.zip_code = zip_code;
    }

    public float getLatitude() {
        return latitude;
    }

    public void setLatitude(float latitude) {
        this.latitude = latitude;
    }

    public float getLongitude() {
        return longitude;
    }

    public void setLongitude(float longitude) {
        this.longitude = longitude;
    }

    public int getGeoname_id() {
        return geoname_id;
    }

    public void setGeoname_id(int geoname_id) {
        this.geoname_id = geoname_id;
    }

    public float getTimezone_offset() {
        return timezone_offset;
    }

    public void setTimezone_offset(float timezone_offset) {
        this.timezone_offset = timezone_offset;
    }

    public String getTimezone_type() {
        return timezone_type;
    }

    public void setTimezone_type(String timezone_type) {
        this.timezone_type = timezone_type;
    }

    public String getIsp_name() {
        return isp_name;
    }

    public void setIsp_name(String isp_name) {
        this.isp_name = isp_name;
    }

    public String getConnection_type() {
        return connection_type;
    }

    public void setConnection_type(String connection_type) {
        this.connection_type = connection_type;
    }

    public String getOrganization_name() {
        return organization_name;
    }

    public void setOrganization_name(String organization_name) {
        this.organization_name = organization_name;
    }
}
