import React, { useState } from 'react';
import { Box, Typography, List, ListItem, ListItemText, Divider, Button, CircularProgress, useTheme, useMediaQuery } from '@mui/material';
import { collection, query, where, getDocs } from 'firebase/firestore';
import { db } from "../../config/firebase";

const StudentList = ({ students, selectedClass, handleBackClick, isLoading, handleReceiveAnswerMap }) => {
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
        if (isSmScreen) return '450px';
        if (isMdScreen) return '600px';
        return '750px'; // for lg and above
    };

    const handleStudentClick = async (studentData) => {
        setSelectedStudent(studentData);
        setIsLoadingSessions(true);
        try {
            // Fetch sessions
            const sessionsRef = collection(db, 'sessions');
            const q = query(sessionsRef, where('student', '==', "/students/" + studentData.id));
            const querySnapshot = await getDocs(q);
            const sessionsData = querySnapshot.docs.map(doc => ({ id: doc.id, ...doc.data() }));
            setSessions(sessionsData);

            // Fetch answers for each session
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
        const subjectAnswers = Object.values(sessionAnswers).flat().filter(answer => answer.subject === subject);
        handleReceiveAnswerMap(subjectAnswers, 'subject');
    };

    const handleBackToSubjects = () => {
        setSelectedSubject(null);
        if (selectedStudent) {
            const subjectAnswers = getSubjectAnswers(selectedStudent);
            handleReceiveAnswerMap(subjectAnswers, 'subject');
        }
    };
    
    const handleSubtopicClick = (subtopic) => {
        setSelectedSubtopic(subtopic);
        setSelectedSession(null);
        const subtopicAnswers = Object.values(sessionAnswers).flat().filter(answer => answer.subtopic === subtopic);
        handleReceiveAnswerMap(subtopicAnswers, 'subtopic');
    };

    const handleBackToSubtopics = () => {
        setSelectedSubtopic(null);
        if (selectedSubject) {
            const subjectAnswers = getSubjectAnswers(selectedSubject);
            handleReceiveAnswerMap(subjectAnswers, 'subject');
        }
    };
    
    const handleSessionClick = (sessionId) => {
        setSelectedSession(sessionId);
    
        if (sessionAnswers && sessionAnswers[sessionId]) {
            const sessionAnswersData = sessionAnswers[sessionId];
            handleReceiveAnswerMap(sessionAnswersData, 'session');
        } else {
            console.error(`No answers found for session ID: ${sessionId}`);
        }
    };

    const handleBackToSessions = () => {
        setSelectedSession(null);
        if (selectedSubtopic) {
            const subtopicAnswers = getSubtopicAnswers(selectedSubtopic);
            handleReceiveAnswerMap(subtopicAnswers, 'subtopic');
        }
    };

    // const handleBackToStudents = () => {
    //     setSelectedSubject(null);
    //     setSelectedStudent(null);
    //     clearAnswerMap(); // Call this function to hide the answers in StudentStats
    // };

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
                <Button variant="outlined" onClick={() => setSelectedStudent(null)} fullWidth sx={{ mb: 2 }}>
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

    const renderContent = () => {
    if (isLoading || isLoadingSessions) {
        return (
            <Box display="flex" justifyContent="center" alignItems="center" minHeight={100}>
                <CircularProgress />
            </Box>
        );
    }

    if (selectedSession) {
        const sessionAnswersData = sessionAnswers[selectedSession];
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
    }

    if (selectedSubtopic) {
        const sessionsForSubtopic = getSessionsForSubtopic(selectedSubtopic);
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
    }

    if (selectedSubject) {
        const subtopicsForSubject = getSubtopicsForSubject(selectedSubject);
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
    }

    if (selectedStudent) {
        const subjects = getSubjects();
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
    }

    return (
        <List>
            {students.length > 0 ? (
                students.map((studentData, index) => (
                    <React.Fragment key={studentData.id}>
                        <ListItem button onClick={() => handleStudentClick(studentData)}>
                            <ListItemText primary={studentData.fullName} />
                        </ListItem>
                        {index < students.length - 1 && <Divider />}
                    </React.Fragment>
                ))
            ) : (
                <Typography variant="body1" sx={{ mt: 2, textAlign: 'center' }}>No students found</Typography>
            )}
        </List>
    );
};


return (
    <Box sx={{ width: getWidth(), maxWidth: '100%', padding: 2, margin: 'auto' }}>
        {renderBackButton()}
        <Typography variant="h6" mb={2}>
            {selectedSession ? `Session Details` :
             selectedSubtopic ? `Sessions for ${selectedSubtopic}` :
             selectedSubject ? `Subtopics for ${selectedSubject}` :
             selectedStudent ? `${selectedStudent.fullName}` :
             `Students in ${selectedClass.className}`}
        </Typography>
        <Divider />
        {renderContent()}
    </Box>
);
};

export default StudentList;