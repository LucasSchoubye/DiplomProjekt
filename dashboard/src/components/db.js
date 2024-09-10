import { db } from "../config/firebase";
import { useEffect, useState, useMemo, useCallback } from "react";
import {addDoc, getDocs, collection, deleteDoc, doc, onSnapshot } from "firebase/firestore";
import Box from '@mui/material/Box';
import CorrectAnswersList from './answerComponents/CorrectAnswersList';
import IncorrectAnswersList from './answerComponents/IncorrectAnswersList';
import AnswerForm from './answerComponents/AnswerForm';
import AnswerTotals from './answerComponents/AnswerTotals';
import AnswersTable from './answerComponents/answerTable';

export const Database = () => {

    const [answerList, setAnswerList] = useState([]);
    const [correctAnswers, setCorrectAnswers] = useState([]);
    const [incorrectAnswers, setIncorrectAnswers] = useState([]);
    const [newAnswer, setAnswer] = useState("");
    const [isAnswerCorrect, setIsAnswerCorrect] = useState(false);

    const answerCollectionRef = useMemo(() => collection(db,"answers"),[db]);

    // Set up a real-time listener using onSnapshot
    useEffect(() => {
        const unsubscribe = onSnapshot(answerCollectionRef, (snapshot) => {
            const filteredDataAnswers = snapshot.docs.map((doc) => ({
                ...doc.data(), id: doc.id
            }));

            setAnswerList(filteredDataAnswers);

            // Separate answers into correct and incorrect
            const correctAnswer = filteredDataAnswers.filter(answer => answer.correct);
            const incorrectAnswer = filteredDataAnswers.filter(answer => !answer.correct);

            setCorrectAnswers(correctAnswer);
            setIncorrectAnswers(incorrectAnswer);
        }, (error) => {
            console.error("Error fetching answers: ", error);
        });

        // Clean up the listener when the component unmounts
        return () => unsubscribe();
    }, [answerCollectionRef]);

    const onSubmitAnswer = async () => {
        try {
            await addDoc(answerCollectionRef, {
                answerName: newAnswer,
                correct: isAnswerCorrect
            });

            setAnswer(""); // Clear input after submission
            setIsAnswerCorrect(false); // Reset answer correctness

        } catch (err) {
            console.error(err);
        }
    };

    const deleteAnswer = async (id) => {
        try {
            const answerDoc = doc(db, "answers", id);
            await deleteDoc(answerDoc);
        } catch (err) {
            console.error(err);
        }
    };

    return (
        <div>
        <Box display="flex" flexDirection="row" gap={2}>
            <Box flex={2}>
                <AnswersTable
                    correctAnswers={correctAnswers}
                    incorrectAnswers={incorrectAnswers}
                    onDelete={deleteAnswer}
                />
            </Box>
            <Box flex={1} display = "flex" flexDirection="column" gap={2}>
                <Box>
                <AnswerForm 
                    onSubmit={onSubmitAnswer} 
                    newAnswer={newAnswer} 
                    setAnswer={setAnswer} 
                    isAnswerCorrect={isAnswerCorrect} 
                    setIsAnswerCorrect={setIsAnswerCorrect} 
                />
                </Box>
                <Box>
                <AnswerTotals 
                correctAnswers={correctAnswers} 
                incorrectAnswers={incorrectAnswers} />
                </Box>
            </Box>
        </Box>
        
        </div>
    );
};
