// ClassStats.js
import React, { useMemo } from 'react';
import { BarChart, Bar, XAxis, YAxis, Tooltip, Legend, ResponsiveContainer } from 'recharts';
import PropTypes from 'prop-types';
import './studentStats.css';

const ClassStats = ({ classAnswersMap }) => {
    // Flatten the classAnswersMap into a single array of answers
    const classAnswers = useMemo(() => 
        Object.values(classAnswersMap).flatMap(studentAnswers =>
            Object.values(studentAnswers).flat()
        ), [classAnswersMap]);

    // Calculate the number of correct and incorrect answers
    const totalAnswers = classAnswers.length;
    const correctAnswers = classAnswers.filter(({ correct }) => correct === 1).length;
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
        <div className="student-stats">
            <h3>Class Statistics</h3>
            <div className="stats-details">
                <p><strong>Total Answers:</strong> {totalAnswers}</p>
                <p>
                    <span className="correct-answers">
                        Correct Answers: {correctAnswers}
                    </span>
                </p>
                <p>
                    <span className="incorrect-answers">
                        Incorrect Answers: {incorrectAnswers}
                    </span>
                </p>
                <p>
                    <strong>Percentage of Correct Answers:</strong> 
                    <span className="percentage-correct"> {percentageCorrect.toFixed(2)}%</span>
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

ClassStats.propTypes = {
    classAnswersMap: PropTypes.object.isRequired,
};

export default ClassStats;
