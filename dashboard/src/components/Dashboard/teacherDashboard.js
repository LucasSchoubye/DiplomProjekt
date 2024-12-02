import { useEffect, useState, useCallback } from "react";
import { getDoc, doc, getDocs, collection, updateDoc, query, where } from "firebase/firestore"; // Import query and where
import { db } from "../../config/firebase.js"; // Import Firestore
import DrawerLayout from './boxdrawerLayout.js';
import ClassList from './studentClassList.js';
import StudentList from './StudentList.js';
import SubjectsList from './subjectsList.js'; // Import SubjectsList
import StudentStats from "./studentStats.js";
import ClassStats from "./classStats.js";
import { CircularProgress, Box, Select, MenuItem, Checkbox, ListItemText } from '@mui/material'; // Import Checkbox and ListItemText

export const TeacherDashboard = ({ userData, handleReceiveAnswerMap }) => {
    const [classes, setClasses] = useState([]);
    const [selectedClass, setSelectedClass] = useState(null);
    const [students, setStudents] = useState([]);
    const [selectedStudent, setSelectedStudent] = useState(null);
    const [subjects, setSubjects] = useState([]); // Add subjects state
    const [teacherName, setTeacherName] = useState('');
    const [isViewingStudents, setIsViewingStudents] = useState(false);
    const [isLoadingStudents, setIsLoadingStudents] = useState(false);
    const [answerMap, setAnswerMap] = useState({});
    const [answerContextType, setAnswerContextType] = useState('');
    const [isLoadingClasses, setIsLoadingClasses] = useState(true);
    const [selectedGames, setSelectedGames] = useState([]);
    const [availableGames, setAvailableGames] = useState([]);
    const [classDocRef, setClassDocRef] = useState(null);
    const [classAnswersMap, setClassAnswersMap] = useState({});
    const [isViewingStudent, setIsViewingStudent] = useState(false);
    const [selectedSubject, setSelectedSubject] = useState(null); // Add selectedSubject state
    const [subTopics, setSubTopics] = useState([]); // Add subTopics state
    const [selectedSubTopics, setSelectedSubTopics] = useState([]); // Add selectedSubTopics state
    const [selectedTimespan, setSelectedTimespan] = useState('today'); // Set default value to twoWeeks

    const timespanOptions = {
        today: "Today",
        twoWeeks: "Last Two Weeks",
        twoMonths: "Last Two Months",
        schoolYear: "This School Year"
    };

    useEffect(() => {
    }, [selectedClass, selectedStudent]);
  
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

    const handleSubjectClick = useCallback(async (subject) => {
        if (!classDocRef) return; // Add guard clause
        setSelectedSubject(subject);
        try {
            const subTopicsCollectionRef = collection(db, `${classDocRef.path}/topics/${subject.id}/subtopics`);
            const subTopicsSnapshot = await getDocs(subTopicsCollectionRef);
            const subTopicsData = subTopicsSnapshot.docs.map((doc) => ({
                id: doc.id,
                ...doc.data()
            }));

            setSubTopics(subTopicsData);
            setSelectedSubTopics(subTopicsData.filter(subTopic => subTopic.active).map(subTopic => subTopic.id)); // Set initial selected subtopics
        } catch (err) {
            console.error("Error fetching subtopics: ", err);
        }
    }, [classDocRef]); // Only depend on classDocRef

    const handleClassClick = useCallback(async (classData) => {
        setSelectedClass(classData);
        setClassDocRef(classData.classRefData.classRef); // Set classDocRef state
        setSelectedStudent(null)
        setIsViewingStudents(true);
        setIsLoadingStudents(true);
        try {
            const studentsCollectionRef = collection(db, classData.classRefData.classRef.path, "students");
            const subjectsCollectionRef = collection(db, `${classData.classRefData.classRef.path}/topics`);
            const allowedGamesCollectionRef = collection(db, `${classData.classRefData.classRef.path}/allowedGames`);

            const [studentsSnapshot, subjectsSnapshot, allowedGamesSnapshot] = await Promise.all([
                getDocs(studentsCollectionRef),
                getDocs(subjectsCollectionRef),
                getDocs(allowedGamesCollectionRef)
            ]);

            const studentPromises = studentsSnapshot.docs.map(async (studentDoc) => {
                const { studentRef } = studentDoc.data();
                const studentDocRef = doc(db, studentRef.path);
                const studentData = await getDoc(studentDocRef);
                return { id: studentData.id, ...studentData.data() };
            });

            const studentList = await Promise.all(studentPromises);
            setStudents(studentList);

            const subjectsData = subjectsSnapshot.docs.map((doc) => ({
                id: doc.id,
                ...doc.data()
            }));
            setSubjects(subjectsData);

            const games = allowedGamesSnapshot.docs.map((doc) => ({
                id: doc.id,
                ...doc.data()
            }));
            setAvailableGames(games);
            setSelectedGames(games.filter(game => game.allowed).map(game => game.id));
            // Aggregate answers across all students in the class
            await fetchClassSessionsAndAnswers(studentList);
            if (subjectsData.length > 0) {
                setSelectedSubject(subjectsData[0]);
                // Remove the immediate handleSubjectClick call
                // It will be triggered by the useEffect below
            }
        } catch (err) {
            console.error("Error fetching data: ", err);
        } finally {
            setIsLoadingStudents(false);
        }
    }, []);

    // Add new useEffect to handle subject selection
    useEffect(() => {
        if (selectedSubject && classDocRef) {
            handleSubjectClick(selectedSubject);
        }
    }, [selectedSubject, classDocRef, handleSubjectClick]);

    const fetchClassSessionsAndAnswers = async (studentList, timespan = selectedTimespan) => {
        try {
            const classAnswersMap = {};
            const now = new Date();
            let startDate;

            switch (timespan) {
                case 'today':
                    startDate = new Date(now.getFullYear(), now.getMonth(), now.getDate());
                    break;
                case 'twoWeeks':
                    startDate = new Date(now.getFullYear(), now.getMonth(), now.getDate() - 14);
                    break;
                case 'twoMonths':
                    startDate = new Date(now.getFullYear(), now.getMonth() - 2, now.getDate());
                    break;
                case 'schoolYear':
                    startDate = new Date(now.getFullYear(), 0, 1);
                    break;
                default:
                    startDate = new Date(now.getFullYear(), now.getMonth(), now.getDate() - 14);
            }
            const startDateString = `${startDate.getFullYear()}-${String(startDate.getMonth() + 1).padStart(2, '0')}-${String(startDate.getDate()).padStart(2, '0')}-${String(startDate.getHours()).padStart(2, '0')}/${String(startDate.getMinutes()).padStart(2, '0')}/${String(startDate.getSeconds()).padStart(2, '0')}`;

            const studentPromises = studentList.map(async (student) => {
                const sessionsRef = collection(db, 'sessions');
                const q = query(sessionsRef, where('student', '==', `/students/${student.id}`), where('starttime', '>=', startDateString));
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

    const handleReceiveAnswerMapFromStudentList = (answers, answerContextType, isViewingStudent) => {
        setAnswerMap(answers);
        setAnswerContextType(answerContextType);
        setIsViewingStudent(isViewingStudent);
        handleReceiveAnswerMap(answers, answerContextType, isViewingStudent); // Pass contextType to the parent handler
    };

    const handleBackClick = () => {
        setIsViewingStudents(false);
        setSelectedClass(null);
        setStudents([]);
        setIsViewingStudent(false);
        setSubjects([]); // Clear subjects when going back
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
                await updateDoc(gameDocRef, { allowed: true });
            }
            for (const gameId of unselectedGames) {
                const gameDocRef = doc(db, `${classDocRef.path}/allowedGames`, gameId);
                await updateDoc(gameDocRef, { allowed: false });
            }
        } 
        catch (err) {
            console.error("Error updating allowed games: ", err);
        }
    };

    const handleSubTopicChange = async (event) => {
        const value = event.target.value;
        const newSelectedSubTopics = value.filter(subTopicId => !selectedSubTopics.includes(subTopicId));
        const unselectedSubTopics = selectedSubTopics.filter(subTopicId => !value.includes(subTopicId));

        setSelectedSubTopics(value);
        // Update the database
        try {
            for (const subTopicId of newSelectedSubTopics) {
                const subTopicDocRef = doc(db, `${classDocRef.path}/topics/${selectedSubject.id}/subtopics`, subTopicId);
                await updateDoc(subTopicDocRef, { active: true });
            }
            for (const subTopicId of unselectedSubTopics) {
                const subTopicDocRef = doc(db, `${classDocRef.path}/topics/${selectedSubject.id}/subtopics`, subTopicId);
                await updateDoc(subTopicDocRef, { active: false });
            }
        } 
        catch (err) {
            console.error("Error updating subtopics: ", err);
        }
    };

    const handleTimespanChange = async (event) => {
        const newTimespan = event.target.value;
        setSelectedTimespan(newTimespan);
        if (selectedClass) {
            setIsLoadingStudents(true);
            await fetchClassSessionsAndAnswers(students, newTimespan);
            setIsLoadingStudents(false);
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
                    <Box sx={{ display: 'flex', flexDirection: 'column', width: '90%', paddingTop: "20px", gap: '10px' }}>
                        <StudentList 
                            students={students} 
                            selectedClass={selectedClass} 
                            handleBackClick={handleBackClick} 
                            isLoading={isLoadingStudents}
                            handleReceiveAnswerMap={(answers, answerContextType, isViewingStudent) => handleReceiveAnswerMapFromStudentList(answers, answerContextType, isViewingStudent)}
                            clearAnswerMap={clearAnswerMap} // Pass the clearAnswerMap function
                            setSelectedStudent={setSelectedStudent}
                            classAnswersMap={classAnswersMap} // Pass classAnswersMap to StudentList
                        />
                        <SubjectsList 
                            subjects={subjects} 
                            selectedClass={selectedClass} 
                            handleSubjectClick={handleSubjectClick} // Pass the handleSubjectClick function
                            selectedSubject={selectedSubject} // Pass the selectedSubject state
                        />
                    </Box>
                )}
            </DrawerLayout>
            
            {selectedClass && selectedStudent === null && (
                <div style={{ flexGrow: 1, flexBasis: 0, padding: '20px', overflowY: 'auto', position: 'relative' }}>
                    <Box sx={{ display: 'flex', justifyContent: 'flex-end', gap: '20px', paddingBottom: '20px' }}>
                        <Select
                            value={selectedTimespan}
                            onChange={handleTimespanChange}
                            displayEmpty
                            renderValue={() => timespanOptions[selectedTimespan] || "Choose Timespan"}
                        >
                            <MenuItem value="" disabled>
                                Choose Timespan
                            </MenuItem>
                            {Object.entries(timespanOptions).map(([value, label]) => (
                                <MenuItem key={value} value={value}>
                                    {label}
                                </MenuItem>
                            ))}
                        </Select>
                        <Select
                            multiple
                            value={selectedSubTopics}
                            onChange={handleSubTopicChange}
                            displayEmpty
                            renderValue={() => "Choose Sub Topics"}
                        >
                            <MenuItem value="" disabled>
                                Choose Sub Topics
                            </MenuItem>
                            {subTopics
                                // .sort((a, b) => a.name.localeCompare(b.name)) // Sort subtopics alphabetically
                                .map((subTopic) => (
                                    <MenuItem key={subTopic.id} value={subTopic.id}>
                                        <Checkbox checked={selectedSubTopics.indexOf(subTopic.id) > -1} />
                                        <ListItemText primary={subTopic.name} /> {/* Show active status */}
                                    </MenuItem>
                                ))}
                        </Select>
                        <Select
                            multiple
                            value={selectedGames}
                            onChange={handleGameChange}
                            displayEmpty
                            renderValue={() => "Choose Available Games"}
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
                    </Box>
                    {Object.keys(answerMap).length > 0 && (
                        <StudentStats 
                            answerMap={answerMap} 
                            answerContextType={answerContextType} 
                        />
                    )}
                    {!isViewingStudent && (
                    <ClassStats classAnswersMap={classAnswersMap} />
                    )}
                </div>
            )}
        </div>
    );
};
