component entityname="state" persistent="true" table="br_state" {
	property name="id" column="id" fieldtype="id" generator="increment";
    property name="State" column="state" ormtype="text";
    property name="CreatedOn" column="created_on" ormtype="text";
}
