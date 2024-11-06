import { useEffect, useState, useCallback } from "react";
import { getDoc, doc, getDocs, collection, updateDoc, query, where } from "firebase/firestore"; // Import query and where
import { db } from "../../config/firebase.js"; // Import Firestore
import DrawerLayout from './boxdrawerLayout.js';
import ClassList from './studentClassList.js';
import StudentList from './StudentList.js';
import SubjectsList from './subjectsList.js'; // Import SubjectsList
import StudentStats from "./studentStats.js";
import { CircularProgress, Box, Select, MenuItem, Checkbox, ListItemText } from '@mui/material'; // Import Checkbox and ListItemText

export const TeacherDashboard = ({ userData, handleReceiveAnswerMap }) => {
    const [classes, setClasses] = useState([]);
    const [selectedClass, setSelectedClass] = useState(null);
    const [students, setStudents] = useState([]);
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
    const [selectedSubject, setSelectedSubject] = useState(null); // Add selectedSubject state
    const [subTopics, setSubTopics] = useState([]); // Add subTopics state
    const [selectedSubTopics, setSelectedSubTopics] = useState([]); // Add selectedSubTopics state

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

    const handleClassClick = useCallback(async (classData) => {
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

            // Fetch subjects
            await fetchSubjects(classData.classRefData.classRef);
        } catch (err) {
            console.error("Error fetching students: ", err);
        } finally {
            setIsLoadingStudents(false);
        }
    }, []);

    const fetchSubjects = useCallback(async (classDocRef) => {
        try {
            const subjectsCollectionRef = collection(db, `${classDocRef.path}/topics`);
            const subjectsSnapshot = await getDocs(subjectsCollectionRef);

            const subjectsData = subjectsSnapshot.docs.map((doc) => ({
                id: doc.id,
                ...doc.data()
            }));

            setSubjects(subjectsData);
        } catch (err) {
            console.error("Error fetching subjects: ", err);
        }
    }, []);

    const handleReceiveAnswerMapFromStudentList = (answers, answerContextType) => {
        setAnswerMap(answers);
        setAnswerContextType(answerContextType);
        handleReceiveAnswerMap(answers, answerContextType); // Pass contextType to the parent handler
    };

    const handleBackClick = () => {
        setIsViewingStudents(false);
        setSelectedClass(null);
        setStudents([]);
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

    const fetchAllowedGames = useCallback(async (classDocRef) => {
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
    }, []);

    const handleSubjectClick = useCallback(async (subject) => {
        setSelectedSubject(subject);
        try {
            const subTopicsCollectionRef = collection(db, `${classDocRef.path}/topics/${subject.id}/subtopics`);
            const subTopicsSnapshot = await getDocs(subTopicsCollectionRef);
            console.log(subTopicsSnapshot)
            const subTopicsData = subTopicsSnapshot.docs.map((doc) => ({
                id: doc.id,
                ...doc.data()
            }));

            setSubTopics(subTopicsData);
            setSelectedSubTopics(subTopicsData.filter(subTopic => subTopic.active).map(subTopic => subTopic.id)); // Set initial selected subtopics
        } catch (err) {
            console.error("Error fetching subtopics: ", err);
        }
    }, [classDocRef]);

    const handleSubTopicChange = async (event) => {
        const value = event.target.value;
        const newSelectedSubTopics = value.filter(subTopicId => !selectedSubTopics.includes(subTopicId));
        const unselectedSubTopics = selectedSubTopics.filter(subTopicId => !value.includes(subTopicId));

        setSelectedSubTopics(value);
        // Update the database
        try {
            for (const subTopicId of newSelectedSubTopics) {
                const subTopicDocRef = doc(db, `${classDocRef.path}/topics/${selectedSubject.id}/subtopics`, subTopicId);
                console.log(`Setting active to true for subtopic: ${subTopicId}`);
                await updateDoc(subTopicDocRef, { active: true });
            }
            for (const subTopicId of unselectedSubTopics) {
                const subTopicDocRef = doc(db, `${classDocRef.path}/topics/${selectedSubject.id}/subtopics`, subTopicId);
                console.log(`Setting active to false for subtopic: ${subTopicId}`);
                await updateDoc(subTopicDocRef, { active: false });
            }
        } 
        catch (err) {
            console.error("Error updating subtopics: ", err);
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
                            handleReceiveAnswerMap={handleReceiveAnswerMapFromStudentList}
                            clearAnswerMap={clearAnswerMap} // Pass the clearAnswerMap function
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
            
            {selectedClass && (
                <div style={{ flexGrow: 1, flexBasis: 0, padding: '20px', overflowY: 'auto', position: 'relative' }}>
                    <Select
                        multiple
                        value={selectedSubTopics}
                        onChange={handleSubTopicChange}
                        displayEmpty
                        renderValue={() => "Choose Sub Topics"}
                        style={{ position: 'absolute', top: '20px', right: '270px' }} // Adjust position to move more to the left
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
                </div>
            )}
        </div>
    );
};
