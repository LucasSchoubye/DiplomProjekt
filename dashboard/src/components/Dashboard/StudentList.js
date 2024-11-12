import React, { useState } from 'react';
import { Box, Typography, List, ListItem, ListItemText, Divider, Button, CircularProgress, useTheme, useMediaQuery } from '@mui/material';
import { collection, query, where, getDocs } from 'firebase/firestore';
import { db } from "../../config/firebase";

const StudentList = ({ students, selectedClass, handleBackClick, isLoading, handleReceiveAnswerMap, clearAnswerMap }) => {
    const theme = useTheme();
    const isXsScreen = useMediaQuery(theme.breakpoints.only('xs'));
    const isSmScreen = useMediaQuery(theme.breakpoints.only('sm'));
    const isMdScreen = useMediaQuery(theme.breakpoints.only('md'));

    const [selectedStudent, setSelectedStudent] = useState(null);
    const [sessions, setSessions] = useState([]);
    const [sessionAnswers, setSessionAnswers] = useState({});
    const [isLoadingSessions, setIsLoadingSessions] = useState(false);

    const [selectedSubject, setSelectedSubject] = useState(null);
    const [selectedSubtopic, setSelectedSubtopic] = useState(null);
    const [selectedSession, setSelectedSession] = useState(null);

    const getWidth = () => {
        if (isXsScreen) return '100%';
        if (isSmScreen) return '200px';
        if (isMdScreen) return '300px';
        return '400px'; // for lg and above
    };

    const fetchSessionsAndAnswers = async (studentId) => {
        setIsLoadingSessions(true);
        try {
            const sessionsRef = collection(db, 'sessions');
            const q = query(sessionsRef, where('student', '==', `/students/${studentId}`));
            const querySnapshot = await getDocs(q);
            const sessionsData = querySnapshot.docs.map(doc => ({ id: doc.id, ...doc.data() }));
            setSessions(sessionsData);

            const answersPromises = sessionsData.map(async (session) => {
                const answersRef = collection(db, 'answers');
                const answersQuery = query(answersRef, where('sessionRef', '==', session.id));
                const answersSnapshot = await getDocs(answersQuery);
                return answersSnapshot.docs.map(doc => ({ id: doc.id, ...doc.data() }));
            });

            const allAnswers = await Promise.all(answersPromises);
            const answersMap = {};
            sessionsData.forEach((session, index) => {
                answersMap[session.id] = allAnswers[index];
            });
            setSessionAnswers(answersMap);
        } catch (error) {
            console.error("Error fetching sessions and answers: ", error);
        } finally {
            setIsLoadingSessions(false);
        }
    };

    const handleStudentClick = (studentData) => {
        setSelectedStudent(studentData);
        fetchSessionsAndAnswers(studentData.id);
        handleReceiveAnswerMap([], 'student', true);
        console.log("Student clicked:", studentData);
    };

    const getSubjects = () => {
        const subjectsSet = new Set();
        Object.values(sessionAnswers).forEach((answers) => {
            answers.forEach((answer) => {
                subjectsSet.add(answer.subject);
            });
        });
        return Array.from(subjectsSet);
    };

    const getSubjectAnswers = (subject) => {
        return Object.values(sessionAnswers).flat().filter(answer => answer.subject === subject);
    };

    const getSubtopicsForSubject = (subject) => {
        const subtopicsSet = new Set();
        Object.values(sessionAnswers).forEach((answers) => {
            answers.forEach((answer) => {
                if (answer.subject === subject) {
                    subtopicsSet.add(answer.subtopic);
                }
            });
        });
        return Array.from(subtopicsSet);
    };

    const getSubtopicAnswers = (subtopic) => {
        return Object.values(sessionAnswers).flat().filter(answer => answer.subtopic === subtopic);
    };

    const getSessionsForSubtopic = (subtopic) => {
        return sessions.filter(session => 
            sessionAnswers[session.id].some(answer => answer.subtopic === subtopic)
        );
    };

    const handleSubjectClick = (subject) => {
        setSelectedSubject(subject);
        const subjectAnswers = getSubjectAnswers(subject);
        handleReceiveAnswerMap(subjectAnswers, 'subject', true);
    };

    const handleBackToSubjects = () => {
        setSelectedSubject(null);
        if (selectedStudent) {
            const subjectAnswers = getSubjectAnswers(selectedStudent);
            handleReceiveAnswerMap(subjectAnswers, 'subject', true);
        }
    };
    
    const handleSubtopicClick = (subtopic) => {
        setSelectedSubtopic(subtopic);
        setSelectedSession(null);
        const subtopicAnswers = getSubtopicAnswers(subtopic);
        handleReceiveAnswerMap(subtopicAnswers, 'subtopic', true);
    };

    const handleBackToSubtopics = () => {
        setSelectedSubtopic(null);
        if (selectedSubject) {
            const subjectAnswers = getSubjectAnswers(selectedSubject);
            handleReceiveAnswerMap(subjectAnswers, 'subject', true);
        }
    };
    
    const handleSessionClick = (sessionId) => {
        setSelectedSession(sessionId);
    
        if (sessionAnswers && sessionAnswers[sessionId]) {
            const sessionAnswersData = sessionAnswers[sessionId];
            handleReceiveAnswerMap(sessionAnswersData, 'session', true);
        } else {
            console.error(`No answers found for session ID: ${sessionId}`);
        }
    };

    const handleBackToSessions = () => {
        setSelectedSession(null);
        if (selectedSubtopic) {
            const subtopicAnswers = getSubtopicAnswers(selectedSubtopic);
            handleReceiveAnswerMap(subtopicAnswers, 'subtopic', true);
        }
    };

    const handleBackToStudents = () => {
        setSelectedStudent(null);
        clearAnswerMap();
        handleReceiveAnswerMap([], 'student', false);
        console.log(handleReceiveAnswerMap);
    };

    const renderBackButton = () => {
        if (selectedSession) {
            return (
                <Button variant="outlined" onClick={handleBackToSessions} fullWidth sx={{ mb: 2 }}>
                    Back to Sessions
                </Button>
            );
        } else if (selectedSubtopic) {
            return (
                <Button variant="outlined" onClick={handleBackToSubtopics} fullWidth sx={{ mb: 2 }}>
                    Back to Subtopics
                </Button>
            );
        } else if (selectedSubject) {
            return (
                <Button variant="outlined" onClick={handleBackToSubjects} fullWidth sx={{ mb: 2 }}>
                    Back to Subjects
                </Button>
            );
        } else if (selectedStudent) {
            return (
                <Button variant="outlined" onClick={handleBackToStudents} fullWidth sx={{ mb: 2 }}>
                    Back to Student List
                </Button>
            );
        } else {
            return (
                <Button variant="outlined" onClick={handleBackClick} fullWidth sx={{ mb: 2 }}>
                    Back to Classes
                </Button>
            );
        }
    };

    const renderSessionAnswers = (sessionAnswersData) => {
        if (!sessionAnswersData || sessionAnswersData.length === 0) {
            return (
                <Typography variant="body1" sx={{ mt: 2, textAlign: 'center' }}>
                    No answers found for this session.
                </Typography>
            );
        }

        return (
            <List>
                {sessionAnswersData.map((answer, index) => (
                    <ListItem key={index}>
                        <ListItemText
                            primary={answer.prompt}
                            secondary={`Answer: ${answer.answer} | Correct: ${answer.correct ? 1 : 0}`}
                        />
                    </ListItem>
                ))}
            </List>
        );
    };

    const renderSessionsForSubtopic = (sessionsForSubtopic) => {
        if (sessionsForSubtopic.length === 0) {
            return (
                <Typography variant="body1" sx={{ mt: 2, textAlign: 'center' }}>
                    No sessions found for this subtopic.
                </Typography>
            );
        }

        return (
            <List>
                {sessionsForSubtopic.map((session, index) => (
                    <React.Fragment key={session.id}>
                        <ListItem button onClick={() => handleSessionClick(session.id)}>
                            <ListItemText primary={`Session ${index + 1}`} secondary={session.student} />
                        </ListItem>
                        {index < sessionsForSubtopic.length - 1 && <Divider />}
                    </React.Fragment>
                ))}
            </List>
        );
    };

    const renderSubtopicsForSubject = (subtopicsForSubject) => {
        if (subtopicsForSubject.length === 0) {
            return (
                <Typography variant="body1" sx={{ mt: 2, textAlign: 'center' }}>
                    No subtopics found for this subject.
                </Typography>
            );
        }

        return (
            <List>
                {subtopicsForSubject.map((subtopic, index) => (
                    <React.Fragment key={index}>
                        <ListItem button onClick={() => handleSubtopicClick(subtopic)}>
                            <ListItemText primary={subtopic} />
                        </ListItem>
                        {index < subtopicsForSubject.length - 1 && <Divider />}
                    </React.Fragment>
                ))}
            </List>
        );
    };

    const renderSubjectsForStudent = (subjects) => {
        if (subjects.length === 0) {
            return (
                <Typography variant="body1" sx={{ mt: 2, textAlign: 'center' }}>
                    No subjects found for this student.
                </Typography>
            );
        }

        return (
            <List>
                {subjects.map((subject, index) => (
                    <React.Fragment key={index}>
                        <ListItem button onClick={() => handleSubjectClick(subject)}>
                            <ListItemText primary={subject} />
                        </ListItem>
                        {index < subjects.length - 1 && <Divider />}
                    </React.Fragment>
                ))}
            </List>
        );
    };

    const renderStudentList = () => {
        const filledStudents = [...students].sort((a, b) => a.fullName.localeCompare(b.fullName));
        while (filledStudents.length < 10) {
            filledStudents.push({ id: `empty-${filledStudents.length}`, fullName: '' });
        }

        return (
            <Box sx={{ maxHeight: '450px', overflowY: 'auto' }}>
                <List sx={{ paddingTop: 0, paddingBot: 0 }}>
                    {filledStudents.map((studentData, index) => (
                        <React.Fragment key={studentData.id}>
                            <ListItem button={!!studentData.fullName} onClick={() => studentData.fullName && handleStudentClick(studentData)}>
                                <ListItemText primary={studentData.fullName || ' '} />
                            </ListItem>
                            {studentData.fullName && index < filledStudents.length - 1 && <Divider />}
                        </React.Fragment>
                    ))}
                </List>
            </Box>
        );
    };

    const renderContent = () => {
        if (isLoading || isLoadingSessions) {
            return (
                <Box display="flex" justifyContent="center" alignItems="center" minHeight={100}>
                    <CircularProgress />
                </Box>
            );
        }

        if (selectedSession) {
            return renderSessionAnswers(sessionAnswers[selectedSession]);
        }

        if (selectedSubtopic) {
            return renderSessionsForSubtopic(getSessionsForSubtopic(selectedSubtopic));
        }

        if (selectedSubject) {
            return renderSubtopicsForSubject(getSubtopicsForSubject(selectedSubject));
        }

        if (selectedStudent) {
            return renderSubjectsForStudent(getSubjects());
        }

        return renderStudentList();
    };

    return (
        <Box sx={{ width: getWidth(), maxWidth: '100%' }}>
            {renderBackButton()}
            <Typography variant="h6" mb={2}>
                {selectedSession ? `Session Details` :
                selectedSubtopic ? `Sessions for ${selectedSubtopic}` :
                selectedSubject ? `Subtopics for ${selectedSubject}` :
                selectedStudent ? `${selectedStudent.fullName}` :
                `Students in ${selectedClass.className}`}
            </Typography>
            <Divider sx={{ my: 0 }} />
            {renderContent()}
        </Box>
    );
};

export default StudentList;