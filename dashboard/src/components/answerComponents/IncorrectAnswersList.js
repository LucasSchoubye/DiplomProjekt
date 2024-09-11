import React from 'react';
import AnswerItem from './answerItem';

const IncorrectAnswersList = ({ incorrectAnswers, onDelete }) => {
    return (
        <div>
            <h1>Incorrect Answers</h1>
            {incorrectAnswers.map((answer) => (
                <AnswerItem key={answer.id} answer={answer} onDelete={onDelete} />
            ))}
        </div>
    );
};

export default IncorrectAnswersList;