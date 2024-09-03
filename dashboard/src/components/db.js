import { db } from "../config/firebase";
import { useEffect, useState} from "react";
import {addDoc, getDocs, collection, deleteDoc, doc } from "firebase/firestore";

export const Database = () => {

    const [studentList, setStudentList] = useState([]);

    const studentCollectionRef = collection(db,"students");

    const [answerList, setAnswerList] = useState([]);
    const [correctAnswers, setCorrectAnswers] = useState([]);
    const [incorrectAnswers, setIncorrectAnswers] = useState([]);

    const answerCollectionRef = collection(db,"answers");

    // useEffect(() => {
    //     const getStudentList = async () => {
    //         // READ DATA FROM DATABASE
    //         // SET THE STUDENT LIST
    //         try {
    //             const data = await getDocs(studentCollectionRef);
    //             const filteredData = data.docs.map((doc) =>({
    //                 ...doc.data(),id:doc.id}))
    //             console.log(filteredData);
    //             setStudentList(filteredData);
                
    //         } catch (err) {
    //             console.error(err);
    //         }
            
    //     }
    //     getStudentList();
    // },[])
    const getAnswerList = async () => {
        // READ DATA FROM DATABASE
        // SET THE ANSWER LIST
        try {
            const dataAnswers = await getDocs(answerCollectionRef);
            const filteredDataAnswers = dataAnswers.docs.map((doc) =>({
                ...doc.data(),id:doc.id}))
            console.log(filteredDataAnswers);
            setAnswerList(filteredDataAnswers);

            // Separate answers into correct and incorrect
            const correctAnswer = filteredDataAnswers.filter(answer => answer.correct);
            const incorrectAnswer = filteredDataAnswers.filter(answer => !answer.correct);

            setCorrectAnswers(correctAnswer);
            setIncorrectAnswers(incorrectAnswer);
            
        } catch (err) {
            console.error(err);
        }
    }
    getAnswerList();
    useEffect(() => {
        getAnswerList();
    },[])

    // New Answer

    const onSubmitAnswer = async () => {
        try {
            await addDoc(answerCollectionRef,{
                answerName:newAnswer,
                correct:isAnswerCorrect
            })

            getAnswerList();
        } catch (err) {
            console.error(err);
        }
    }

    const deleteAnswer = async (id) => {
        const answerDoc = doc(db,"answers", id);
        await deleteDoc(answerDoc);
    }

    const [newAnswer, setAnswer] = useState("");
    const [isAnswerCorrect, setIsAnswerCorrect] = useState(false);

return (
    <div>
        <h1>Correct Answers</h1>
        {correctAnswers.map((answer) => (
            <div key={answer.id}>
                <h2 style={{ color: "green" }}>{answer.answerName}</h2> <button onClick={() => deleteAnswer(answer.id)}>Delete</button>
                <p style={{ color: "black" }}>
                    Options: {Array.isArray(answer.testOptions) ? answer.testOptions.join(", ") : answer.testOptions}
                </p>
                <p style={{ color: "black" }}>
                    Question Template: {answer.testQuestionTemplate?._key?.path?.segments?.slice(-1)[0]}
                </p>
            </div>
        ))}
        
        <h1>Incorrect Answers</h1>
        {incorrectAnswers.map((answer) => (
            <div key={answer.id}>
                <h2 style={{ color: "red" }}>{answer.answerName}</h2> <button onClick={() => deleteAnswer(answer.id)}>Delete</button>
                <p style={{ color: "black" }}>
                    Options: {Array.isArray(answer.testOptions) ? answer.testOptions.join(", ") : answer.testOptions}
                </p>
                <p style={{ color: "black" }}>
                    Question Template: {answer.testQuestionTemplate?._key?.path?.segments?.slice(-1)[0]}
                </p>

            </div>
        ))}

        <h1>Totals</h1>
        <h3 style={{ color: "green" }}>
            Total correct answers: {correctAnswers.length}
        </h3>
        <h3 style={{ color: "red" }}>
            Total incorrect answers: {incorrectAnswers.length}
        </h3>
        <h3 style={{ color: "black" }}>
            Total percentage correct: {(correctAnswers.length/(incorrectAnswers.length + correctAnswers.length)* 100).toFixed(2) + '%'}
        </h3>

        <h1>Create new entry</h1>
        <input placeholder = "Answer" 
        onChange={(inputEvent) => setAnswer(inputEvent.target.value)}/>
        <input type = "checkbox" 
        checked={isAnswerCorrect}
        onChange={(inputEvent) => setIsAnswerCorrect(inputEvent.target.checked)}/>
        <label>Correct</label>
        <button onClick={onSubmitAnswer}>Submit answer</button>
    </div>
);
}