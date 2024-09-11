import { useEffect, useState } from "react";
import { getDoc, doc, getDocs, collection } from "firebase/firestore";
import { Box, Typography, Button, Drawer, List, ListItem, ListItemText, Divider } from '@mui/material';
import { db } from "../config/firebase"; // Import Firestore

export const Database = ({ userData }) => {
    const [classes, setClasses] = useState([]);
    const [selectedClass, setSelectedClass] = useState(null); // To hold the selected class
    const [students, setStudents] = useState([]); // To hold the list of students for the selected class
    const [teacherName, setTeacherName] = useState(''); // Teacher's name for welcome message
    const [isViewingStudents, setIsViewingStudents] = useState(false); // Toggle between class and student view

    useEffect(() => {
        const fetchClasses = async () => {
            try {
                // Fetch the teacher document using the teacher's ref (userData.ref)
                console.log(userData.ref.id);
                const teacherDocRef = doc(db, "teachers", userData.ref.id); // Use doc() to create a document reference
                const teacherDoc = await getDoc(teacherDocRef);

                if (teacherDoc.exists()) {
                    // Get teacher's name
                    const teacherName = teacherDoc.data().fullName;
                    setTeacherName(teacherName);

                    // Fetch the "classRefs" sub-collection inside the teacherDoc
                    const classRefsCollectionRef = collection(teacherDocRef, "classRefs");
                    const classRefsSnapshot = await getDocs(classRefsCollectionRef);

                    // Map over the classRefs sub-collection and fetch each class document
                    const classPromises = classRefsSnapshot.docs.map(async (classRefDoc) => {
                        const classRefData = classRefDoc.data();
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
        setIsViewingStudents(true);  // Toggle to student view
        try {
            console.log(classData.classRefData.classRef.path);
            // Use the classRef from classData to dynamically construct the students collection path
            const studentsCollectionRef = collection(db, classData.classRefData.classRef.path, "students");

            // Fetch all documents from the students collection
            const studentsSnapshot = await getDocs(studentsCollectionRef);

            // Map over the documents, extract the "studentRef", and fetch each student document
            const studentPromises = studentsSnapshot.docs.map(async (studentDoc) => {
                const { studentRef } = studentDoc.data(); // Assuming "studentRef" exists in studentDoc
                const studentDocRef = doc(db, studentRef.path); // Get the actual student document reference
                const studentData = await getDoc(studentDocRef); // Fetch the student document
                return { id: studentData.id, ...studentData.data() }; // Return the student data
            });

            const studentList = await Promise.all(studentPromises); // Wait for all student promises to resolve
            setStudents(studentList); // Update the state with the fetched students
        } catch (err) {
            console.error("Error fetching students: ", err);
        }
    };

    const handleBackClick = () => {
        setIsViewingStudents(false);  // Go back to class list
        setSelectedClass(null);       // Clear selected class
        setStudents([]);              // Clear student list
    };

    return (
        <div>

            {/* Sidebar Drawer */}
            <Drawer
                variant="permanent"
                anchor="left"
                sx={{ width: 300, flexShrink: 0 }}
            >
                <Typography variant="h4" >Welcome, {teacherName} </Typography>
                <Box sx={{ width: 300, padding: 2 }}>
                    {/* Check if we're viewing students or classes */}
                    {isViewingStudents ? (
                        <Box>
                            {/* Back button */}
                            <Button variant="outlined" onClick={handleBackClick} fullWidth>
                                Back
                            </Button>

                            <Typography variant="h6" mt={2}>
                                Students in {selectedClass.className}
                            </Typography>
                            <Divider variant = "middle"></Divider>
                            <List>
                                {students.length > 0 ? (
                                    students.map((studentData, index) => (
                                        <Box key={studentData.id}>
                                            <ListItem button>
                                                <ListItemText primary={studentData.fullName} />
                                            </ListItem>
                                            {index < students.length - 1 && <Divider />} {/* Add divider between students */}
                                        </Box>
                                    ))
                                ) : (
                                    <Typography variant="body1">No students found</Typography>
                                )}
                            </List>
                        </Box>
                    ) : (
                        <Box>
                            <Typography variant="h6">Your Classes</Typography>
                            <Divider variant = "middle"></Divider>
                            <List>
                                {classes.map((classData, index) => (
                                    <Box key={classData.id}>
                                    <ListItem 
                                        button 
                                        onClick={() => handleClassClick(classData)}
                                    >
                                        <ListItemText primary={classData.className} />
                                    </ListItem>
                                    {index < classes.length - 1 && <Divider />} {/* Add divider between classes */}
                                </Box>
                                ))}
                            </List>
                        </Box>
                    )}
                </Box>
            </Drawer>
        </div>
    );
};
