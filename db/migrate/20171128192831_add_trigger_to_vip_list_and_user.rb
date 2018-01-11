class AddTriggerToVipListAndUser < ActiveRecord::Migration[5.1]
  def up
    execute <<-SQL
      CREATE OR REPLACE FUNCTION add_vip_user_func() RETURNS TRIGGER AS $vip_lists$
      DECLARE
        BEGIN
            UPDATE users
            SET is_vip = TRUE
            WHERE id = NEW.user_id;

            IF NOT FOUND THEN 
            RAISE EXCEPTION 'User id % not found', NEW.user_id;
            RETURN NULL;
            END IF;
            RETURN NEW;
        END;
      $vip_lists$ LANGUAGE plpgsql;
     SQL
     execute <<-SQL
          CREATE TRIGGER add_vip_user_trigg
          BEFORE INSERT OR UPDATE
          ON vip_lists
          FOR EACH ROW
          EXECUTE PROCEDURE add_vip_user_func();
      SQL
  end
  def down
    execute <<-SQL
      DROP TRIGGER IF EXISTS add_vip_user_trigg ON vip_lists;
      DROP FUNCTION add_vip_user_func();
     SQL
  end
end
