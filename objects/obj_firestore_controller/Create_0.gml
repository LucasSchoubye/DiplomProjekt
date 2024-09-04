/// @description Setup Firestore

db = FirebaseFirestore("/users")

db.Read();

function StartSession()
{	
	FirebaseFirestore("sessions/test session").Set({points: irandom(999999), value:"lol"})
}