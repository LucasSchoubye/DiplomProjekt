// ClassStats.js
import React, { useMemo } from 'react';
import PropTypes from 'prop-types';
import { formatSubtopic } from '../utils/textUtils';
import MedianAnswerTimeChart from './charts/MedianAnswerTimeChart';
import SubtopicBarChart from './charts/SubtopicBarChart';
import OverallStackedBarChart from './charts/OverallStackedBarChart';
import MedianCorrectIncorrectTimeChart from './charts/MedianCorrectIncorrectTimeChart';
import {
    calculateBasicStats,
    calculateSubtopicData,
    calculateAnswerTimeData,
    calculateMedianAnswerTimeData
} from './stats/statsCalculations';
import './studentStats.css';

const ClassStats = ({ classAnswersMap }) => {
    const classAnswers = useMemo(() => 
        Object.values(classAnswersMap).flatMap(studentAnswers =>
            Object.values(studentAnswers).flat()
        ), [classAnswersMap]);

    const { averageAnswerTime, data } = useMemo(() => calculateBasicStats(classAnswers), [classAnswers]);
    const subtopicData = useMemo(() => calculateSubtopicData(classAnswers), [classAnswers]);
    const answerTimeData = useMemo(() => calculateAnswerTimeData(classAnswers), [classAnswers]);
    const medianAnswerTimeData = useMemo(() => calculateMedianAnswerTimeData(classAnswers), [classAnswers]);

    return (
        <div className="student-stats">
            <h3>Class Statistics</h3>
            <div className="stats-details">
                <p>
                    <strong>Average Answer Time:</strong> 
                    <span className="average-answer-time"> {averageAnswerTime.toFixed(2)} seconds</span>
                </p>
            </div>

            <div className="charts-container">
                <OverallStackedBarChart data={data} />
                <SubtopicBarChart data={subtopicData} />
                <MedianAnswerTimeChart data={answerTimeData} />
                <MedianCorrectIncorrectTimeChart data={medianAnswerTimeData} />
            </div>
        </div>
    );
};

ClassStats.propTypes = {
    classAnswersMap: PropTypes.object.isRequired,
};

export default ClassStats;