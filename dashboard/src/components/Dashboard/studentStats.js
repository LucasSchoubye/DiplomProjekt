import React from 'react';

const StudentStats = ({ answerMap, contextType }) => {
    // Flatten the answerMap into a single array of answers
    const answers = Object.values(answerMap).flat();

    // Calculate the number of correct and incorrect answers
    const totalAnswers = answers.length;
    const correctAnswers = answers.filter(answer => answer.correct === 1).length;
    const incorrectAnswers = totalAnswers - correctAnswers;
    const percentageCorrect = totalAnswers > 0 ? (correctAnswers / totalAnswers) * 100 : 0;

    return (
        <div style={{ flexGrow: 1}}>
            <h3>Student Statistics</h3>
            <div style={{ marginBottom: '10px' }}>
                <p><strong>Context Type:</strong> {contextType}</p>
                <p><strong>Total Answers:</strong> {totalAnswers}</p>
                <p>
                    <span style={{ color: 'green' }}>
                        Correct Answers: {correctAnswers}
                    </span>
                </p>
                <p>
                    <span style={{ color: 'red' }}>
                        Incorrect Answers: {incorrectAnswers}
                    </span>
                </p>
                <p>
                    <strong>Percentage of Correct Answers:</strong> 
                    <span style={{ color: 'black' }}> {percentageCorrect.toFixed(2)}%</span>
                </p>
            </div>
        </div>
    );
};

export default StudentStats;
