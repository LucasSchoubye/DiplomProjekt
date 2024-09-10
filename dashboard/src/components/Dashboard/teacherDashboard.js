import { useEffect, useState } from "react";
import { getDoc, doc, getDocs, collection } from "firebase/firestore";
import { db } from "../../config/firebase.js"; // Import Firestore
import DrawerLayout from './drawerLayout.js';
import ClassList from './classList.js';
import StudentList from './studentList.js';
import StudentStats from "./studentStats.js";

export const TeacherDashboard = ({ userData ,handleReceiveAnswerMap }) => {
    const [classes, setClasses] = useState([]);
    const [selectedClass, setSelectedClass] = useState(null);
    const [students, setStudents] = useState([]);
    const [teacherName, setTeacherName] = useState('');
    const [isViewingStudents, setIsViewingStudents] = useState(false);
    const [isLoadingStudents, setIsLoadingStudents] = useState(false);
    const [answerMap, setAnswerMap] = useState({});

    useEffect(() => {
        const fetchClasses = async () => {
            try {
                const teacherDocRef = doc(db, "teachers", userData.ref.id);
                const teacherDoc = await getDoc(teacherDocRef);

                if (teacherDoc.exists()) {
                    const teacherName = teacherDoc.data().fullName;
                    setTeacherName(teacherName);

                    const classRefsCollectionRef = collection(teacherDocRef, "classRefs");
                    const classRefsSnapshot = await getDocs(classRefsCollectionRef);

                    const classPromises = classRefsSnapshot.docs.map(async (classRefDoc) => {
                        const classRefData = classRefDoc.data();
                        const classDoc = await getDoc(classRefData.classRef);
                        return { id: classRefData.classRef.id, classRefData, ...classDoc.data() };
                    });

                    const classData = await Promise.all(classPromises);
                    setClasses(classData);
                }
            } catch (err) {
                console.error("Error fetching classes: ", err);
            }
        };

        fetchClasses();
    }, [userData]);

    const handleClassClick = async (classData) => {
        setSelectedClass(classData);
        setIsViewingStudents(true);
        setIsLoadingStudents(true);
        try {
            const studentsCollectionRef = collection(db, classData.classRefData.classRef.path, "students");
            const studentsSnapshot = await getDocs(studentsCollectionRef);

            const studentPromises = studentsSnapshot.docs.map(async (studentDoc) => {
                const { studentRef } = studentDoc.data();
                const studentDocRef = doc(db, studentRef.path);
                const studentData = await getDoc(studentDocRef);
                return { id: studentData.id, ...studentData.data() };
            });

            const studentList = await Promise.all(studentPromises);
            setStudents(studentList);
        } catch (err) {
            console.error("Error fetching students: ", err);
        } finally {
            setIsLoadingStudents(false);
        }
    };

    const handleReceiveAnswerMapFromStudentList = (newAnswerMap) => {
        setAnswerMap(newAnswerMap);  // Store locally
        handleReceiveAnswerMap(newAnswerMap);  // Pass up to App.js
    };

    const handleBackClick = () => {
        setIsViewingStudents(false);
        setSelectedClass(null);
        setStudents([]);
    };

    return (
        <div style={{ display: 'flex' }}>
        <DrawerLayout>
            {!isViewingStudents ? (
                <ClassList 
                    classes={classes} 
                    teacherName={teacherName} 
                    handleClassClick={handleClassClick} 
                />
            ) : (
                <StudentList 
                    students={students} 
                    selectedClass={selectedClass} 
                    handleBackClick={handleBackClick} 
                    isLoading={isLoadingStudents}
                    handleReceiveAnswerMap={handleReceiveAnswerMapFromStudentList}
                />
            )}
        </DrawerLayout>
        {Object.keys(answerMap).length > 0 && (
                <StudentStats answerMap={answerMap} />
            )}
        </div>
    );
};