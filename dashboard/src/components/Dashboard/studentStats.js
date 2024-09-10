import React from 'react';

const StudentStats = ({ answerMap }) => {
    // Flatten the answerMap into a single array of answers
    const answers = Object.values(answerMap).flat();

    return (
        <div style={{ marginLeft: '20px', padding: '10px', border: '1px solid #ddd', borderRadius: '5px' }}>
            <h3>Answers</h3>
            <ul>
                {answers.map((answer, index) => (
                    <li
                        key={index}
                        style={{
                            color: answer.correct === 1 ? 'green' : 'red',
                            marginBottom: '10px',
                        }}
                    >
                        <p><strong>Prompt:</strong> {answer.prompt}</p>
                        <p><strong>Answer:</strong> {answer.answer}</p>
                        <p><strong>Option Chosen:</strong> {answer.optionChosen}</p>
                        <p><strong>Time:</strong> {answer.answerTime}</p>
                    </li>
                ))}
            </ul>
        </div>
    );
};

export default StudentStats;
