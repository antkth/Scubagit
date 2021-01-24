package com.scuba.information;

import org.springframework.stereotype.Component;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Component
public class InformationVO {
private String CountryName,CountryImage,CityName,CityExp,Season,CityImage;
private String DivingName,DivingExp,DivingRating,DivingDepthMin,DivingDepthMax;
private String FishName,FishExp,FishImage,HauntingCity;
private int AveTemper;
private double CityXpoint,CityYpoint,DivingXpoint,DivingYpoint;
}
