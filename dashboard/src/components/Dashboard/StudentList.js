import React, { useState } from 'react';
import { Box, Typography, List, ListItem, ListItemText, Divider, Button, CircularProgress, useTheme, useMediaQuery } from '@mui/material';
import { collection, query, where, getDocs } from 'firebase/firestore';
import { db } from "../../config/firebase"; // Make sure this path is correct

const StudentList = ({ students, selectedClass, handleBackClick, isLoading ,handleReceiveAnswerMap }) => {
    const theme = useTheme();
    const isXsScreen = useMediaQuery(theme.breakpoints.only('xs'));
    const isSmScreen = useMediaQuery(theme.breakpoints.only('sm'));
    const isMdScreen = useMediaQuery(theme.breakpoints.only('md'));

    const [selectedStudent, setSelectedStudent] = useState(null);
    const [sessions, setSessions] = useState([]);
    const [sessionAnswers, setSessionAnswers] = useState({});
    const [isLoadingSessions, setIsLoadingSessions] = useState(false);

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

            handleReceiveAnswerMap(answersMap);
        } catch (error) {
            console.error("Error fetching sessions and answers: ", error);
        } finally {
            setIsLoadingSessions(false);
        }
    };

    return (
        <Box sx={{ width: getWidth(), maxWidth: '100%', padding: 2, margin: 'auto' }}>
            <Button variant="outlined" onClick={handleBackClick} fullWidth sx={{ mb: 2 }}>Back to Classes</Button>
            <Typography variant="h6" mb={2}>
                {selectedStudent ? `${selectedStudent.fullName}` : `Students in ${selectedClass.className}`}
            </Typography>
            <Divider />
            {isLoading || isLoadingSessions ? (
                <Box display="flex" justifyContent="center" alignItems="center" minHeight={100}>
                    <CircularProgress />
                </Box>
            ) : selectedStudent ? (
                <List>
                    {sessions.length > 0 ? (
                        sessions.map((session, index) => (
                            <React.Fragment key={session.id}>
                                <ListItem>
                                    <ListItemText 
                                        primary={`Session ${index + 1}`} 
                                        secondary={
                                            <>
                                                <Typography variant="body2">
                                                    Startime: {session.starttime}
                                                </Typography>
                                                <Typography variant="body2">
                                                    Endtime: {session.endtime}
                                                </Typography>
                                                <Typography variant="body2">
                                                    Answers: {sessionAnswers[session.id] ? sessionAnswers[session.id].length : 0}
                                                </Typography>
                                            </>
                                        }
                                    />
                                </ListItem>
                                {index < sessions.length - 1 && <Divider />}
                            </React.Fragment>
                        ))
                    ) : (
                        <Typography variant="body1" sx={{ mt: 2, textAlign: 'center' }}>No sessions found for this student</Typography>
                    )}
                    <Button variant="outlined" onClick={() => setSelectedStudent(null)} fullWidth sx={{ mt: 2 }}>Back to Student List</Button>
                </List>
            ) : (
                <List>
                    {students.length > 0 ? (
                        students.map((studentData, index) => (
                            <React.Fragment key={studentData.id}>
                                <ListItem button="true" onClick={() => handleStudentClick(studentData)}>
                                    <ListItemText primary={studentData.fullName} />
                                </ListItem>
                                {index < students.length - 1 && <Divider />}
                            </React.Fragment>
                        ))
                    ) : (
                        <Typography variant="body1" sx={{ mt: 2, textAlign: 'center' }}>No students found</Typography>
                    )}
                </List>
            )}
        </Box>
    );
};

export default StudentList;