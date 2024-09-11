import React from 'react';
import AnswerItem from './answerItem';

const CorrectAnswersList = ({ correctAnswers, onDelete }) => {
    return (
        <div>
            <h1>Correct Answers</h1>
            {correctAnswers.map((answer) => (
                <AnswerItem key={answer.id} answer={answer} onDelete={onDelete} />
            ))}
        </div>
    );
};

export default CorrectAnswersList;