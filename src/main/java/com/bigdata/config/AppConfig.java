/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.bigdata.config;

import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
/**
 *
 * @author jafernandez
 */

@Configuration
@EnableWebMvc
@ComponentScan(basePackages = "com.bigdata")
public class AppConfig {
    
}