import { useEffect, useState } from "react";
import { getDoc, doc, getDocs, collection, updateDoc, query, where } from "firebase/firestore"; // Import updateDoc
import { db } from "../../config/firebase.js"; // Import Firestore
import DrawerLayout from './boxdrawerLayout.js';
import ClassList from './studentClassList.js';
import StudentList from './StudentList.js';
import StudentStats from "./studentStats.js";
import ClassStats from "./classStats.js";
import { CircularProgress, Box, Select, MenuItem, Checkbox, ListItemText } from '@mui/material'; // Import Checkbox and ListItemText

export const TeacherDashboard = ({ userData, handleReceiveAnswerMap }) => {
    const [classes, setClasses] = useState([]);
    const [selectedClass, setSelectedClass] = useState(null);
    const [students, setStudents] = useState([]);
    const [teacherName, setTeacherName] = useState('');
    const [isViewingStudents, setIsViewingStudents] = useState(false);
    const [isLoadingStudents, setIsLoadingStudents] = useState(false);
    const [answerMap, setAnswerMap] = useState({});
    const [answerContextType, setAnswerContextType] = useState('');
    const [isLoadingClasses, setIsLoadingClasses] = useState(true);
    const [selectedGames, setSelectedGames] = useState([]);
    const [availableGames, setAvailableGames] = useState([]);
    const [classDocRef, setClassDocRef] = useState(null);
    const [classAnswersMap, setClassAnswersMap] = useState([]);

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
            } finally {
                setIsLoadingClasses(false);
            }
        };

        fetchClasses();
    }, [userData]);

    const handleClassClick = async (classData) => {
        setSelectedClass(classData);
        setClassDocRef(classData.classRefData.classRef); // Set classDocRef state
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

            // Fetch allowed games
            await fetchAllowedGames(classData.classRefData.classRef);

            // Aggregate answers across all students in the class
            await fetchClassSessionsAndAnswers(studentList);
        } catch (err) {
            console.error("Error fetching students: ", err);
        } finally {
            setIsLoadingStudents(false);
        }
    };

    const fetchClassSessionsAndAnswers = async (studentList) => {
        try {
            const classAnswersMap = {};
            const studentPromises = studentList.map(async (student) => {
                const sessionsRef = collection(db, 'sessions');
                const q = query(sessionsRef, where('student', '==', `/students/${student.id}`));
                const querySnapshot = await getDocs(q);
                const sessionsData = querySnapshot.docs.map(doc => ({ id: doc.id, ...doc.data() }));

                const answersPromises = sessionsData.map(async (session) => {
                    const answersRef = collection(db, 'answers');
                    const answersQuery = query(answersRef, where('sessionRef', '==', session.id));
                    const answersSnapshot = await getDocs(answersQuery);
                    return answersSnapshot.docs.map(doc => ({ id: doc.id, ...doc.data() }));
                });

                const allAnswers = await Promise.all(answersPromises);
                const studentAnswersMap = {};
                sessionsData.forEach((session, index) => {
                    studentAnswersMap[session.id] = allAnswers[index];
                });
                classAnswersMap[student.id] = studentAnswersMap; // Add each student's answers to the class map
            });

            await Promise.all(studentPromises);
            setClassAnswersMap(classAnswersMap); // Set aggregated answers for the entire class
        } catch (error) {
            console.error("Error fetching class sessions and answers: ", error);
        }
    };

    const handleReceiveAnswerMapFromStudentList = (answers, answerContextType) => {
        setAnswerMap(answers);
        setAnswerContextType(answerContextType);
        handleReceiveAnswerMap(answers, answerContextType); // Pass contextType to the parent handler
    };

    const handleBackClick = () => {
        setIsViewingStudents(false);
        setSelectedClass(null);
        setStudents([]);
    };

    const clearAnswerMap = () => {
        setAnswerMap({});
        setAnswerContextType('');
    };

    const handleGameChange = async (event) => {
        const value = event.target.value;
        const newSelectedGames = value.filter(gameId => !selectedGames.includes(gameId));
        const unselectedGames = selectedGames.filter(gameId => !value.includes(gameId));

        setSelectedGames(value);
        // Update the database
        try {
            for (const gameId of newSelectedGames) {
                const gameDocRef = doc(db, `${classDocRef.path}/allowedGames`, gameId);
                console.log(`Setting allowed to true for game: ${gameId}`);
                await updateDoc(gameDocRef, { allowed: true });
            }
            for (const gameId of unselectedGames) {
                const gameDocRef = doc(db, `${classDocRef.path}/allowedGames`, gameId);
                console.log(`Setting allowed to false for game: ${gameId}`);
                await updateDoc(gameDocRef, { allowed: false });
            }
        } 
        catch (err) {
            console.error("Error updating allowed games: ", err);
        }
    };

    const fetchAllowedGames = async (classDocRef) => {
        try {
            const allowedGamesCollectionRef = collection(db, `${classDocRef.path}/allowedGames`);
            const allowedGamesSnapshot = await getDocs(allowedGamesCollectionRef);

            const games = allowedGamesSnapshot.docs.map((doc) => ({
                id: doc.id,
                ...doc.data()
            }));

            setAvailableGames(games);
            setSelectedGames(games.filter(game => game.allowed).map(game => game.id));
        } catch (err) {
            console.error("Error fetching allowed games: ", err);
        }
    };

    return (
        <div style={{ display: 'flex', flexDirection: 'row', height: '100vh' }}>
            <DrawerLayout>
                {isLoadingClasses ? (
                    <Box display="flex" justifyContent="center" alignItems="center" minHeight={100}>
                        <CircularProgress />
                    </Box>
                ) : !isViewingStudents ? (
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
                    clearAnswerMap={clearAnswerMap} // Pass the clearAnswerMap function
                    />
                )}
            </DrawerLayout>
            
            {selectedClass && (
                <div style={{ flexGrow: 1, flexBasis: 0, padding: '20px', overflowY: 'auto', position: 'relative' }}>
                    <Select
                        multiple
                        value={selectedGames}
                        onChange={handleGameChange}
                        displayEmpty
                        renderValue={() => "Choose Available Games"}
                        style={{ position: 'absolute', top: '20px', right: '20px' }}
                    >
                        <MenuItem value="" disabled>
                            Choose Available Games
                        </MenuItem>
                        {availableGames
                            .sort((a, b) => a.name.localeCompare(b.name)) // Sort games alphabetically
                            .map((game) => (
                                <MenuItem key={game.id} value={game.id}>
                                    <Checkbox checked={selectedGames.indexOf(game.id) > -1} />
                                    <ListItemText primary={game.name} />
                                </MenuItem>
                            ))}
                    </Select>
                    {Object.keys(answerMap).length > 0 && (
                        <StudentStats answerMap={answerMap} answerContextType={answerContextType} />
                    )}
                    <ClassStats classAnswersMap={classAnswersMap} /> {/* Render ClassStats with classAnswersMap */}
                </div>
            )}
        </div>
    );
};
