import { db } from "../config/firebase";
import { useEffect, useState, useMemo, useCallback } from "react";
import {addDoc, getDocs, collection, deleteDoc, doc } from "firebase/firestore";
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

    const getAnswerList = useCallback(async () => {
        try {
            const dataAnswers = await getDocs(answerCollectionRef);
            const filteredDataAnswers = dataAnswers.docs.map((doc) => ({
                ...doc.data(), id: doc.id
            }));

            setAnswerList(filteredDataAnswers);

            // Separate answers into correct and incorrect
            const correctAnswer = filteredDataAnswers.filter(answer => answer.correct);
            const incorrectAnswer = filteredDataAnswers.filter(answer => !answer.correct);

            setCorrectAnswers(correctAnswer);
            setIncorrectAnswers(incorrectAnswer);

        } catch (err) {
            console.error(err);
        }
    }, [answerCollectionRef]);

    const onSubmitAnswer = async () => {
        try {
            await addDoc(answerCollectionRef, {
                answerName: newAnswer,
                correct: isAnswerCorrect
            });

            getAnswerList();
        } catch (err) {
            console.error(err);
        }
    };

    const deleteAnswer = async (id) => {
        try {
            const answerDoc = doc(db, "answers", id);
            await deleteDoc(answerDoc);
            getAnswerList(); // Refresh the list after deletion
        } catch (err) {
            console.error(err);
        }
    };

    useEffect(() => {
        getAnswerList();
    }, [getAnswerList]);

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
    // return (
    //     <div>
    //         <div>
    //         <AnswersTable
    //             correctAnswers={correctAnswers}
    //             incorrectAnswers={incorrectAnswers}
    //             onDelete={deleteAnswer}
    //         />
    //         </div>
            
    //         {/* <CorrectAnswersList correctAnswers={correctAnswers} onDelete={deleteAnswer} /> */}
    //         {/* <IncorrectAnswersList incorrectAnswers={incorrectAnswers} onDelete={deleteAnswer} /> */}
    //         <AnswerTotals correctAnswers={correctAnswers} incorrectAnswers={incorrectAnswers} />
    //         <div>
    //             <AnswerForm 
    //             onSubmit={onSubmitAnswer} 
    //             newAnswer={newAnswer} 
    //             setAnswer={setAnswer} 
    //             isAnswerCorrect={isAnswerCorrect} 
    //             setIsAnswerCorrect={setIsAnswerCorrect} 
    //         /></div>
            
    //     </div>
    // );
};
