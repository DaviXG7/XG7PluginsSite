package com.xg7plugins.xg7plguinssite.models.extras;

import lombok.AllArgsConstructor;
import lombok.Getter;

import java.util.Date;

//Changelog de plugin
@Getter
@AllArgsConstructor
public class Changelog {

    private Date date;
    private String pluginVersion;
    private String changelogText;

}
