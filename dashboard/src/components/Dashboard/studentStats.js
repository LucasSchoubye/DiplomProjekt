import React, { useMemo } from 'react';
import PropTypes from 'prop-types';
import { formatSubtopic } from '../utils/textUtils';
import SubtopicBarChart from './charts/SubtopicBarChart';
import MedianAnswerTimeChart from './charts/MedianAnswerTimeChart';
import OverallStackedBarChart from './charts/OverallStackedBarChart';
import './studentStats.css'; // Assuming you have a CSS file for styles

const StudentStats = ({ answerMap, contextType }) => {
    // Flatten the answerMap into a single array of answers
    const answers = useMemo(() => Object.values(answerMap).flat(), [answerMap]);

    // Calculate the number of correct and incorrect answers
    const totalAnswers = answers.length;
    const correctAnswers = answers.filter(({ correct }) => correct === 1).length;
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

    // Calculate statistics per subtopic
    const answerTimeData = useMemo(() => {
        const questionTimeMap = {};
        answers.forEach(({ subtopic, answerTime }) => {
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
    }, [answers]);

    // Add new calculation for subtopic statistics
    const subtopicData = useMemo(() => {
        const subtopicStats = {};
        answers.forEach(({ subtopic, correct }) => {
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
    }, [answers]);

    const COLORS = ['#8884d8', '#82ca9d', '#ffc658', '#ff6666', '#66b366'];

    return (
        <div className="student-stats">
            <h3>Student Statistics</h3>
            <div className="stats-details">
                <p><strong>Context Type:</strong> {contextType}</p>
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

            <div className="charts-container">
                <OverallStackedBarChart data={data} />
                <SubtopicBarChart data={subtopicData} />
                <MedianAnswerTimeChart data={answerTimeData} />
            </div>
        </div>
    );
};

StudentStats.propTypes = {
    answerMap: PropTypes.object.isRequired,
    contextType: PropTypes.string.isRequired,
};

export default StudentStats;
