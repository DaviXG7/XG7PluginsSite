package com.xg7plugins.xg7plguinssite.models.extras;

import lombok.AllArgsConstructor;
import lombok.Getter;

import java.sql.Date;
import java.sql.Timestamp;

//Changelog de plugin
@Getter
@AllArgsConstructor
public class Changelog {

    private Timestamp date;
    private String pluginVersion;
    private String changelogText;

}
