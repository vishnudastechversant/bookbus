component entityname="city" persistent="true" table="br_city" {

	property name="id" column="id" fieldtype="id" generator="increment";
    property name="city" column="city" ormtype="text";
    property name="sateId" column="state_id" ormtype="text";
    property name="CreatedOn" column="created_on" ormtype="text";

}