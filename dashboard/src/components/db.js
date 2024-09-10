import { useEffect, useState } from "react";
import { getDoc, doc, getDocs, collection } from "firebase/firestore";
import { Box, Typography, Button } from '@mui/material';
import { db } from "../config/firebase"; // Import Firestore

export const Database = ({ userData }) => {
    const [classes, setClasses] = useState([]);
    const [selectedClass, setSelectedClass] = useState(null); // To hold the selected class
    const [students, setStudents] = useState([]); // To hold the list of students for the selected class
    const [teacherName, setTeacherName] = useState([]);
    
    useEffect(() => {
        const fetchClasses = async () => {
            try {
                // Fetch the teacher document using the teacher's ref (userData.ref)
                console.log(userData.ref.id);
                
                const teacherDocRef = doc(db, "teachers", userData.ref.id); // Use doc() to create a document reference
                const teacherDoc = await getDoc(teacherDocRef);
                

                if (teacherDoc.exists()) {
                    // const teacherData = teacherDoc.data();
                    setTeacherName(teacherDoc.data().fullName);
                    // Fetch the "classRefs" sub-collection inside the teacherDoc
                    const classRefsCollectionRef = collection(teacherDocRef, "classRefs"); 
                    const classRefsSnapshot = await getDocs(classRefsCollectionRef);

                    // Map over the classRefs sub-collection and fetch each class document
                    const classPromises = classRefsSnapshot.docs.map(async (classRefDoc) => {
                        const classRefData = classRefDoc.data();
                        // console.log(classRefData);
                        const classDoc = await getDoc(classRefData.classRef); // Fetch the class document
                        return { id: classRefData.classRef.id, classRefData, ...classDoc.data() }; // Return class data
                    });

                    const classData = await Promise.all(classPromises); // Wait for all classes to be fetched
                    setClasses(classData);
                }
            } catch (err) {
                console.error("Error fetching classes: ", err);
            }
        };

        fetchClasses();
    }, [userData]);

    const handleClassClick = async (classData) => {
        setSelectedClass(classData); // Set the selected class when clicked
        try {
            console.log(classData.classRefData.classRef.path);
            // Use the classRef from classData to dynamically construct the students collection path
            const studentsCollectionRef = collection(db, classData.classRefData.classRef.path, "students");

            // Fetch all documents from the students collection
            const studentsSnapshot = await getDocs(studentsCollectionRef);

             // Map over the documents, extract the "studentRef", and fetch each student document
            const studentPromises = studentsSnapshot.docs.map(async (studentDoc) => {
                const { studentRef } = studentDoc.data(); // Assuming "studentRef" exists in studentDoc
                console.log(studentRef);
                const studentDocRef = doc(db, studentRef.path); // Get the actual student document reference
                const studentData = await getDoc(studentDocRef); // Fetch the student document

                return { id: studentData.id, ...studentData.data() }; // Return the student data
            });

        const studentList = await Promise.all(studentPromises); // Wait for all student promises to resolve
        console.log(studentList);

            setStudents(studentList); // Update the state with the fetched students
        } catch (err) {
            console.error("Error fetching students: ", err);
        }
    };

    return (
        <div>
            <Typography variant="h4">Welcome, {teacherName}</Typography>

            {/* Display the list of classes */}
            <Box display="flex" flexDirection="column" gap={2}>
                <Typography variant="h6">Your Classes:</Typography>
                {classes.map((classData) => (
                    <Button 
                        variant="contained"
                        key={classData.id}
                        onClick={() => handleClassClick(classData)}
                    >
                        {classData.className} {/* Assuming classData has a className field */}
                    </Button>
                ))}
            </Box>

             {/* Show selected class details and students list */}
             {selectedClass && (
                <Box mt={4}>
                    <Typography variant="h5">Selected Class: {selectedClass.className}</Typography>
                    
                    {/* Display the list of students */}
                    <Typography variant="h6" mt={2}>Students:</Typography>
                    <Box display="flex" flexDirection="column" gap={2}>
                        {students.length > 0 ? (
                            students.map((studentData) => (
                                <Button 
                                    key={studentData.id}
                                    variant="outlined"
                                    onClick={() => console.log(`Clicked on student ${studentData.id}`)} // Action when student is clicked
                                >
                                    {studentData.fullName} {/* Assuming studentData has a fullName field */}
                                </Button>
                            ))
                        ) : (
                            <Typography variant="body1">No students found</Typography>
                        )}
                    </Box>
                </Box>
            )}
        </div>
    );
};
