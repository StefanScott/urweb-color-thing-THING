table color : {
  Id : int, 
  Nam : string
}
  PRIMARY KEY Id,
  CONSTRAINT Nam UNIQUE Nam,
  CONSTRAINT IdGtZero CHECK Id > 0

table thing : {
  Id : int,
  Nam : string,
  Color : int
}
  PRIMARY KEY Id,
  CONSTRAINT Nam UNIQUE Nam,
  CONSTRAINT IdGtZero CHECK Id > 0,
  CONSTRAINT Color FOREIGN KEY Color REFERENCES color(Id)

structure THING = struct
  fun list () =
    rows <- queryX1 
              (SELECT * FROM thing)
              (fn r => 
                <xml><tr>
                  <td>{[r.Id]}</td> <td>{[r.Nam]}</td> <td>{[r.Color]}</td>
                  <td><form><submit action={delete r.Id} value="Delete"/></form></td>
                </tr></xml>);
    return <xml>
      <table border=1>
        <tr> <th>Id</th> <th>Nam</th> <th>Color</th> </tr>
        {rows}
      </table>

      <br/><hr/><br/>

      <form>
        <table>
          <tr> <th>Id:</th> <td><textbox{#Id}/></td> </tr>
          <tr> <th>Nam:</th> <td><textbox{#Nam}/></td> </tr>
          <tr> <th>Color:</th> <td><textbox{#Color}/></td> </tr>
          <tr> <th/> <td><submit action={add} value="Add Thing"/></td> </tr>
        </table>
      </form>
    </xml>

  and add r =
    dml ( INSERT INTO thing ( Id, Nam, Color )
          VALUES ( {[readError r.Id]}, {[r.Nam]}, {[readError r.Color]} )
        );
    xml <- list ();
    return <xml><body>
      <p>Thing added.</p>
       {xml}
    </body></xml>

  and delete id () =
    dml ( DELETE FROM thing WHERE Id = {[id]} );
    xml <- list ();
    return <xml><body>
      <p>Thing deleted.</p>
       {xml}
    </body></xml>

  and main () =
    xml <- list ();
    return <xml><body>
      {xml}
    </body></xml>
end

fun main () = return <xml><body>
  Go to:<br/>
  <li> <a link = {THING.main ()}>Things</a></li>
</body></xml>

