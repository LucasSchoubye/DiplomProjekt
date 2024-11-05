import React from 'react';
import { BarChart, Bar, XAxis, YAxis, Tooltip, Legend, ResponsiveContainer } from 'recharts';

const StudentStats = ({ answerMap, contextType }) => {
    // Flatten the answerMap into a single array of answers
    const answers = Object.values(answerMap).flat();

    // Calculate the number of correct and incorrect answers
    const totalAnswers = answers.length;
    const correctAnswers = answers.filter(answer => answer.correct === 1).length;
    const incorrectAnswers = totalAnswers - correctAnswers;
    const percentageCorrect = totalAnswers > 0 ? (correctAnswers / totalAnswers) * 100 : 0;

    // Data for the stacked bar chart
    const data = [
        {
            name: 'Answers',
            Correct: correctAnswers,
            Incorrect: incorrectAnswers,
        }
    ];

    return (
        <div style={{ flexGrow: 1 }}>
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

            {/* Stacked Bar Chart */}
            <ResponsiveContainer width="15%" height={500}>
                <BarChart data={data}>
                    <XAxis type="category" dataKey="name" />
                    <YAxis type="number" />
                    <Tooltip />
                    <Legend />
                    <Bar dataKey="Correct" stackId="a" fill="green" opacity={0.6} />
                    <Bar dataKey="Incorrect" stackId="a" fill="red" opacity={0.6}/>
                </BarChart>
            </ResponsiveContainer>
        </div>
    );
};

export default StudentStats;
