class GetBusinessDaysFunction < ActiveRecord::Migration
  def up
    connection.execute(%q{
      CREATE function uGetBussinessDays(in_sdate DATE,
        in_edate DATE) RETURNS VARCHAR(100) AS $$
        DECLARE
          l_count INT;
          l_sdate DATE;

        BEGIN
          CREATE TEMPORARY TABLE IF NOT EXISTS _tblBussinessDays(BussinessDays date);
          CREATE TEMPORARY TABLE IF NOT EXISTS _tblHolidaysDays(Offdays date);

          delete from _tblBussinessDays;
          delete from _tblHolidaysDays;

          l_sdate = in_sdate;
          -- to_char(l_sdate, 'day') returns full lower case day name (blank-padded to 9 chars)

          WHILE l_sdate <= in_edate LOOP
            IF (to_char(l_sdate, 'day') = 'sunday   ' ) THEN
              INSERT INTO _tblHolidaysDays VALUES(l_sdate);
            ELSIF ( to_char(l_sdate, 'day') = 'saturday ' ) THEN
              INSERT INTO _tblHolidaysDays VALUES(l_sdate);
            ELSE
              INSERT INTO _tblBussinessDays VALUES(l_sdate);
            END IF;
            l_sdate = l_sdate + '1 day'::INTERVAL;

          END LOOP;

          SELECT count(BussinessDays) INTO l_count FROM _tblBussinessDays;
          return l_count ;
        END;
        $$ language plpgsql;
    })
  end

  def down
    connection.execute(%q{
        drop function uGetBussinessDays(DATE, DATE)
      })
  end
end
