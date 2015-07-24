CREATE TABLE uw_ColorThing_color(uw_id int8 NOT NULL, uw_nam text NOT NULL,
 PRIMARY KEY (uw_id),
  CONSTRAINT uw_ColorThing_color_Nam UNIQUE (uw_nam),
                                                     
   CONSTRAINT uw_ColorThing_color_IdGtZero CHECK (uw_id > 0::int8)
 );
 
 CREATE TABLE uw_ColorThing_thing(uw_id int8 NOT NULL, uw_nam text NOT NULL, 
                                   uw_color int8 NOT NULL,
  PRIMARY KEY (uw_id),
   CONSTRAINT uw_ColorThing_thing_Nam UNIQUE (uw_nam),
                                                      
    CONSTRAINT uw_ColorThing_thing_IdGtZero CHECK (uw_id > 0::int8),
                                                                    
    CONSTRAINT uw_ColorThing_thing_Color
     FOREIGN KEY (uw_color) REFERENCES uw_ColorThing_color (uw_id)
  );
  
  