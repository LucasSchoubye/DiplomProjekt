// ClassStats.js
import React, { useMemo } from 'react';
import { BarChart, Bar, XAxis, YAxis, Tooltip, Legend, ResponsiveContainer, Cell, ComposedChart, Customized } from 'recharts';
import PropTypes from 'prop-types';
import { formatSubtopic } from '../utils/textUtils';
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

    // Calculate the average answerTime
    const totalAnswerTime = classAnswers.reduce((sum, { answerTime }) => sum + answerTime, 0);
    const averageAnswerTime = totalAnswers > 0 ? (totalAnswerTime / totalAnswers).toFixed(2) : '0.00';

    // Data for the stacked bar chart
    const data = [
        {
            name: 'Answers',
            Correct: correctAnswers,
            Incorrect: incorrectAnswers,
        }
    ];

    // Calculate statistics per subtopic for stacked bar chart
    const subtopicData = useMemo(() => {
        const subtopicStats = {};
        classAnswers.forEach(({ subtopic, correct }) => {
            if (!subtopicStats[subtopic]) {
                subtopicStats[subtopic] = { name: subtopic, Correct: 0, Incorrect: 0 };
            }
            if (correct === 1) {
                subtopicStats[subtopic].Correct++;
            } else {
                subtopicStats[subtopic].Incorrect++;
            }
        });
        return Object.values(subtopicStats);
    }, [classAnswers]);

    // Calculate statistics per subtopic
    const answerTimeData = useMemo(() => {
        const questionTimeMap = {};
        classAnswers.forEach(({ subtopic, answerTime }) => {
            if (!questionTimeMap[subtopic]) {
                questionTimeMap[subtopic] = [];
            }
            questionTimeMap[subtopic].push(answerTime);
        });
        return Object.keys(questionTimeMap).map(subtopic => {
            const times = questionTimeMap[subtopic].sort((a, b) => a - b);
            const mid = Math.floor(times.length / 2);
            const medianTime =
                times.length % 2 !== 0
                    ? times[mid]
                    : (times[mid - 1] + times[mid]) / 2;
            return {
                subtopic,
                medianTime: medianTime.toFixed(2),
            };
        });
    }, [classAnswers]);

    const COLORS = ['#8884d8', '#82ca9d', '#ffc658', '#ff6666', '#66b366'];

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
                <p>
                    <strong>Average Answer Time:</strong> 
                    <span className="average-answer-time"> {averageAnswerTime} seconds</span>
                </p>
            </div>

            <div className="charts-container">
                {/* Stacked Bar Chart */}
                <ResponsiveContainer width="15%" height={500}>
                    <BarChart data={data}>
                        <XAxis type="category" dataKey="name" />
                        <YAxis type="number" />
                        <Tooltip />
                        <Legend />
                        <Bar dataKey="Correct" stackId="a" fill="#66b366" />
                        <Bar dataKey="Incorrect" stackId="a" fill="#ff6666" />
                    </BarChart>
                </ResponsiveContainer>

                {/* Stacked Bar Chart by Subtopic */}
                <ResponsiveContainer width="30%" height={500}>
                    <BarChart data={subtopicData}>
                        <XAxis dataKey="name" tickFormatter={formatSubtopic} />
                        <YAxis />
                        <Tooltip />
                        <Legend />
                        <Bar dataKey="Correct" stackId="a" fill="#66b366" />
                        <Bar dataKey="Incorrect" stackId="a" fill="#ff6666" />
                    </BarChart>
                </ResponsiveContainer>

                {/* Bar Chart for Median Answer Time */}
                <ResponsiveContainer width="30%" height={500}>
                    <BarChart data={answerTimeData}>
                        <XAxis xAxisId="0" dataKey="subtopic" tickFormatter={formatSubtopic} label={{ value: 'Question Type', position: 'insideBottom', offset: -2 }} />
                        <YAxis label={{ value: 'Median Time (s)', angle: -90, position: 'insideLeft' }} />
                        <Tooltip />
                        <Bar dataKey="medianTime">
                            {answerTimeData.map((entry, index) => (
                                <Cell key={`cell-${index}`} fill={COLORS[index % COLORS.length]} />
                            ))}
                        </Bar>
                    </BarChart>
                </ResponsiveContainer>
            </div>
        </div>
    );
};

ClassStats.propTypes = {
    classAnswersMap: PropTypes.object.isRequired,
};

export default ClassStats;
