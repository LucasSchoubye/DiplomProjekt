import React from 'react';

const AnswerItem = ({ answer, onDelete }) => {
    return (
        <div>
            <h2 style={{ color: answer.correct ? "green" : "red" }}>{answer.answerName}</h2> 
            <button onClick={() => onDelete(answer.id)}>Delete</button>
            <p style={{ color: "black" }}>
                Options: {Array.isArray(answer.testOptions) ? answer.testOptions.join(", ") : answer.testOptions}
            </p>
            <p style={{ color: "black" }}>
                Question Template: {answer.testQuestionTemplate?._key?.path?.segments?.slice(-1)[0]}
            </p>
        </div>
    );
};

export default AnswerItem;